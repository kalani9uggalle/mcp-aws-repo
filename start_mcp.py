import os
from fastmcp import create_mcp_app
from awslabs.aws_documentation_mcp_server import DocumentationMCPHandler

app = create_mcp_app(
    handler_cls=DocumentationMCPHandler,
    transport="streamable-http",
    partition=os.getenv("AWS_DOCUMENTATION_PARTITION", "aws"),
)
