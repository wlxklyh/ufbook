#!/usr/bin/env python3
"""
比对 ufbook/docs 和 uf2zhihu/projects 中的图片
对不一致的图片进行同步，并生成详细报告
"""

import os
import hashlib
import shutil
from pathlib import Path
from typing import Dict, List, Tuple
from datetime import datetime

# 项目根目录
PROJ_ROOT = Path(__file__).parent.parent.parent
UFBOOK_DOCS = PROJ_ROOT / "ufbook" / "docs"
UF2ZHIHU_PROJECTS = PROJ_ROOT / "uf2zhihu" / "projects"


def calculate_file_hash(file_path: Path) -> str:
    """
    计算文件的 SHA256 哈希值
    """
    sha256 = hashlib.sha256()
    try:
        with open(file_path, 'rb') as f:
            # 分块读取，避免大文件内存问题
            for chunk in iter(lambda: f.read(8192), b''):
                sha256.update(chunk)
        return sha256.hexdigest()
    except Exception as e:
        print(f"⚠️  计算哈希失败 {file_path}: {e}")
        return None


def find_all_images(base_dir: Path) -> List[Path]:
    """
    查找目录下所有图片文件
    """
    image_extensions = {'.png', '.jpg', '.jpeg', '.gif', '.bmp', '.svg', '.webp'}
    images = []

    for ext in image_extensions:
        images.extend(base_dir.rglob(f"*{ext}"))

    return sorted(images)


def extract_project_and_image_from_path(img_path: Path, base_dir: Path) -> Tuple[str, str]:
    """
    从图片路径中提取项目名称和图片文件名
    例如: docs/rendering/destiny-trigger-lighting/Screenshots/207_plus0.0s.png
         -> ("destiny-trigger-lighting", "207_plus0.0s.png")
    """
    try:
        relative_path = img_path.relative_to(base_dir)
        parts = relative_path.parts

        # 查找 Screenshots 目录
        if 'Screenshots' in parts:
            screenshot_idx = parts.index('Screenshots')
            if screenshot_idx > 0:
                project_name = parts[screenshot_idx - 1]
                image_name = parts[-1]
                return project_name, image_name

        # 如果没有 Screenshots 目录，尝试从路径结构推断
        if len(parts) >= 3:
            # 通常格式: category/project-name/image.png
            project_name = parts[-2]
            image_name = parts[-1]
            return project_name, image_name

    except Exception as e:
        pass

    return None, None


def find_source_image_in_uf2zhihu(project_name: str, image_name: str) -> Path:
    """
    在 uf2zhihu/projects 目录中查找对应的源图片
    """
    # 尝试多个可能的路径
    possible_paths = [
        UF2ZHIHU_PROJECTS / project_name / "step3_screenshots" / "deduplication_report" / "images" / image_name,
        UF2ZHIHU_PROJECTS / project_name / "step3_screenshots" / "screenshots" / image_name,
        UF2ZHIHU_PROJECTS / project_name / "FinalOutput" / "Screenshots" / image_name,
    ]

    for path in possible_paths:
        if path.exists():
            return path

    return None


def compare_images(img1: Path, img2: Path) -> Tuple[bool, dict]:
    """
    比较两个图片文件
    返回: (是否相同, 差异信息)
    """
    if not img1.exists() or not img2.exists():
        return False, {"reason": "文件不存在"}

    # 首先比较文件大小
    size1 = img1.stat().st_size
    size2 = img2.stat().st_size

    # 计算哈希值
    hash1 = calculate_file_hash(img1)
    hash2 = calculate_file_hash(img2)

    if hash1 == hash2:
        return True, {"size": size1, "hash": hash1}
    else:
        return False, {
            "ufbook_size": size1,
            "uf2zhihu_size": size2,
            "ufbook_hash": hash1,
            "uf2zhihu_hash": hash2,
            "size_diff": size2 - size1
        }


def format_size(size_bytes: int) -> str:
    """
    格式化文件大小
    """
    for unit in ['B', 'KB', 'MB', 'GB']:
        if size_bytes < 1024.0:
            return f"{size_bytes:.2f} {unit}"
        size_bytes /= 1024.0
    return f"{size_bytes:.2f} TB"


def generate_report(results: Dict) -> str:
    """
    生成对比报告
    """
    report_lines = []

    report_lines.append("=" * 100)
    report_lines.append("📊 图片比对同步报告")
    report_lines.append("=" * 100)
    report_lines.append(f"生成时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    report_lines.append("")

    # 统计信息
    total = results['total_images']
    identical = results['identical']
    different = results['different']
    not_found = results['not_found_in_uf2zhihu']
    synced = results['synced']

    report_lines.append("## 📈 统计摘要")
    report_lines.append(f"   总图片数量: {total}")
    report_lines.append(f"   ✅ 完全相同: {identical} ({identical/total*100:.1f}%)")
    report_lines.append(f"   ⚠️  内容不同: {different} ({different/total*100:.1f}%)")
    report_lines.append(f"   ❌ 未找到源: {not_found} ({not_found/total*100:.1f}%)")
    report_lines.append(f"   🔄 已同步: {synced}")
    report_lines.append("")

    # 详细列表
    if results['different_details']:
        report_lines.append("## ⚠️  内容不同的图片")
        report_lines.append("")
        for i, detail in enumerate(results['different_details'], 1):
            report_lines.append(f"{i}. {detail['relative_path']}")
            report_lines.append(f"   项目: {detail['project']}")
            report_lines.append(f"   ufbook 大小: {format_size(detail['diff']['ufbook_size'])}")
            report_lines.append(f"   uf2zhihu 大小: {format_size(detail['diff']['uf2zhihu_size'])}")
            report_lines.append(f"   大小差异: {format_size(abs(detail['diff']['size_diff']))}")
            report_lines.append(f"   状态: {'✅ 已同步' if detail['synced'] else '❌ 未同步'}")
            report_lines.append("")

    if results['not_found_details']:
        report_lines.append("## ❌ 在 uf2zhihu 中未找到源文件的图片")
        report_lines.append("")
        for i, detail in enumerate(results['not_found_details'], 1):
            report_lines.append(f"{i}. {detail['relative_path']}")
            report_lines.append(f"   项目: {detail['project']}")
            report_lines.append(f"   图片名: {detail['image_name']}")
            report_lines.append("")

    if results['identical_list']:
        report_lines.append(f"## ✅ 完全相同的图片 (共 {len(results['identical_list'])} 个)")
        report_lines.append("")
        for i, path in enumerate(results['identical_list'][:10], 1):
            report_lines.append(f"{i}. {path}")
        if len(results['identical_list']) > 10:
            report_lines.append(f"   ... 还有 {len(results['identical_list']) - 10} 个")
        report_lines.append("")

    report_lines.append("=" * 100)

    return "\n".join(report_lines)


def main():
    """主函数"""
    print("=" * 100)
    print("🔍 比对 ufbook 和 uf2zhihu 中的图片")
    print("=" * 100)
    print()

    # 查找所有图片
    print("📋 扫描 ufbook/docs 中的图片...")
    ufbook_images = find_all_images(UFBOOK_DOCS)
    print(f"   找到 {len(ufbook_images)} 个图片文件")
    print()

    # 结果统计
    results = {
        'total_images': len(ufbook_images),
        'identical': 0,
        'different': 0,
        'not_found_in_uf2zhihu': 0,
        'synced': 0,
        'different_details': [],
        'not_found_details': [],
        'identical_list': []
    }

    # 逐个比对
    print("🔄 开始比对图片...")
    print()

    for i, ufbook_img in enumerate(ufbook_images, 1):
        # 提取项目名称和图片名称
        project_name, image_name = extract_project_and_image_from_path(ufbook_img, UFBOOK_DOCS)

        if not project_name or not image_name:
            print(f"[{i}/{len(ufbook_images)}] ⚠️  无法解析路径: {ufbook_img.relative_to(UFBOOK_DOCS)}")
            continue

        # 查找对应的源图片
        uf2zhihu_img = find_source_image_in_uf2zhihu(project_name, image_name)

        relative_path = str(ufbook_img.relative_to(UFBOOK_DOCS))

        if not uf2zhihu_img:
            print(f"[{i}/{len(ufbook_images)}] ❌ 未找到源: {relative_path}")
            results['not_found_in_uf2zhihu'] += 1
            results['not_found_details'].append({
                'relative_path': relative_path,
                'project': project_name,
                'image_name': image_name
            })
            continue

        # 比对图片
        is_same, diff_info = compare_images(ufbook_img, uf2zhihu_img)

        if is_same:
            print(f"[{i}/{len(ufbook_images)}] ✅ 相同: {relative_path}")
            results['identical'] += 1
            results['identical_list'].append(relative_path)
        else:
            print(f"[{i}/{len(ufbook_images)}] ⚠️  不同: {relative_path}")
            print(f"             ufbook: {format_size(diff_info['ufbook_size'])}")
            print(f"             uf2zhihu: {format_size(diff_info['uf2zhihu_size'])}")

            results['different'] += 1

            # 同步图片
            try:
                shutil.copy2(uf2zhihu_img, ufbook_img)
                print(f"             🔄 已同步")
                synced = True
                results['synced'] += 1
            except Exception as e:
                print(f"             ❌ 同步失败: {e}")
                synced = False

            results['different_details'].append({
                'relative_path': relative_path,
                'project': project_name,
                'diff': diff_info,
                'synced': synced
            })

    print()
    print("=" * 100)

    # 生成报告
    report = generate_report(results)
    print(report)

    # 保存报告到文件
    report_file = PROJ_ROOT / "ufbook" / "image_comparison_report.txt"
    with open(report_file, 'w', encoding='utf-8') as f:
        f.write(report)

    print()
    print(f"📄 详细报告已保存到: {report_file.relative_to(PROJ_ROOT)}")
    print()


if __name__ == "__main__":
    main()
