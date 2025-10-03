#!/bin/bash

# SaaS Kit Template Initialization Script
# This script helps you customize the template for a new project

set -e

echo "🚀 SaaS Kit Template Initialization"
echo "===================================="
echo ""

# Get project details
read -p "Project Name (e.g., my-awesome-saas): " PROJECT_NAME
read -p "Project Description: " PROJECT_DESC
read -p "Author Name: " AUTHOR_NAME
read -p "Cloudflare Worker Name (default: $PROJECT_NAME): " WORKER_NAME
WORKER_NAME=${WORKER_NAME:-$PROJECT_NAME}

echo ""
echo "📦 Choose your database provider:"
echo "1) PlanetScale (MySQL)"
echo "2) Neon (PostgreSQL)"
echo "3) Skip (configure later)"
read -p "Choice [1-3]: " DB_CHOICE

echo ""
echo "💳 Will you use Polar.sh for payments? (y/n): "
read -p "Choice: " USE_POLAR

echo ""
echo "🔧 Configuring your project..."

# Update root package.json
jq --arg name "$PROJECT_NAME" \
   --arg desc "$PROJECT_DESC" \
   --arg author "$AUTHOR_NAME" \
   '.name = $name | .description = $desc | .author = $author' \
   package.json > package.json.tmp && mv package.json.tmp package.json

# Update user-application wrangler.jsonc
sed -i.bak "s/tanstack-start-app/$WORKER_NAME/g" apps/user-application/wrangler.jsonc
rm -f apps/user-application/wrangler.jsonc.bak

# Update data-service wrangler.jsonc
sed -i.bak "s/saas-kit-data-service/$WORKER_NAME-data-service/g" apps/data-service/wrangler.jsonc
rm -f apps/data-service/wrangler.jsonc.bak

# Create .dev.vars based on choices
echo "# $PROJECT_NAME - Development Environment Variables" > apps/user-application/.dev.vars
echo "# Generated on $(date)" >> apps/user-application/.dev.vars
echo "" >> apps/user-application/.dev.vars
echo "# Anthropic API Key" >> apps/user-application/.dev.vars
echo "ANTHROPIC_API_KEY=" >> apps/user-application/.dev.vars
echo "" >> apps/user-application/.dev.vars

if [ "$DB_CHOICE" = "1" ]; then
    echo "# PlanetScale Database (MySQL)" >> apps/user-application/.dev.vars
    echo "DATABASE_HOST=" >> apps/user-application/.dev.vars
    echo "DATABASE_USERNAME=" >> apps/user-application/.dev.vars
    echo "DATABASE_PASSWORD=" >> apps/user-application/.dev.vars
elif [ "$DB_CHOICE" = "2" ]; then
    echo "# Neon Database (PostgreSQL)" >> apps/user-application/.dev.vars
    echo "DATABASE_URL=" >> apps/user-application/.dev.vars
fi

echo "" >> apps/user-application/.dev.vars

if [ "$USE_POLAR" = "y" ] || [ "$USE_POLAR" = "Y" ]; then
    echo "# Polar.sh Payment Integration" >> apps/user-application/.dev.vars
    echo "POLAR_SECRET=" >> apps/user-application/.dev.vars
fi

# Copy to data-service
cp apps/user-application/.dev.vars apps/data-service/.dev.vars

# Update MCP config with current directory
CURRENT_DIR=$(pwd)
sed -i.bak "s|/Users/bgorzelic/dev/projects/research/saas-kit/saas-kit|$CURRENT_DIR|g" .mcp.json
rm -f .mcp.json.bak

# Update README
cat > README.md << EOF
# $PROJECT_NAME

$PROJECT_DESC

A modern SaaS application built with TanStack Start, Cloudflare Workers, and Anthropic AI.

## Quick Start

\`\`\`bash
# Install dependencies
pnpm install

# Configure environment variables
# Edit apps/user-application/.dev.vars with your API keys

# Run development server
pnpm -w run dev:user-application

# Run data service
pnpm -w run dev:data-service
\`\`\`

## Tech Stack

- **Frontend**: TanStack Start, React 19, Tailwind CSS v4
- **Backend**: Cloudflare Workers, Hono
- **Database**: Better Auth + Drizzle ORM
- **AI**: Anthropic Claude API
- **Payments**: Polar.sh (optional)

## Documentation

- [Setup Guide](SETUP.md)
- [AI Integration](AGENTS_INTEGRATION.md)
- [MCP Configuration](MCP_SETUP.md)

## Deployment

\`\`\`bash
# Deploy frontend to Cloudflare
pnpm run deploy:user-application

# Deploy backend service
pnpm run deploy:data-service
\`\`\`

## Author

$AUTHOR_NAME

## License

MIT
EOF

echo ""
echo "✅ Template initialized successfully!"
echo ""
echo "📝 Next steps:"
echo "1. Edit apps/user-application/.dev.vars with your API keys"
echo "2. Run 'pnpm install' to ensure dependencies are up to date"
echo "3. Run 'pnpm -w run dev:user-application' to start development"
echo ""
echo "📚 Check SETUP.md for detailed configuration instructions"
echo ""
