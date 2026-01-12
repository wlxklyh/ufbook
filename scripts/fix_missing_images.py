#!/usr/bin/env python3
"""
检查并修复 MkDocs 文档中缺失的图片
从 uf2zhihu/projects 目录复制缺失的图片到 ufbook/docs 对应位置
"""

import os
import re
import shutil
from pathlib import Path
from typing import List, Tuple, Dict

# 项目根目录
PROJ_ROOT = Path(__file__).parent.parent.parent
UFBOOK_DOCS = PROJ_ROOT / "ufbook" / "docs"
UF2ZHIHU_PROJECTS = PROJ_ROOT / "uf2zhihu" / "projects"


def find_image_references(md_file: Path) -> List[Tuple[str, int]]:
    """
    从 Markdown 文件中提取所有图片引用（排除代码块中的内容）
    返回: [(图片路径, 行号), ...]
    """
    image_refs = []

    # 匹配 Markdown 图片语法: ![alt](path)
    img_pattern = re.compile(r'!\[.*?\]\((.*?)\)')

    try:
        with open(md_file, 'r', encoding='utf-8') as f:
            in_code_block = False
            for line_num, line in enumerate(f, 1):
                # 检查代码块标记
                if line.strip().startswith('```'):
                    in_code_block = not in_code_block
                    continue

                # 跳过代码块中的内容
                if in_code_block:
                    continue

                # 跳过行内代码
                if '`' in line:
                    # 简单处理：移除行内代码后再匹配
                    line = re.sub(r'`[^`]+`', '', line)

                matches = img_pattern.findall(line)
                for img_path in matches:
                    # 排除 URL
                    if not img_path.startswith(('http://', 'https://')):
                        image_refs.append((img_path, line_num))
    except Exception as e:
        print(f"⚠️  读取文件失败 {md_file}: {e}")

    return image_refs


def check_missing_images() -> Dict[str, List[Tuple[str, str, int]]]:
    """
    检查所有 Markdown 文件中引用的图片是否存在
    返回: {md_file: [(img_relative_path, img_full_path, line_num), ...]}
    """
    missing_images = {}

    # 遍历所有 .md 文件
    for md_file in UFBOOK_DOCS.rglob("*.md"):
        image_refs = find_image_references(md_file)

        for img_path, line_num in image_refs:
            # 相对于 md 文件的目录解析图片路径
            img_full_path = (md_file.parent / img_path).resolve()

            # 检查文件是否存在
            if not img_full_path.exists():
                if str(md_file) not in missing_images:
                    missing_images[str(md_file)] = []
                missing_images[str(md_file)].append((img_path, str(img_full_path), line_num))

    return missing_images


def parse_project_and_image(img_path: str, md_file_path: str) -> Tuple[str, str]:
    """
    从图片路径中解析出项目名称和图片文件名
    例如: "destiny-trigger-lighting/Screenshots/207_plus0.0s.png"
         -> ("destiny-trigger-lighting", "207_plus0.0s.png")
    """
    # 尝试从路径中提取项目名称和图片文件名
    parts = img_path.split('/')

    if len(parts) >= 2 and 'Screenshots' in parts:
        # 格式: project-name/Screenshots/image.png
        project_idx = parts.index('Screenshots') - 1
        if project_idx >= 0:
            project_name = parts[project_idx]
            image_name = parts[-1]
            return project_name, image_name

    # 如果无法从图片路径解析，尝试从 md 文件路径推断
    md_path = Path(md_file_path)
    relative_to_docs = md_path.relative_to(UFBOOK_DOCS)

    # 通常项目名称在路径中（例如: docs/rendering/destiny-trigger-lighting.md）
    if len(relative_to_docs.parts) >= 2:
        project_name = relative_to_docs.parts[-1].replace('.md', '')
        image_name = Path(img_path).name
        return project_name, image_name

    return "", ""


def find_source_image(project_name: str, image_name: str) -> Path:
    """
    在 uf2zhihu/projects 目录中查找源图片
    查找路径: uf2zhihu/projects/{project_name}/step3_screenshots/deduplication_report/images/{image_name}
    """
    source_path = (UF2ZHIHU_PROJECTS / project_name / "step3_screenshots" /
                   "deduplication_report" / "images" / image_name)

    if source_path.exists():
        return source_path

    # 尝试在 screenshots 目录（有些项目可能结构不同）
    alt_source_path = (UF2ZHIHU_PROJECTS / project_name / "step3_screenshots" /
                       "screenshots" / image_name)

    if alt_source_path.exists():
        return alt_source_path

    return None


def copy_missing_image(source: Path, destination: Path) -> bool:
    """
    复制图片到目标位置
    """
    try:
        # 确保目标目录存在
        destination.parent.mkdir(parents=True, exist_ok=True)

        # 复制文件
        shutil.copy2(source, destination)
        return True
    except Exception as e:
        print(f"❌ 复制失败: {e}")
        return False


def main():
    """主函数"""
    print("=" * 80)
    print("🔍 检查 MkDocs 文档中的缺失图片")
    print("=" * 80)
    print()

    # 检查缺失的图片
    print("📋 扫描 Markdown 文件...")
    missing_images = check_missing_images()

    if not missing_images:
        print("✅ 没有发现缺失的图片！")
        return

    # 统计
    total_missing = sum(len(imgs) for imgs in missing_images.values())
    print(f"⚠️  发现 {total_missing} 个缺失的图片，分布在 {len(missing_images)} 个文件中")
    print()

    # 处理缺失的图片
    copied_count = 0
    not_found_count = 0

    for md_file, images in missing_images.items():
        print(f"📄 {Path(md_file).relative_to(PROJ_ROOT)}")

        for img_path, img_full_path, line_num in images:
            print(f"   行 {line_num}: {img_path}")

            # 解析项目名称和图片文件名
            project_name, image_name = parse_project_and_image(img_path, md_file)

            if not project_name or not image_name:
                print(f"      ❌ 无法解析项目名称和图片文件名")
                not_found_count += 1
                continue

            # 查找源图片
            source_path = find_source_image(project_name, image_name)

            if source_path:
                print(f"      ✓ 找到源图片: {source_path.relative_to(PROJ_ROOT)}")

                # 复制图片
                destination = Path(img_full_path)
                if copy_missing_image(source_path, destination):
                    print(f"      ✅ 已复制到: {destination.relative_to(PROJ_ROOT)}")
                    copied_count += 1
                else:
                    not_found_count += 1
            else:
                print(f"      ❌ 未找到源图片 (项目: {project_name}, 图片: {image_name})")
                not_found_count += 1

        print()

    # 总结
    print("=" * 80)
    print("📊 处理结果:")
    print(f"   ✅ 成功复制: {copied_count} 个图片")
    print(f"   ❌ 未找到源: {not_found_count} 个图片")
    print(f"   📝 总计缺失: {total_missing} 个图片")
    print("=" * 80)


if __name__ == "__main__":
    main()
