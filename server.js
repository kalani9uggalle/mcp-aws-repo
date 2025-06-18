import express from "express";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { HTTPStreamTransport } from "@modelcontextprotocol/sdk/server/http.js";

const app = express();
const server = new McpServer({ name: "render-mcp-server", version: "1.0.0" });

// Example tool: echo input
server.registerTool(
  "echo",
  {
    title: "Echo Tool",
    description: "Echo back text",
    inputSchema: { text: { type: "string", description: "Text to echo" } }
  },
  async ({ text }) => ({ content: [{ type: "text", text }] })
);

// Set up Streamable HTTP endpoint
app.use("/mcp", new HTTPStreamTransport({ server }).middleware());

// Optionally add health check
app.get("/health", (_req, res) => res.send("OK"));

const port = process.env.PORT || 3000;
app.listen(port, () =>
  console.log(`🚀 MCP server listening at http://localhost:${port}/mcp`)
);
