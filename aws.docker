# Use an appropriate base image. If your MCP server is Python-based,
# python:3.9-slim-buster or a similar Python image is good.
FROM python:3.9-slim-buster

# Set the working directory inside the container
WORKDIR /app

# Install uvx and your specific MCP server package
# Assuming 'awslabs.aws-documentation-mcp-server' is a PyPI package
# You might need to add other system dependencies if your MCP server requires them (e.g., RUN apt-get update && apt-get install -y some-lib)
RUN pip install uvx awslabs.aws-documentation-mcp-server

# Define environment variables required by your MCP server
ENV FASTMCP_LOG_LEVEL=ERROR
ENV AWS_DOCUMENTATION_PARTITION=aws
# IMPORTANT: Do NOT hardcode sensitive credentials here. Use Render's environment variables for secrets.

# Expose the port where your MCP server listens.
# MCP servers often listen on 8080 or 9000. Verify the actual port.
# If your uvx server needs a different port, change this.
EXPOSE 8080 

# Command to run your MCP server using uvx.
# Crucially, tell uvx to bind to 0.0.0.0 so it's accessible within the container.
CMD ["uvx", "awslabs.aws-documentation-mcp-server", "--host", "0.0.0.0", "--port", "8080"]
