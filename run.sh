#!/bin/bash
# run.sh: Interactive project bootstrapper
# Usage: ./run.sh

set -e

read -p "Enter your project name: " PROJECT_NAME

# Default YAML structure file
STRUCTURE_YAML="codebase_structure.yaml"

# Run the main project initialization script
./init_project.sh "$PROJECT_NAME" "$STRUCTURE_YAML"
