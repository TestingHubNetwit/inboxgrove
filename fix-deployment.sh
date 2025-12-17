#!/bin/bash

# Quick fix script for InboxGrove deployment issues
# Run this on the server after git pull

echo "🔧 Fixing InboxGrove deployment..."

# Stop all containers
echo "Stopping containers..."
docker compose down

# Pull latest changes
echo "Pulling latest code..."
git pull

# Rebuild and start
echo "Rebuilding and starting..."
docker compose up -d --build

# Wait a bit
sleep 5

# Check status
echo ""
echo "📊 Container Status:"
docker compose ps

echo ""
echo "🔍 Checking logs for errors..."
docker compose logs api | tail -20

echo ""
echo "✅ Done! Check the status above."
echo ""
echo "Frontend should be at: http://94.250.203.249:3013"
echo "Backend API should be at: http://94.250.203.249:8002"
echo ""
echo "To view logs: docker compose logs -f"
