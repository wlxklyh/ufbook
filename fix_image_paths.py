#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
自动修复Markdown文件中的图片路径
"""

import os
import re

def fix_image_paths(file_path, replacements):
    """
    修复文件中的图片路径
    replacements: [(原路径, 新路径), ...]
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()

        modified = False
        for old_path, new_path in replacements:
            # 匹配 ![xxx](old_path)
            pattern = re.compile(r'!\[([^\]]*)\]\(' + re.escape(old_path) + r'\)')
            if pattern.search(content):
                content = pattern.sub(r'![\1](' + new_path + ')', content)
                modified = True
                print(f"  ✓ 修复: {old_path} → {new_path}")

        if modified:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(content)
            return True
        return False

    except Exception as e:
        print(f"  ✗ 错误: {e}")
        return False

def main():
    print("开始修复图片路径...\n")

    fixed_files = 0

    # 1. 修复 qualcomm-frame-interpolation.md
    print("📄 修复 mobile/qualcomm-frame-interpolation.md")
    qualcomm_file = 'docs/mobile/qualcomm-frame-interpolation.md'
    qualcomm_fixes = [
        ('UE5_Contact.png', 'qualcomm-frame-interpolation/UE5_Contact.png'),
    ]
    # 添加所有screenshots的修复（小写改大写+前缀）
    screenshot_pattern = re.compile(r'screenshots/(\d+_plus\d+\.\d+s\.png)')
    try:
        with open(qualcomm_file, 'r', encoding='utf-8') as f:
            content = f.read()
        matches = screenshot_pattern.findall(content)
        for match in set(matches):
            old = f'screenshots/{match}'
            new = f'qualcomm-frame-interpolation/Screenshots/{match}'
            qualcomm_fixes.append((old, new))
    except Exception as e:
        print(f"  警告: {e}")

    if fix_image_paths(qualcomm_file, qualcomm_fixes):
        fixed_files += 1
    print()

    # 2. 修复 pixel-optimization.md
    print("📄 修复 rendering/pixel-optimization.md")
    pixel_file = 'docs/rendering/pixel-optimization.md'
    pixel_fixes = [
        ('UE5_Contact.png', 'pixel-optimization/UE5_Contact.png'),
    ]
    # 添加所有screenshots的修复
    try:
        with open(pixel_file, 'r', encoding='utf-8') as f:
            content = f.read()
        matches = screenshot_pattern.findall(content)
        for match in set(matches):
            old = f'screenshots/{match}'
            new = f'pixel-optimization/Screenshots/{match}'
            pixel_fixes.append((old, new))
    except Exception as e:
        print(f"  警告: {e}")

    if fix_image_paths(pixel_file, pixel_fixes):
        fixed_files += 1
    print()

    # 3. 修复 metahuman-production.md
    print("📄 修复 project-cases/metahuman-production.md")
    metahuman_file = 'docs/project-cases/metahuman-production.md'
    metahuman_fixes = []

    # 查找所有 Screenshots/ 开头的路径
    try:
        with open(metahuman_file, 'r', encoding='utf-8') as f:
            content = f.read()
        screenshot_refs = re.findall(r'Screenshots/(\d+_plus\d+\.\d+s\.png)', content)
        for match in set(screenshot_refs):
            old = f'Screenshots/{match}'
            new = f'metahuman-production/Screenshots/{match}'
            metahuman_fixes.append((old, new))
    except Exception as e:
        print(f"  警告: {e}")

    if fix_image_paths(metahuman_file, metahuman_fixes):
        fixed_files += 1
    print()

    print("=" * 80)
    print(f"✅ 完成! 共修复 {fixed_files} 个文件")
    print()
    print("现在运行 python check_images.py 重新检查...")

if __name__ == '__main__':
    # 确保在正确的目录下运行
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)

    main()
