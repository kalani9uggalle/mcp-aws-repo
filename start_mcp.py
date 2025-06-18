# start_mcp.py
import os
import uvicorn
from fastmcp import FastMCP
from awslabs.aws_documentation_mcp_server import DocumentationMCPHandler

# Instantiate your server, passing in the AWS doc handler
mcp = FastMCP(
    name="AWS Documentation MCP",
    instructions="Serve AWS docs over MCP",
    # Tell FastMCP to delegate handling to the AWS doc handler
    tools=[DocumentationMCPHandler()],  
)

# Create a Starlette app for Streamable HTTP transport (recommended)
app = mcp.http_app()  # defaults to transport="streamable-http" and path="/mcp" :contentReference[oaicite:0]{index=0}

if __name__ == "__main__":
    # Bind to the port Render provides
    port = int(os.getenv("PORT", 8000))
    uvicorn.run(app, host="0.0.0.0", port=port)  # :contentReference[oaicite:1]{index=1}
