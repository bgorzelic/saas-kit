# SaaS Kit - Project Memory

## Project Overview
This is a modern SaaS starter template built with:
- **Frontend**: SvelteKit + TailwindCSS
- **Backend**: Cloudflare Workers, D1 (SQLite), R2, KV
- **AI Integration**: Anthropic Claude SDK with agent capabilities
- **Architecture**: Monorepo using pnpm workspaces

## Project Structure
```
saas-kit/
├── apps/
│   └── user-application/     # Main SvelteKit app
├── packages/
│   ├── data-service/         # Database & API layer
│   └── shared/               # Shared utilities
├── .claude/
│   └── agents/               # 85+ specialized AI agents
└── scripts/
    └── init-template.sh      # Template initialization
```

## Key Features
- **Template System**: Designed to be cloned and customized for new SaaS projects
- **AI Agents**: Comprehensive library of specialized agents for development tasks
- **Environment Configuration**: Template-based setup with .env.example files
- **MCP Integration**: Configured for enhanced development workflow

## Development Workflow
- Uses pnpm for package management
- Monorepo structure with workspace dependencies
- Cloudflare Workers for serverless backend
- Local development with Wrangler

## Important Files
- `TEMPLATE_USAGE.md` - Complete template usage guide
- `SETUP.md` - Step-by-step setup instructions
- `AGENTS_INTEGRATION.md` - AI integration guide
- `MCP_SETUP.md` - MCP server configuration
- `.mcp.json` - MCP server configuration (uses template paths)
- `init-template.sh` - Automated project initialization script

## Session Context Guidelines
When resuming sessions:
1. Always check current git status and branch
2. Review recent commits for context
3. Check for any uncommitted changes
4. Verify pnpm dependencies are installed
5. Reference TEMPLATE_USAGE.md for project-specific patterns

## Development Conventions
- Use pnpm for all package operations
- Follow existing code structure in apps/packages
- Maintain template flexibility (avoid hardcoding project-specific values)
- Document significant changes in commit messages
- Use conventional commits with co-author credit

## AI Agent Library
Located in `.claude/agents/`, includes specialized agents for:
- Language specialists (Python, JS/TS, Go, Rust, Java, etc.)
- Development roles (frontend, backend, fullstack, mobile)
- DevOps & Cloud (Kubernetes, Terraform, deployment)
- Data & ML (engineering, ops, data science)
- Security (auditing, incident response)
- SEO (10+ specialized SEO agents)
- Business & support roles

## Environment Variables
Template uses placeholder values in:
- `.env.example` - Application environment template
- `.dev.vars.example` - Cloudflare dev vars template
- `.mcp.json` - MCP configuration (path-agnostic)

## Git Workflow
- Main branch for stable template
- Commit messages follow conventional commits
- Include Claude co-author attribution
- Keep .gitignore updated for security (.dev.vars, .env)

## Next Steps for New Projects
1. Run `pnpm run init` to initialize from template
2. Configure environment variables
3. Customize branding and content
4. Set up MCP servers as needed
5. Deploy to Cloudflare
