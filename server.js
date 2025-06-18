import express from "express";
import { spawn } from "child_process";
import {
  McpServer,
} from "@modelcontextprotocol/sdk/server/mcp.js";
import {
  StdioServerTransport,
  StreamableHTTPServerTransport
} from "@modelcontextprotocol/sdk/server/streamableHttp.js";

const app = express();

// Spawn AWS docs MCP as a stdio subprocess
const subprocess = spawn("uvx", ["awslabs.aws-documentation-mcp-server@latest"], {
  env: { FASTMCP_LOG_LEVEL: "ERROR", AWS_DOCUMENTATION_PARTITION: "aws" },
  stdio: ["pipe", "pipe", "inherit"],
});

const server = McpServer.fromStdio({ read: subprocess.stdout, write: subprocess.stdin });

// Expose via HTTP stream
const transport = new StreamableHTTPServerTransport({ server });
app.use("/mcp", transport.middleware());
app.get("/health", (_req, res) => res.send("OK"));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () =>
  console.log(`➡️ AWS Docs MCP available at http://localhost:${PORT}/mcp`)
);
