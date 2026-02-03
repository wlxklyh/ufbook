"""MkDocs hooks for copying verification files."""
import os
import shutil

def on_post_build(config, **kwargs):
    """Copy verification files to site directory after build."""
    docs_dir = config['docs_dir']
    site_dir = config['site_dir']
    
    # Files to copy as-is (verification files)
    verification_files = [
        'googleb4f1041edf9a23ea.html',
        'BingSiteAuth.xml',
    ]
    
    for filename in verification_files:
        src = os.path.join(docs_dir, filename)
        dst = os.path.join(site_dir, filename)
        if os.path.exists(src):
            shutil.copy2(src, dst)
            print(f"Copied verification file: {filename}")
