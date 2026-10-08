#!/usr/bin/env bash
# ==============================================================================
# Build Script for Render Deployment
# ==============================================================================

# Exit immediately if a command exits with a non-zero status
set -o errexit

echo "📦 Installing Python dependencies..."
pip install -r requirements.txt

echo "🎨 Collecting static files (WhiteNoise)..."
python manage.py collectstatic --no-input

echo "🗄️ Running database migrations..."
python manage.py migrate

echo "✅ Build completed successfully!"
