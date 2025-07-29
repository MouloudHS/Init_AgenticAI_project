import os, argparse, yaml


def create_structure_from_dict(base_path, structure):
    """
    Recursively create folders and files from a nested dict structure.
    - Keys ending with '/' are directories.
    - Keys not ending with '/' are files (empty or with content if value is a string).
    - Values can be dict (for folders), None, or string (for file content).
    """
    for name, value in structure.items():
        if name.endswith('/'):
            dir_path = os.path.join(base_path, name.rstrip('/'))
            os.makedirs(dir_path, exist_ok=True)
            if isinstance(value, dict):
                create_structure_from_dict(dir_path, value)
        else:
            file_path = os.path.join(base_path, name)
            with open(file_path, 'w', encoding='utf-8') as f:
                if isinstance(value, str):
                    f.write(value)
                else:
                    f.write('')

def load_yaml_structure(yaml_path):
    with open(yaml_path, 'r', encoding='utf-8') as f:
        return yaml.safe_load(f)

def main():
    parser = argparse.ArgumentParser(description="Generate a project structure from a YAML file.")
    parser.add_argument('yaml_file', help='YAML file describing the project structure')
    parser.add_argument('output_dir', help='Directory where the structure will be created')
    args = parser.parse_args()

    structure = load_yaml_structure(args.yaml_file)
    os.makedirs(args.output_dir, exist_ok=True)
    create_structure_from_dict(args.output_dir, structure)
    print(f"Project structure created in: {args.output_dir}")

if __name__ == "__main__":
    main()
