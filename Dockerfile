# Dockerfile.mcp-wrapper
FROM node:18-alpine

WORKDIR /app

# Install Python and UV for uvx-based servers
RUN apk add --no-cache python3 py3-pip curl bash

# Install UV (for uvx commands)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:$PATH"

# Copy package files
COPY package*.json ./
RUN npm install

# Copy wrapper script
COPY mcp-wrapper.js ./
COPY start.sh ./
RUN chmod +x start.sh

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

CMD ["./start.sh"]
