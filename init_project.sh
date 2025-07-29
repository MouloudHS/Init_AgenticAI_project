#!/bin/bash
# Usage: ./init_project.sh <project_name> <structure_yaml>
# Example: ./init_project.sh my_project codebase_structure.yaml

set -e

if [ $# -ne 2 ]; then
  echo "Usage: $0 <project_name> <structure_yaml>"
  exit 1
fi

PROJECT_NAME="$1"
STRUCTURE_YAML="$2"

# 1. Initialize uv project
echo "Initializing uv project: $PROJECT_NAME"
uv init "$PROJECT_NAME"
cd "$PROJECT_NAME"

# 2. Create requirements.txt
cat > requirements.txt <<EOL
langGraph
langChain
ipykernel
EOL

# 3. Install requirements
echo "Installing requirements via uv..."
uv add -r requirements.txt

# 4. Generate project structure (assumes project_structure_generator.py is in parent dir)
echo "Generating project structure..."
python3 ../project_structure_generator.py "../$STRUCTURE_YAML" .

# 5. Create README.md with current structure
echo "Generating README.md with project tree..."
echo "# $PROJECT_NAME\n" > README.md
echo '\n## Project Structure\n' >> README.md
echo '\n```' >> README.md
tree -a -I ".git|.venv|__pycache__|.mypy_cache|.pytest_cache|.DS_Store|*.pyc|*.pyo|*.egg-info|.ipynb_checkpoints|lib|vis-9.1.2|tom-select|bindings" >> README.md
echo '\n```' >> README.md

echo "Done!"
