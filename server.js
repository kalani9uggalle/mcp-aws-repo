import express from "express";
import { spawn } from "child_process";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { StreamableHTTPServerTransport } from "@modelcontextprotocol/sdk/server/streamableHttp.js";

const app = express();

// Spawn AWS docs MCP stdio subprocess
const subprocess = spawn("uvx", ["awslabs.aws-documentation-mcp-server@latest"], {
  stdio: ["pipe", "pipe", "inherit"],
});
const server = McpServer.fromStdio({
  read: subprocess.stdout,
  write: subprocess.stdin
});

// Wrap stdio MCP in a streamable HTTP endpoint
const transport = new StreamableHTTPServerTransport({ server });
app.use("/mcp", transport.middleware());
app.get("/health", (_req, res) => res.send("OK"));

const port = process.env.PORT || 3000;
app.listen(port, () =>
  console.log(`🚀 AWS Docs MCP server at http://localhost:${port}/mcp`)
);
import express from "express";
import { spawn } from "child_process";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { StreamableHTTPServerTransport } from "@modelcontextprotocol/sdk/server/streamableHttp.js";

const app = express();

// Spawn AWS docs MCP stdio subprocess
const subprocess = spawn("uvx", ["awslabs.aws-documentation-mcp-server@latest"], {
  stdio: ["pipe", "pipe", "inherit"],
});
const server = McpServer.fromStdio({
  read: subprocess.stdout,
  write: subprocess.stdin
});

// Wrap stdio MCP in a streamable HTTP endpoint
const transport = new StreamableHTTPServerTransport({ server });
app.use("/mcp", transport.middleware());
app.get("/health", (_req, res) => res.send("OK"));

const port = process.env.PORT || 3000;
app.listen(port, () =>
  console.log(`🚀 AWS Docs MCP server at http://localhost:${port}/mcp`)
);
