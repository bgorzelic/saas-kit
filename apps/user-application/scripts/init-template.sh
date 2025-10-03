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

# Update root package.json (requires jq)
if command -v jq &> /dev/null; then
    jq --arg name "$PROJECT_NAME" \
       --arg desc "$PROJECT_DESC" \
       --arg author "$AUTHOR_NAME" \
       '.name = $name | .description = $desc | .author = $author' \
       package.json > package.json.tmp && mv package.json.tmp package.json
else
    echo "Note: jq not found, skipping package.json update. Please update manually."
fi

# Update wrangler configs
sed -i.bak "s/tanstack-start-app/$WORKER_NAME/g" apps/user-application/wrangler.jsonc 2>/dev/null || true
sed -i.bak "s/saas-kit-data-service/$WORKER_NAME-data-service/g" apps/data-service/wrangler.jsonc 2>/dev/null || true
rm -f apps/**/wrangler.jsonc.bak

# Create .dev.vars
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

# Update MCP config
CURRENT_DIR=$(pwd)
sed -i.bak "s|\${PROJECT_DIR}|$CURRENT_DIR|g" .mcp.json 2>/dev/null || true
rm -f .mcp.json.bak

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
