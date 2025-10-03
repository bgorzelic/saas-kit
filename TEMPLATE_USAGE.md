# 🎨 SaaS Kit Template Usage Guide

This repository is a **template** for building modern SaaS applications. Follow these steps to create a new project from this template.

## Quick Start (Automated)

```bash
# 1. Clone the template
git clone https://github.com/bgorzelic/saas-kit.git my-new-saas
cd my-new-saas

# 2. Run the initialization script
./scripts/init-template.sh

# 3. Follow the prompts to customize your project
# The script will ask for:
# - Project name
# - Description
# - Author name
# - Database choice (PlanetScale/Neon)
# - Whether you'll use Polar.sh for payments

# 4. Install dependencies
pnpm install

# 5. Configure your API keys in .dev.vars files
# Edit apps/user-application/.dev.vars
# Edit apps/data-service/.dev.vars

# 6. Start developing!
pnpm -w run dev:user-application
```

## Manual Setup (Alternative)

If you prefer to set up manually:

### 1. Clone and Customize

```bash
# Clone the repo
git clone https://github.com/bgorzelic/saas-kit.git my-new-saas
cd my-new-saas

# Remove git history to start fresh
rm -rf .git
git init
git add .
git commit -m "Initial commit from saas-kit template"
```

### 2. Update Project Metadata

Edit `package.json`:
```json
{
  "name": "my-new-saas",
  "description": "My awesome SaaS application",
  "author": "Your Name"
}
```

### 3. Update Cloudflare Worker Names

Edit `apps/user-application/wrangler.jsonc`:
```jsonc
{
  "name": "my-new-saas", // Change this
  ...
}
```

Edit `apps/data-service/wrangler.jsonc`:
```jsonc
{
  "name": "my-new-saas-data-service", // Change this
  ...
}
```

### 4. Configure Environment Variables

```bash
# Copy example files
cp apps/user-application/.dev.vars.example apps/user-application/.dev.vars
cp apps/data-service/.dev.vars.example apps/data-service/.dev.vars

# Edit with your API keys
nano apps/user-application/.dev.vars
```

### 5. Update MCP Configuration (Optional)

Edit `.mcp.json` and replace `${PROJECT_DIR}` with your project path:
```json
{
  "filesystem": {
    "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/your/project"]
  }
}
```

## What's Included

### Core Features
- ✅ **TanStack Start** - Full-stack React framework
- ✅ **Cloudflare Workers** - Edge deployment
- ✅ **Better Auth** - Authentication with OAuth support
- ✅ **Drizzle ORM** - Type-safe database queries
- ✅ **Anthropic Claude** - AI agent integration
- ✅ **Polar.sh** - Payment processing (optional)
- ✅ **Tailwind CSS v4** - Modern styling
- ✅ **Shadcn/UI** - Component library

### Pre-configured Integrations
- Authentication middleware
- AI agent server functions
- Database connection setup
- Payment processing hooks
- MCP server configuration

## Template Customization Checklist

- [ ] Run `./scripts/init-template.sh` OR manually update all configs
- [ ] Update `package.json` with your project details
- [ ] Change Cloudflare Worker names in `wrangler.jsonc` files
- [ ] Configure `.dev.vars` with your API keys
- [ ] Update `README.md` with your project specifics
- [ ] Set up your chosen database (PlanetScale/Neon)
- [ ] Configure OAuth providers if using authentication
- [ ] Update MCP config with your project path
- [ ] Customize branding (logos, colors, metadata)
- [ ] Set up GitHub repository and push

## Environment Variables Reference

### Required for All Projects
```bash
ANTHROPIC_API_KEY=sk-ant-...  # Get from https://console.anthropic.com
```

### Required for Database
**Option 1: PlanetScale (MySQL)**
```bash
DATABASE_HOST=aws.connect.psdb.cloud
DATABASE_USERNAME=your_username
DATABASE_PASSWORD=pscale_pw_...
```

**Option 2: Neon (PostgreSQL)**
```bash
DATABASE_URL=postgresql://user:pass@host/db
```

### Optional Services
```bash
POLAR_SECRET=polar_...        # For payment processing
GITHUB_TOKEN=ghp_...           # For GitHub MCP integration
BRAVE_API_KEY=...              # For web search MCP
```

## Customization Ideas

### Remove Features You Don't Need

**Don't need payments?**
```bash
# Remove Polar integration
pnpm remove @polar-sh/sdk @polar-sh/tanstack-start
rm apps/user-application/src/core/middleware/polar.ts
rm apps/user-application/src/core/functions/payments.ts
```

**Don't need AI features?**
```bash
# Remove Anthropic integration
pnpm remove @anthropic-ai/sdk
rm apps/user-application/src/core/middleware/anthropic.ts
rm apps/user-application/src/core/functions/agents.ts
rm apps/data-service/src/services/agent.ts
```

### Add More Features

**Add more Shadcn components:**
```bash
cd apps/user-application
pnpx shadcn@latest add button card dialog form
```

**Add more database tables:**
```bash
# Edit packages/data-ops/src/drizzle/schema.ts
# Then generate migrations
cd packages/data-ops
pnpm run drizzle:generate
```

## Deployment Workflow

### First Time Setup

1. **Connect to Cloudflare:**
   ```bash
   wrangler login
   ```

2. **Create D1 Database (if needed):**
   ```bash
   wrangler d1 create my-saas-db
   ```

3. **Set Production Secrets:**
   ```bash
   wrangler secret put ANTHROPIC_API_KEY
   wrangler secret put DATABASE_PASSWORD
   wrangler secret put POLAR_SECRET
   ```

### Deploy

```bash
# Deploy user application
pnpm run deploy:user-application

# Deploy data service
pnpm run deploy:data-service
```

## Best Practices for Your Template Projects

1. **Keep the template updated** - Periodically pull updates from this repo
2. **Branch for experiments** - Use git branches to test major changes
3. **Document customizations** - Keep notes on what you've changed
4. **Use environment-specific configs** - Separate dev/staging/prod settings
5. **Version your API keys** - Use different keys for each environment

## Getting Help

- **Template Issues**: https://github.com/bgorzelic/saas-kit/issues
- **TanStack Docs**: https://tanstack.com/start
- **Cloudflare Docs**: https://developers.cloudflare.com
- **Anthropic Docs**: https://docs.anthropic.com

## Template Updates

To pull the latest template improvements:

```bash
# Add the template as a remote
git remote add template https://github.com/bgorzelic/saas-kit.git

# Fetch and merge updates
git fetch template
git merge template/main --allow-unrelated-histories

# Resolve any conflicts and commit
```

---

**Happy building! 🚀**

If you create something cool with this template, let me know! I'd love to see what you build.
