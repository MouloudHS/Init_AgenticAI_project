#!/bin/bash
# run.sh: Interactive project bootstrapper 🚀
# Usage: ./run.sh

set -e

echo "👋 Welcome to the AgenticAI Project Bootstrapper!"

read -e -i "$HOME/" -p "📁 Enter the absolute base path where the project should be created: " BASE_PATH
read -p "📝 Enter your project name: " PROJECT_NAME

# Default YAML structure file
STRUCTURE_YAML="codebase_structure.yaml"

# Run the main project initialization script from the chosen base path
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$BASE_PATH"
"$SCRIPT_DIR/init_project.sh" "$PROJECT_NAME" "$STRUCTURE_YAML"
echo "✅ Created a project at: $BASE_PATH/$PROJECT_NAME 🎉"
