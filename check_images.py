#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
检查所有Markdown文件中的图片引用是否存在
"""

import os
import re
from pathlib import Path

def find_image_references(file_path):
    """
    在Markdown文件中查找所有图片引用
    返回 [(行号, 图片路径), ...]
    """
    image_pattern = re.compile(r'!\[([^\]]*)\]\(([^\)]+)\)')
    references = []

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            for line_num, line in enumerate(f, 1):
                matches = image_pattern.findall(line)
                for alt_text, img_path in matches:
                    # 忽略http/https链接
                    if not img_path.startswith(('http://', 'https://')):
                        references.append((line_num, img_path))
    except Exception as e:
        print(f"错误: 无法读取文件 {file_path}: {e}")

    return references

def resolve_image_path(md_file_path, image_path):
    """
    根据markdown文件位置解析图片的绝对路径
    """
    # 获取markdown文件所在目录
    md_dir = os.path.dirname(md_file_path)

    # 拼接图片路径
    full_path = os.path.join(md_dir, image_path)

    # 规范化路径
    return os.path.normpath(full_path)

def check_images_in_docs(docs_dir='docs'):
    """
    检查docs目录下所有markdown文件的图片引用
    """
    docs_path = Path(docs_dir)

    if not docs_path.exists():
        print(f"错误: 目录 {docs_dir} 不存在")
        return

    # 统计信息
    total_files = 0
    total_images = 0
    missing_images = 0

    # 存储缺失的图片信息
    missing_list = []

    # 遍历所有markdown文件
    md_files = list(docs_path.rglob('*.md'))

    print(f"开始扫描 {len(md_files)} 个Markdown文件...\n")

    for md_file in sorted(md_files):
        # 查找图片引用
        image_refs = find_image_references(md_file)

        if not image_refs:
            continue

        total_files += 1
        file_has_missing = False

        for line_num, img_path in image_refs:
            total_images += 1

            # 解析图片的完整路径
            full_img_path = resolve_image_path(str(md_file), img_path)

            # 检查文件是否存在
            if not os.path.exists(full_img_path):
                missing_images += 1

                if not file_has_missing:
                    file_has_missing = True

                # 记录缺失信息
                relative_md = md_file.relative_to(docs_path)
                missing_list.append({
                    'file': str(relative_md),
                    'line': line_num,
                    'image': img_path,
                    'full_path': full_img_path
                })

    # 输出结果
    print("=" * 80)
    print("扫描统计")
    print("=" * 80)
    print(f"扫描文件数: {total_files}")
    print(f"总图片引用数: {total_images}")
    print(f"缺失图片数: {missing_images}")
    print()

    if missing_list:
        print("=" * 80)
        print("缺失的图片列表")
        print("=" * 80)

        # 按文件分组显示
        current_file = None
        for item in missing_list:
            if item['file'] != current_file:
                current_file = item['file']
                print(f"\n📄 文件: {item['file']}")

            print(f"   第 {item['line']} 行: {item['image']}")
            print(f"   ❌ 期望路径: {item['full_path']}")
    else:
        print("✅ 所有图片引用都存在！")

    print()
    print("=" * 80)

    return missing_list

if __name__ == '__main__':
    # 确保在正确的目录下运行
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)

    print("图片引用检查工具")
    print("=" * 80)
    print()

    missing = check_images_in_docs('docs')

    if missing:
        print(f"\n⚠️  发现 {len(missing)} 个缺失的图片引用")
        exit(1)
    else:
        print("\n✅ 检查完成，所有图片引用正常")
        exit(0)
