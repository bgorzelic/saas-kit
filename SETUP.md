# Setup Guide

Complete setup instructions for your SaaS Kit project.

## Prerequisites

- Node.js 18+ and pnpm
- Cloudflare account (free tier works)
- Anthropic API key
- Database (PlanetScale or Neon)

## Step-by-Step Setup

### 1. Clone the Template

```bash
git clone https://github.com/bgorzelic/saas-kit.git my-project
cd my-project
```

### 2. Run Template Initialization

```bash
pnpm run init
```

This will prompt you for:
- Project name
- Description
- Author
- Database choice
- Payment integration choice

### 3. Install Dependencies

```bash
pnpm install
```

### 4. Configure API Keys

#### Get Anthropic API Key
1. Sign up at https://console.anthropic.com
2. Create a new API key
3. Copy the key (starts with `sk-ant-`)

#### Set up Database

**Option A: PlanetScale (MySQL)**
1. Sign up at https://planetscale.com
2. Create a new database
3. Create a password
4. Get connection details

**Option B: Neon (PostgreSQL)**
1. Sign up at https://neon.tech
2. Create a new project
3. Copy the connection string

#### Configure .dev.vars

Edit `apps/user-application/.dev.vars`:
```bash
ANTHROPIC_API_KEY=sk-ant-your-key-here

# If using PlanetScale
DATABASE_HOST=aws.connect.psdb.cloud
DATABASE_USERNAME=your_username
DATABASE_PASSWORD=pscale_pw_xxx

# If using Neon
# DATABASE_URL=postgresql://user:pass@host/db
```

Copy the same to `apps/data-service/.dev.vars`.

### 5. Generate Database Schema

```bash
cd packages/data-ops

# Generate Better Auth tables
pnpm run better-auth:generate

# Generate database migrations
pnpm run drizzle:generate

# Run migrations
pnpm run drizzle:migrate
```

### 6. Start Development Server

```bash
# From project root
pnpm -w run dev:user-application
```

Visit http://localhost:3000

### 7. Start Data Service (Optional)

In a new terminal:
```bash
pnpm -w run dev:data-service
```

## Optional Integrations

### OAuth Authentication

Better Auth supports multiple OAuth providers. To enable:

1. **Google OAuth**
   ```bash
   # Add to .dev.vars
   GOOGLE_CLIENT_ID=your_client_id
   GOOGLE_CLIENT_SECRET=your_client_secret
   ```

2. **GitHub OAuth**
   ```bash
   # Add to .dev.vars
   GITHUB_CLIENT_ID=your_client_id
   GITHUB_CLIENT_SECRET=your_client_secret
   ```

3. Configure in `packages/data-ops/config/auth.ts`

### Polar.sh Payments

1. Sign up at https://polar.sh
2. Get your secret key
3. Add to `.dev.vars`:
   ```bash
   POLAR_SECRET=your_polar_secret
   ```

### MCP Server Integration

For enhanced Claude Code development:

1. Edit `.mcp.json` and replace `${PROJECT_DIR}` with your project path
2. Set environment variables:
   ```bash
   export GITHUB_TOKEN=ghp_your_token
   ```
3. Add config to Claude Desktop (see MCP_SETUP.md)

## Production Deployment

### 1. Login to Cloudflare

```bash
wrangler login
```

### 2. Set Production Secrets

```bash
# Set secrets for user application
cd apps/user-application
wrangler secret put ANTHROPIC_API_KEY
wrangler secret put DATABASE_HOST
wrangler secret put DATABASE_USERNAME
wrangler secret put DATABASE_PASSWORD

# Set secrets for data service
cd ../data-service
wrangler secret put ANTHROPIC_API_KEY
wrangler secret put DATABASE_HOST
wrangler secret put DATABASE_USERNAME
wrangler secret put DATABASE_PASSWORD
```

### 3. Deploy

```bash
# From project root
pnpm run deploy:user-application
pnpm run deploy:data-service
```

## Troubleshooting

### Port 3000 already in use
```bash
# Kill the process
lsof -ti:3000 | xargs kill -9

# Or change the port in apps/user-application/package.json
```

### Database connection errors
- Verify credentials in `.dev.vars`
- Check database is accessible
- For PlanetScale, ensure you're using the correct region

### Wrangler errors
```bash
# Update wrangler
pnpm add -D wrangler@latest

# Clear cache
wrangler dev --local --persist
```

### Build errors
```bash
# Clean and rebuild
rm -rf node_modules pnpm-lock.yaml
pnpm install
pnpm run setup
```

## Next Steps

1. Customize branding in `apps/user-application/public/`
2. Add your domain to Cloudflare Workers
3. Set up CI/CD with GitHub Actions
4. Configure monitoring and analytics
5. Review security best practices

## Resources

- [Template Usage Guide](TEMPLATE_USAGE.md)
- [AI Integration Guide](AGENTS_INTEGRATION.md)
- [MCP Setup](MCP_SETUP.md)
- [TanStack Start Docs](https://tanstack.com/start)
- [Cloudflare Workers Docs](https://developers.cloudflare.com/workers)

## Support

For issues with the template:
- GitHub Issues: https://github.com/bgorzelic/saas-kit/issues
- Discussions: https://github.com/bgorzelic/saas-kit/discussions
