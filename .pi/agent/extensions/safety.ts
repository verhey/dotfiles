import {
  isToolCallEventType,
  type ExtensionAPI,
  type ExtensionContext,
  type ToolCallEvent,
} from "@earendil-works/pi-coding-agent";
import { homedir } from "node:os";
import { basename, isAbsolute, relative, resolve } from "node:path";

const home = homedir();
const protectedDirectoryNames = [".ssh", ".aws", ".kube"];
const protectedFileNames = [".npmrc", ".git-credentials"];
const sensitiveHomePaths = [...protectedDirectoryNames, ...protectedFileNames, ".config/gh"];
const protectedDirectories = protectedDirectoryNames.map((name) => resolve(home, name));
const protectedFiles = new Set(protectedFileNames.map((name) => resolve(home, name)));
const ghConfigDirectory = resolve(home, ".config", "gh");
const forbiddenCommands = /\b(?:aws|terraform|curl|wget|nc|ssh)\b/i;

function isWithin(path: string, directory: string): boolean {
  const pathFromDirectory = relative(directory, path);
  return pathFromDirectory === "" || (!pathFromDirectory.startsWith("..") && !isAbsolute(pathFromDirectory));
}

function isSensitivePath(path: string, cwd: string): boolean {
  const absolutePath = resolve(cwd, path.replace(/^~(?=$|\/)/, home));
  const fileName = basename(absolutePath);

  return (
    protectedFiles.has(absolutePath) ||
    protectedDirectories.some((directory) => isWithin(absolutePath, directory)) ||
    isWithin(absolutePath, ghConfigDirectory) ||
    fileName === ".env" ||
    fileName.startsWith(".env.")
  );
}

function escapeRegex(value: string): string {
  return value.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}

function bashReferencesSensitivePath(command: string): boolean {
  const homeReference = `(?:${escapeRegex(home)}|~|\\$HOME|\\$\\{HOME\\})`;
  const sensitiveLocation = new RegExp(
    `${homeReference}/(?:${sensitiveHomePaths.map((path) => `${escapeRegex(path)}(?:/|\\b)`).join("|")})`,
  );
  const envFile = /(?:^|[\s"'=\/])\.env(?:\.[^\s"']*)?(?=$|[\s"'])/;
  return sensitiveLocation.test(command) || envFile.test(command);
}

export default function safetyExtension(pi: ExtensionAPI) {
  pi.on("tool_call", async (event: ToolCallEvent, ctx: ExtensionContext) => {
    if (isToolCallEventType("bash", event)) {
      if (forbiddenCommands.test(event.input.command)) {
        return { block: true, reason: "Command is blocked by the global safety policy." };
      }
      if (bashReferencesSensitivePath(event.input.command)) {
        return { block: true, reason: "Access to a sensitive path is blocked by the global safety policy." };
      }
      return;
    }

    if (
      !isToolCallEventType("read", event) &&
      !isToolCallEventType("edit", event) &&
      !isToolCallEventType("write", event) &&
      !isToolCallEventType("grep", event) &&
      !isToolCallEventType("find", event) &&
      !isToolCallEventType("ls", event)
    ) {
      return;
    }

    if (isSensitivePath(event.input.path, ctx.cwd)) {
      return { block: true, reason: "Access to a sensitive path is blocked by the global safety policy." };
    }
  });
}
