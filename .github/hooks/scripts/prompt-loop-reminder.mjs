#!/usr/bin/env node

const readStdin = async () => {
  const chunks = [];
  for await (const chunk of process.stdin) chunks.push(chunk);
  return Buffer.concat(chunks).toString("utf8");
};

const parseJson = value => {
  try {
    return JSON.parse(value);
  } catch {
    return undefined;
  }
};

const normalizeToolName = toolName => {
  if (typeof toolName !== "string") return "";
  const parts = toolName.split(/[./:]/).filter(Boolean);
  return parts.length ? parts.at(-1) : toolName;
};

const main = async () => {
  const event = parseJson(await readStdin());
  if (!event) process.exit(0);
  if (event.toolResult?.resultType !== "success") process.exit(0);

  const toolName = normalizeToolName(event.toolName);
  if (!["apply_patch", "edit", "create"].includes(toolName)) process.exit(0);

  console.log(
    "[hook][prompt-loop] Reminder: keep or add todo 'Interactively Prompt user after [current task] using prompt-user skill' and send the mandatory satisfaction prompt after delivery."
  );
};

await main();
