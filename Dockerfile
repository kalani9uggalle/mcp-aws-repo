# Use a Python version >= 3.10 as required. Python 3.11 is a good stable choice.
FROM python:3.11-slim-buster

# Set the working directory inside the container
WORKDIR /app

# 1. Update apt and install essential build tools and git.
#    build-essential: Provides compilers like gcc, needed for many Python packages with C extensions.
#    git: Sometimes needed if a dependency is specified as a git URL.
#    libffi-dev, libssl-dev: Common for network-related or cryptography libraries.
#    Other libs like libpq-dev for PostgreSQL, libmysqlclient-dev for MySQL etc. would go here if needed.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        libffi-dev \
        libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# 2. Upgrade pip, setuptools, and wheel for a robust installation environment
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# 3. Install uvx and your specific MCP server package
RUN pip install --no-cache-dir uvx awslabs.aws-documentation-mcp-server

# Define environment variables required by your MCP server
ENV FASTMCP_LOG_LEVEL=ERROR
ENV AWS_DOCUMENTATION_PARTITION=aws
# IMPORTANT: Use Render's environment variables for sensitive data like API keys.

# Expose the port where your MCP server listens.
EXPOSE 8080 

# Command to run your MCP server using uvx.
# Crucially, tell uvx to bind to 0.0.0.0 so it's accessible within the container.
CMD ["uvx", "awslabs.aws-documentation-mcp-server", "--host", "0.0.0.0", "--port", "8080"]
