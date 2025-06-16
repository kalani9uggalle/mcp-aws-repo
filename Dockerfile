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

# 3. Install uv (the modern replacement for uvx command) and your specific MCP server package
#    We are replacing 'uvx' with 'uv' here.
RUN pip install --no-cache-dir uv awslabs.aws-documentation-mcp-server

# Define environment variables required by your MCP server
ENV FASTMCP_LOG_LEVEL=ERROR
ENV AWS_DOCUMENTATION_PARTITION=aws

# Expose the port where your MCP server listens.
EXPOSE 8080 

# Command to run your MCP server.
# Crucially, change "uvx" to "uv" in your CMD instruction.
CMD ["uv", "run", "awslabs.aws-documentation-mcp-server", "--host", "0.0.0.0", "--port", "8080"]
