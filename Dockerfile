# Use a Python version >= 3.10 as required by the MCP server
# Python 3.11 or 3.12 are good choices for modern applications
FROM python:3.11-slim-buster 

# Set the working directory inside the container
WORKDIR /app

# Ensure pip is up-to-date
RUN pip install --upgrade pip

# Install uvx and your specific MCP server package
# If the MCP server has system dependencies, you would add apt-get install commands here, e.g.:
# RUN apt-get update && apt-get install -y build-essential libpq-dev # Example for PostgreSQL client libs
RUN pip install uvx awslabs.aws-documentation-mcp-server

# Define environment variables required by your MCP server
ENV FASTMCP_LOG_LEVEL=ERROR
ENV AWS_DOCUMENTATION_PARTITION=aws
# IMPORTANT: Do NOT hardcode sensitive credentials here. Use Render's environment variables for secrets.

# Expose the port where your MCP server listens.
# MCP servers often listen on 8080 or 9000. Verify the actual port.
EXPOSE 8080 

# Command to run your MCP server using uvx.
# Crucially, tell uvx to bind to 0.0.0.0 so it's accessible within the container.
CMD ["uvx", "awslabs.aws-documentation-mcp-server", "--host", "0.0.0.0", "--port", "8080"]
