# -*- coding: utf-8 -*-
# Creates markdown file form annotations in a specific modelica's library.
import os
import sys
import omc4py
import yaml
import shutil
from tqdm import tqdm
from pathlib import Path
import re

EXCLUDED_CLASS_PREFIXES = (
    "ThermoSysPro.Units",
    "ThermoSysPro.Properties",
)

def should_document_class(class_name) -> bool:
    """Return False for class trees that are too low-level for the book."""
    class_name = omc.typeNameString(class_name)
    return not any(
        class_name == prefix or class_name.startswith(f"{prefix}.")
        for prefix in EXCLUDED_CLASS_PREFIXES
    )

def replace_link_icons(text):
    """Convert Modelica SVG URIs to relative links copied into modelica_docs/icons."""
    pattern = r'!\[.*?\]\(modelica://([^\s)]+/([^/]+\.svg))\)'
    def repl(match):
        filename = match.group(2)
        return f"![{filename}](./icons/{filename})"
    return re.sub(pattern, repl, text)

def replace_link_module(text):
    """Convert modelica:// links to local Jupyter Book references."""
    text = text.replace("modelica://", "")
    return text

def convert_maths(text):
    text = re.sub(r'\\\\\((.*?)\\\\\)', r'$\1$', text, flags=re.DOTALL) # Transform inline math block
    text = re.sub(r'\$\$\s*\$\$', r'$$ \n $$', text) # Replace all consecutive $$ $$ blocks with $$ \n $$
    text = re.sub(r'(\$\$.*?\$\$|\$.*?\$)', 
                  lambda m: ( #print("Bloc trouvé :", repr(m.group(0))) or  # <-- affiche le bloc brut trouvé
                            m.group(0)
                             .replace(r'\_', '_')
                             .replace('\f', '\\f')
                             .replace('\t', '\\t')
                             .replace('\b', '\\b')
                             .replace('\v', '\\v')
                             .replace('\a', '\\a') 
                             .replace(r'\\', '\\')
                             .replace(r'\(', '(')
                             .replace(r'\)', ')')
                             ), 
                  text,
                  flags=re.DOTALL)
    text = re.sub(r'(?<!\\)\beq\b', r'\\neq', text) # for \neq which is broken because of \n
    text = text.replace("$$.", "$$")
    return text

def save_documentation(md_dir, class_name, doc_content):
    """
    Save the documentation of a Modelica class to a markdown file.

    Parameters:
    md_dir (str): The directory where markdown files are saved.
    class_name (str): The name of the Modelica class.
    doc_content (str): The documentation content of the Modelica class.
    """
    
    doc_content = convert_maths(doc_content)
    doc_content = replace_link_icons(doc_content)
    doc_content = replace_link_module(doc_content)
    doc_content = re.sub(r':cite:`(.*?)`', r'{cite:p}`\1`', doc_content)

    filename = omc.typeNameString(class_name) + '.md'
    filepath = os.path.join(md_dir, filename)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(f"# {filename.split('.')[-2]}\n\n{doc_content}")

def create_chapters(name, content):
    """
    Create a list of chapters and sections for the table of contents.

    Parameters:
    name (str): The base name of the Modelica class or package.
    content (dict): A dictionary representing the hierarchical structure of the classes.

    Returns:
    list: A list of dictionaries representing the chapters and sections.
    """
    chapters = []
    overview_added = False
    for key, value in content.items():
        if not overview_added:
            chapters.append({
                "file": f"modelica_docs/{name}",
                "title": f"{name.split('.')[-1]} Overview"
            })
            overview_added = True

        chapter = {
            "file": f"modelica_docs/{name}.{key}",
            "title": key
        }
        if value:  # If there are subsections
            chapter["sections"] = [{"glob": f"modelica_docs/{name}.{key}.*"}]
        chapters.append(chapter)
    return chapters

def write_toc(toc_file_path, content_table_toc):
    """
    Write the table of contents (_toc) to a YAML file in the .

    Parameters:
    toc_file_path (str): The file path for the TOC YAML file.
    content_table_toc (list): A list of lists representing the hierarchical structure of the classes.
    """
    # Create the toc structure
    toc_structure = {
        "format": "jb-book",
        "root": "intro",
        "parts": []
    }

    # Add the main modelica library overview file
    toc_structure["parts"].append({
        "caption": lib_name,
        "numbered": False,
        "chapters": [{
            "file": f"modelica_docs/{lib_name}",
            "title": f"{lib_name} Overview"
        }]
    })

    # Organize the content table into a dictionary
    toc_dict = {}
    for path in content_table_toc:
        current_level = toc_dict
        for part in path:
            if part not in current_level:
                current_level[part] = {}
            current_level = current_level[part]

    for part, chapters in toc_dict.items():
        toc_part = {
            "caption": part,
            "numbered": False,
            "chapters": create_chapters(f"{lib_name}.{part}", chapters)
        }
        toc_structure["parts"].append(toc_part)

    toc_structure["parts"].append({
        "caption": "Bibliography",
        "numbered": False,
        "chapters": [{
            "file": "bibliography",
            "title": "References"
        }]
    })
    
    # Write the toc_structure to _toc.yml
    with open(toc_file_path, 'w', encoding='utf-8') as f:
        yaml.dump(toc_structure, f, default_flow_style=False, sort_keys=False)

    print("The _toc.yml file has been updated.")

def copy_svg(source_path: str, target_path: str) -> None:
    """Copies documentation .svg files from the Modelica library to the book."""
    documentation_path = Path(source_path) / "UsersGuide" / "Documentation"
    for svg_path in documentation_path.glob("*.svg"):
        target_file = Path(target_path) / svg_path.name
        shutil.copy2(svg_path, target_file)

if __name__ == "__main__" :

    lib_name = "ThermoSysPro"  
    path_library = "../ThermoSysPro/package.mo"
    path_doc = "./"
    # omc_exec = "/home/j74082/Logiciels/OpenModelica/1.23.1/Install/usr/bin/omc"
    omc_exec = None

    # Path to modelica library
    if not path_library.endswith("package.mo"):
        path_package = os.path.join(path_library, "package.mo")
    else :
        path_package = path_library

    # Path to directory to save the markdown files
    modelica_md_dir = f"{path_doc}/modelica_docs"
    os.makedirs(modelica_md_dir, exist_ok=True)
    toc_file_path = f"{path_doc}/_toc.yml"

    try:
        with open(path_package, 'r') as fichier:
            pass
    except FileNotFoundError:
        print(f"The library : '{path_package}' has not been found.")
        sys.exit(1)
        
    # Open OMC session and load file
    omc = omc4py.open_session(omc_exec)
    omc.loadFile(path_package)

    # Copy image .svg files
    os.makedirs(path_doc + "modelica_docs/icons", exist_ok=True)
    copy_svg(source_path=os.path.dirname(path_library), target_path=path_doc + "modelica_docs/icons")

    # Bibliography file is expected to be stored next to this script.
    bib_file = Path(path_doc) / "references.bib"
    if not bib_file.exists():
        print(f"The bibliography file : '{bib_file}' has not been found.")
        sys.exit(1)

    content_table_list = []
    for class_name in tqdm(omc.getClassNames(lib_name, recursive=True), desc="Processing classes"):
        # Skip large/internal class trees before creating Markdown or TOC entries.
        if not should_document_class(class_name):
            continue
        # class_name = "ThermoSysPro.Combustion.CombustionChambers.GenericCombustion1D"  # Example class name
        doc_content = omc.getDocumentationAnnotation(class_name)[0]
        save_documentation(modelica_md_dir, class_name, doc_content)
        content_table_list.append(omc.typeNameString(class_name).split('.')[1:])
    # Save the table of content for the main library file
    write_toc(toc_file_path, content_table_list)
    omc.close()
