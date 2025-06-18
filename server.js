import express from "express";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StreamableHTTPServerTransport } from "@modelcontextprotocol/sdk/server/streamableHttp.js";

const app = express();
const server = new McpServer({ name: "render-mcp", version: "1.0.0" });

// Register a simple echo tool
server.registerTool(
  "echo",
  {
    title: "Echo Tool",
    description: "Echo back provided text",
    inputSchema: { text: { type: "string", description: "Text to echo" } }
  },
  async ({ text }) => ({ content: [{ type: "text", text }] })
);

// Attach Streamable HTTP transport at /mcp
const transport = new StreamableHTTPServerTransport({ server });
app.use("/mcp", transport.middleware());

// Add a health check for convenience
app.get("/health", (_req, res) => res.send("OK"));

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`🚀 MCP server running at http://localhost:${port}/mcp`);
});
