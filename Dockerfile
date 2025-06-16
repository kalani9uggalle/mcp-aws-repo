# Use a Python version >= 3.10. Python 3.11 is a good stable choice.
FROM python:3.11-slim-buster

# Set the working directory inside the container
WORKDIR /app

# 1. Update apt and install essential build tools and git.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        libffi-dev \
        libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# 2. Upgrade pip, setuptools, and wheel for a robust installation environment
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# 3. Install uv (the tool used to run the MCP server) and your specific MCP server package
RUN pip install --no-cache-dir uv awslabs.aws-documentation-mcp-server

# Define environment variables required by your MCP server
ENV FASTMCP_LOG_LEVEL=ERROR
ENV AWS_DOCUMENTATION_PARTITION=aws
# IMPORTANT: Use Render's environment variables for sensitive data like API keys.

# Expose the port where your MCP server listens.
EXPOSE 8080 

# This is the FIX: Directly start the MCP server using the 'uv run' command.
# 'uv' is the executable you installed, and 'run' is its subcommand to execute packages.
# --host 0.0.0.0 is essential for the container to listen on its network interface.
CMD ["uv", "run", "awslabs.aws-documentation-mcp-server", "--host", "0.0.0.0", "--port", "8080"]
