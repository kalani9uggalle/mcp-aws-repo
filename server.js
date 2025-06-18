import express from "express";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { HTTPStreamTransport } from "@modelcontextprotocol/sdk/server/http.js";

const app = express();
const server = new McpServer({ name: "render-mcp-server", version: "1.0.0" });

// Example tool: echo input arguments
server.registerTool(
  "echo",
  {
    title: "Echo Tool",
    description: "Echo back arguments",
    inputSchema: {
      text: { type: "string", description: "Text to echo" }
    }
  },
  async ({ text }) => ({ type: "text", text })
);

app.use("/mcp", new HTTPStreamTransport({ server }).middleware());

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`MCP server running at http://localhost:${port}/mcp`);
});
