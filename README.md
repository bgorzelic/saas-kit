# 🚀 SaaS Kit - Modern SaaS Template

A production-ready SaaS template built with cutting-edge technologies. Deploy AI-powered SaaS applications to Cloudflare's edge network in minutes.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![TanStack Start](https://img.shields.io/badge/TanStack-Start-FF4154)](https://tanstack.com/start)
[![Cloudflare Workers](https://img.shields.io/badge/Cloudflare-Workers-F38020)](https://workers.cloudflare.com)

## ✨ Features

- **⚡ TanStack Start** - Full-stack React framework with SSR
- **🌍 Cloudflare Workers** - Deploy to the edge in 200+ cities
- **🤖 Anthropic Claude** - Built-in AI agent integration
- **🔐 Better Auth** - Complete authentication with OAuth
- **📊 Drizzle ORM** - Type-safe database queries
- **💳 Polar.sh** - Ready for payment integration
- **🎨 Tailwind CSS v4** - Modern utility-first styling
- **🧩 Shadcn/UI** - Beautiful, accessible components

## 🎯 Quick Start

### For New Projects (Template Usage)

```bash
# 1. Clone this template
git clone https://github.com/bgorzelic/saas-kit.git my-awesome-saas
cd my-awesome-saas

# 2. Initialize your project
pnpm run init

# 3. Follow the prompts to customize
# - Project name
# - Database choice (PlanetScale/Neon)
# - Payment integration

# 4. Install dependencies
pnpm install

# 5. Configure .dev.vars with your API keys
# Edit apps/user-application/.dev.vars

# 6. Start developing!
pnpm -w run dev:user-application
```

Visit **http://localhost:3000**

### For This Repository (Development)

```bash
# Install dependencies
pnpm install

# Configure environment
cp apps/user-application/.dev.vars.example apps/user-application/.dev.vars
# Edit .dev.vars with your API keys

# Start development
pnpm -w run dev:user-application
```

## 📚 Documentation

- **[Template Usage Guide](TEMPLATE_USAGE.md)** - Using this as a template
- **[Setup Guide](SETUP.md)** - Detailed setup instructions
- **[AI Integration](AGENTS_INTEGRATION.md)** - Anthropic Claude setup
- **[MCP Configuration](MCP_SETUP.md)** - Enhanced development with MCP

## 🏗️ Project Structure

```
saas-kit/
├── apps/
│   ├── user-application/       # TanStack Start frontend
│   │   ├── src/
│   │   │   ├── routes/         # File-based routing
│   │   │   ├── core/
│   │   │   │   ├── functions/  # Server functions
│   │   │   │   └── middleware/ # Auth, AI, etc.
│   │   │   └── components/     # React components
│   │   └── wrangler.jsonc      # Cloudflare config
│   │
│   └── data-service/           # Hono API backend
│       ├── src/
│       │   └── services/       # Business logic
│       └── wrangler.jsonc
│
├── packages/
│   └── data-ops/               # Shared data layer
│       ├── src/
│       │   ├── auth/           # Better Auth setup
│       │   ├── database/       # DB connections
│       │   ├── drizzle/        # Database schema
│       │   └── queries/        # Reusable queries
│       └── drizzle.config.ts
│
└── scripts/
    └── init-template.sh        # Template initialization
```

## 🛠️ Tech Stack

### Frontend
- React 19 with concurrent features
- TanStack Router for type-safe routing
- TanStack Query for server state
- Tailwind CSS v4 with CSS variables
- Shadcn/UI components

### Backend
- Cloudflare Workers for edge computing
- Hono for HTTP routing
- Better Auth for authentication
- Drizzle ORM for databases

### AI & Integrations
- Anthropic Claude SDK
- Polar.sh payments
- OAuth providers (Google, GitHub, etc.)

## 🔧 Development Scripts

```bash
# Install dependencies and build packages
pnpm run setup

# Start user application (port 3000)
pnpm -w run dev:user-application

# Start data service
pnpm -w run dev:data-service

# Initialize new project from template
pnpm run init

# Deploy to Cloudflare
pnpm run deploy:user-application
pnpm run deploy:data-service
```

## 🌐 Deployment

### Prerequisites
- Cloudflare account
- Wrangler CLI installed (`pnpm install -g wrangler`)

### Deploy

```bash
# Login to Cloudflare
wrangler login

# Set production secrets
wrangler secret put ANTHROPIC_API_KEY
wrangler secret put DATABASE_PASSWORD

# Deploy
pnpm run deploy:user-application
pnpm run deploy:data-service
```

## 🔐 Environment Variables

### Required
```bash
ANTHROPIC_API_KEY=sk-ant-...     # Get from console.anthropic.com
```

### Database (choose one)
```bash
# PlanetScale (MySQL)
DATABASE_HOST=aws.connect.psdb.cloud
DATABASE_USERNAME=your_username
DATABASE_PASSWORD=pscale_pw_...

# OR Neon (PostgreSQL)
DATABASE_URL=postgresql://user:pass@host/db
```

### Optional
```bash
POLAR_SECRET=polar_...           # For payments
GITHUB_CLIENT_ID=...             # For GitHub OAuth
GOOGLE_CLIENT_ID=...             # For Google OAuth
```

## 🎨 Customization

### Add Shadcn Components
```bash
cd apps/user-application
pnpx shadcn@latest add button card form
```

### Add Database Tables
```bash
cd packages/data-ops
# Edit src/drizzle/schema.ts
pnpm run drizzle:generate
pnpm run drizzle:migrate
```

### Remove Features
See [TEMPLATE_USAGE.md](TEMPLATE_USAGE.md#customization-ideas) for removing unused features.

## 📖 Learn More

- [TanStack Start](https://tanstack.com/start) - Full-stack framework
- [Cloudflare Workers](https://workers.cloudflare.com) - Edge platform
- [Better Auth](https://www.better-auth.com) - Authentication
- [Drizzle ORM](https://orm.drizzle.team) - Database toolkit
- [Anthropic](https://docs.anthropic.com) - AI integration
- [Shadcn/UI](https://ui.shadcn.com) - Component library

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Built on top of amazing open-source projects:
- TanStack ecosystem
- Cloudflare Workers
- Anthropic Claude
- Better Auth
- Drizzle ORM

---

**Made with ❤️ by [Your Name](https://github.com/bgorzelic)**

If you find this template useful, please ⭐ star the repo!
