# MCP Server Configuration

This project includes Model Context Protocol (MCP) servers for enhanced development workflows.

## Configured MCP Servers

### 1. **Filesystem Server** (Enabled)
- **Purpose**: Direct access to project files
- **Usage**: Reading, writing, and managing project files
- **Scope**: `/Users/bgorzelic/dev/projects/research/saas-kit/saas-kit`

### 2. **GitHub Server** (Enabled)
- **Purpose**: Repository management and GitHub API access
- **Setup**: Set `GITHUB_TOKEN` environment variable
- **Get Token**: https://github.com/settings/tokens (needs `repo` scope)

### 3. **Sequential Thinking** (Enabled)
- **Purpose**: Enhanced reasoning for complex architectural decisions
- **Usage**: Automatic - improves Claude's problem-solving capabilities

### 4. **PostgreSQL Server** (Disabled by default)
- **Purpose**: Direct database access and migrations
- **Enable**: Remove `"disabled": true` and set `DATABASE_URL`
- **Format**: `postgresql://user:password@host:port/database`

### 5. **Brave Search** (Disabled by default)
- **Purpose**: Web search for documentation and best practices
- **Enable**: Get API key from https://brave.com/search/api/
- **Setup**: Set `BRAVE_API_KEY` environment variable

## Quick Setup

### 1. Add to Claude Desktop config
```bash
# macOS
nano ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Copy contents from .mcp.json to the "mcpServers" section
```

### 2. Set Environment Variables
```bash
# Add to your shell profile (.zshrc, .bashrc, etc.)
export GITHUB_TOKEN="ghp_your_token_here"
export DATABASE_URL="postgresql://user:pass@host/db"  # Optional
export BRAVE_API_KEY="your_brave_api_key"  # Optional
```

### 3. Restart Claude Desktop
Required after configuration changes.

## Project-Specific MCP Ideas

### Custom MCP Server Ideas for Your SaaS:

1. **Auth Management Server**
   - Manage Better Auth configurations
   - User session debugging
   - OAuth provider setup

2. **Database Migration Server**
   - Run Drizzle migrations
   - Schema introspection
   - Seed data management

3. **Cloudflare Deployment Server**
   - Deploy to staging/production
   - Manage environment variables
   - View deployment logs

4. **Agent Management Server**
   - Test Anthropic prompts
   - Monitor API usage
   - Conversation history access

Would you like me to create any of these custom MCP servers for your project?

## Testing Your MCP Setup

Once configured, you can test by asking Claude to:
- "List all TypeScript files in the project"
- "Show me recent commits"
- "Search for authentication best practices"

## Resources

- [MCP Documentation](https://modelcontextprotocol.io)
- [Available MCP Servers](https://github.com/modelcontextprotocol/servers)
- [Building Custom MCP Servers](https://modelcontextprotocol.io/docs/tools/building)
