#!/usr/bin/env python3
"""
Convert LiveSpec format to pure MSL format.

LiveSpec format:
    # Title
    **Criticality**: CRITICAL
    **Failure Mode**: Description
    ## Specification
    Text
    ## Validation
    - Item 1

MSL format:
    ---
    criticality: CRITICAL
    failure_mode: Description
    ---
    # Title
    ## Requirements
    - [!] REQ-001: Text
      - Item 1
"""

import re
import sys
from pathlib import Path

def extract_frontmatter(content):
    """Extract existing YAML frontmatter if present."""
    frontmatter_match = re.match(r'^---\n(.*?)\n---\n', content, re.DOTALL)
    if frontmatter_match:
        frontmatter = frontmatter_match.group(1)
        body = content[frontmatter_match.end():]
        return frontmatter, body
    return "", content

def extract_criticality(body):
    """Extract Criticality field from body."""
    match = re.search(r'^\*\*Criticality\*\*:\s*(CRITICAL|IMPORTANT)', body, re.MULTILINE)
    if match:
        criticality = match.group(1)
        # Remove from body
        body = re.sub(r'^\*\*Criticality\*\*:\s*(CRITICAL|IMPORTANT)\s*\n', '', body, flags=re.MULTILINE)
        return criticality, body
    return None, body

def extract_failure_mode(body):
    """Extract Failure Mode field from body."""
    match = re.search(r'^\*\*Failure Mode\*\*:\s*(.+?)(?=\n\n|\n##|$)', body, re.MULTILINE | re.DOTALL)
    if match:
        failure_mode = match.group(1).strip().replace('\n', ' ')
        # Remove from body
        body = re.sub(r'^\*\*Failure Mode\*\*:\s*.+?(?=\n\n|\n##)', '', body, flags=re.MULTILINE | re.DOTALL)
        return failure_mode, body
    return None, body

def extract_title(body):
    """Extract title (# heading)."""
    # Strip leading whitespace to handle blank lines after frontmatter
    body = body.lstrip()
    match = re.match(r'^#\s+(.+?)\s*\n', body)
    if match:
        title = match.group(1)
        body = body[match.end():]
        return title, body
    return None, body

def extract_specification(body):
    """Extract content under ## Specification section."""
    match = re.search(r'##\s+Specification\s*\n(.*?)(?=\n##|\Z)', body, re.DOTALL)
    if match:
        spec = match.group(1).strip()
        return spec
    return None

def extract_validation(body):
    """Extract items under ## Validation section."""
    match = re.search(r'##\s+Validation\s*\n(.*?)(?=\n##[^#]|\Z)', body, re.DOTALL)
    if match:
        validation = match.group(1).strip()
        # Extract bullet points
        bullets = re.findall(r'^-\s+(.+?)(?=\n-|\n\n|\Z)', validation, re.MULTILINE | re.DOTALL)
        return [bullet.strip() for bullet in bullets]
    return []

def parse_frontmatter(frontmatter_text):
    """Parse YAML frontmatter into dict."""
    fm_dict = {}
    if not frontmatter_text:
        return fm_dict

    current_key = None
    current_list = []

    for line in frontmatter_text.split('\n'):
        line = line.rstrip()
        if not line:
            continue

        # List item
        if line.startswith('  - '):
            if current_key and current_list is not None:
                current_list.append(line[4:])
        # Key-value pair
        elif ':' in line and not line.startswith(' '):
            if current_key and current_list:
                fm_dict[current_key] = current_list
                current_list = []

            key, value = line.split(':', 1)
            key = key.strip()
            value = value.strip()

            if value.startswith('['):
                # Inline list
                fm_dict[key] = value
                current_key = None
            elif not value:
                # Start of list
                current_key = key
                current_list = []
            else:
                # Simple value
                fm_dict[key] = value
                current_key = None

    # Handle last list
    if current_key and current_list:
        fm_dict[current_key] = current_list

    return fm_dict

def format_frontmatter(fm_dict):
    """Format dict back to YAML frontmatter."""
    lines = []
    for key, value in fm_dict.items():
        if isinstance(value, list):
            lines.append(f"{key}:")
            for item in value:
                lines.append(f"  - {item}")
        else:
            lines.append(f"{key}: {value}")
    return '\n'.join(lines)

def convert_spec(filepath):
    """Convert a single spec file from LiveSpec to MSL format."""
    content = Path(filepath).read_text()

    # Extract existing frontmatter
    frontmatter_text, body = extract_frontmatter(content)
    fm_dict = parse_frontmatter(frontmatter_text)

    # Extract title
    title, body = extract_title(body)
    if not title:
        print(f"Warning: No title found in {filepath}")
        return None

    # Extract criticality and failure mode
    criticality, body = extract_criticality(body)
    failure_mode, body = extract_failure_mode(body)

    if criticality:
        fm_dict['criticality'] = criticality
    if failure_mode:
        fm_dict['failure_mode'] = failure_mode

    # Extract specification and validation
    specification = extract_specification(body)
    validation_items = extract_validation(body)

    if not specification and not validation_items:
        print(f"Warning: No Specification or Validation found in {filepath}")
        return None

    # Build MSL format
    output = []

    # Frontmatter
    if fm_dict:
        output.append("---")
        output.append(format_frontmatter(fm_dict))
        output.append("---")
        output.append("")

    # Title
    output.append(f"# {title}")
    output.append("")

    # Requirements section
    output.append("## Requirements")

    # Main requirement with specification text
    if specification:
        marker = "[!] " if criticality == "CRITICAL" else ""
        # Find if there's a REQ-ID in the specification already
        req_match = re.match(r'(REQ-\d+):\s*(.*)', specification, re.DOTALL)
        if req_match:
            req_id = req_match.group(1)
            req_text = req_match.group(2).strip()
            output.append(f"- {marker}{req_id}: {req_text}")
        else:
            output.append(f"- {marker}{specification}")

    # Validation items as sub-bullets
    if validation_items:
        for item in validation_items:
            # Check if item already starts with a marker
            if re.match(r'^\[.\]', item):
                output.append(f"  - {item}")
            else:
                output.append(f"  - {item}")

    # Preserve any additional sections (Notes, etc.)
    additional = re.search(r'(##\s+(?!Specification|Validation)[^\n]+.*)', body, re.DOTALL)
    if additional:
        output.append("")
        output.append(additional.group(1).strip())

    return '\n'.join(output) + '\n'

def main():
    if len(sys.argv) != 2:
        print("Usage: convert-to-msl.py <spec-file>")
        sys.exit(1)

    filepath = sys.argv[1]

    if not Path(filepath).exists():
        print(f"Error: File not found: {filepath}")
        sys.exit(1)

    result = convert_spec(filepath)

    if result:
        # Write to file
        Path(filepath).write_text(result)
        print(f"✓ Converted: {filepath}")
    else:
        print(f"✗ Failed to convert: {filepath}")
        sys.exit(1)

if __name__ == "__main__":
    main()
