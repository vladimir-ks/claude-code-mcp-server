#!/bin/bash

# Publish Release Script
# This script handles the full release process

set -e

echo "🚀 Publishing MCP Server Release"
echo "================================"

# Ensure we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "❌ Error: Must be on main branch to release"
    echo "   Current branch: $CURRENT_BRANCH"
    exit 1
fi

# Ensure tracked state is clean. The repository's required Spotlight marker is accepted local state.
DIRTY_STATE=$(git status --porcelain --untracked-files=all | grep -v '^?? \.metadata_never_index$' || true)
if [ -n "$DIRTY_STATE" ]; then
    echo "❌ Error: Working directory is not clean"
    echo "   Please commit or stash your changes"
    exit 1
fi

# Pull latest changes
echo "📥 Pulling latest changes..."
git pull --ff-only

# Run bounded release certification. E2E uses the generated mock; real-Claude cases stay skipped.
echo "🧪 Running release certification..."
npm test
npm run test:e2e
npm run test:package
npm audit --omit=dev --audit-level=high

# Get current version
CURRENT_VERSION=$(node -p "require('./package.json').version")
echo "📌 Current version: $CURRENT_VERSION"

# Ask for new version
echo ""
echo "🔢 What type of release is this?"
echo "1) Patch (bug fixes)"
echo "2) Minor (new features)"
echo "3) Major (breaking changes)"
read -p "Enter choice (1-3): " RELEASE_TYPE

case $RELEASE_TYPE in
    1) npm version patch ;;
    2) npm version minor ;;
    3) npm version major ;;
    *) echo "Invalid choice"; exit 1 ;;
esac

# Get new version
NEW_VERSION=$(node -p "require('./package.json').version")

# Update changelog
echo ""
echo "📝 Please update CHANGELOG.md with the new version details"
echo "   New version: $NEW_VERSION"
read -p "Press enter when done..."

# Commit version bump
git add package.json package-lock.json CHANGELOG.md
git commit -m "Bump version to $NEW_VERSION"

# Create git tag
git tag "v$NEW_VERSION"

# Push changes and tags
echo "⬆️  Pushing changes to GitHub..."
git push
git push --tags

# Create GitHub release
echo "📋 Creating GitHub release..."
gh release create "v$NEW_VERSION" \
    --title "Release v$NEW_VERSION" \
    --notes "See CHANGELOG.md for details" \
    --latest

# Publish to npm
echo "📦 Publishing to npm..."
npm publish

echo ""
echo "✅ Release v$NEW_VERSION published successfully!"
echo ""
echo "📋 Post-release checklist:"
echo "[ ] Test the new version with: npx @steipete/claude-code-mcp@latest"
echo "[ ] Update any documentation if needed"
echo "[ ] Announce the release if significant"
