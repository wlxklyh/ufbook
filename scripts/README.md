# GitBook 批处理脚本使用指南

## 📋 脚本列表

项目提供了一套完整的 Windows 批处理脚本，简化 GitBook 的日常操作。

### 🚀 快速开始

**方式一：使用菜单（推荐）**
```bash
scripts\menu.bat
```
会显示交互式菜单，选择对应的数字即可执行操作。

**方式二：直接运行脚本**
```bash
scripts\[脚本名].bat
```

---

## 📝 脚本详解

### 1️⃣ install.bat - 安装依赖

**功能**：首次使用时安装 GitBook 和相关依赖

**用法**：
```bash
scripts\install.bat
```

**执行步骤**：
1. 检查 Node.js 是否安装
2. 全局安装 GitBook CLI
3. 安装 book.json 中配置的插件

**前置要求**：
- 需要先安装 [Node.js](https://nodejs.org/)

---

### 2️⃣ serve.bat - 本地预览

**功能**：启动本地开发服务器，实时预览 GitBook

**用法**：
```bash
scripts\serve.bat
```

**特点**：
- 自动在浏览器打开 http://localhost:4000
- 修改文件后自动刷新
- 按 Ctrl+C 停止服务器

**适用场景**：
- 编写和调试内容时使用
- 检查文章格式和链接

---

### 3️⃣ build.bat - 构建网站

**功能**：构建静态网站文件到 `_book` 目录

**用法**：
```bash
scripts\build.bat
```

**输出**：
- 静态 HTML 文件在 `_book\` 目录
- 可以直接部署到任何静态网站托管服务

**适用场景**：
- 准备部署到服务器
- 生成最终产品

---

### 4️⃣ pdf.bat - 生成 PDF

**功能**：将 GitBook 导出为 PDF 电子书

**用法**：
```bash
scripts\pdf.bat
```

**前置要求**：
- 安装 [Calibre](https://calibre-ebook.com/download)
- 将 Calibre 添加到系统 PATH

**输出文件名格式**：
```
UF2025_虚幻引擎嘉年华演讲总结_20250104.pdf
```

**适用场景**：
- 制作离线版电子书
- 创建 Release 附件
- 方便读者下载收藏

**注意事项**：
- PDF 生成可能需要较长时间
- 建议内容较完整时再生成

---

### 5️⃣ update.bat - 更新推送

**功能**：快速提交并推送代码到 GitHub

**用法**：
```bash
scripts\update.bat
```

**执行流程**：
1. 显示当前 Git 状态
2. 要求输入提交信息
3. 执行 `git add .`
4. 执行 `git commit`
5. 推送到 GitHub main 分支

**适用场景**：
- 完成内容更新后快速推送
- 日常内容维护

**示例**：
```
请输入提交信息: docs: 添加性能优化章节
```

---

### 6️⃣ deploy.bat - 部署 GitHub Pages

**功能**：自动部署到 GitHub Pages

**用法**：
```bash
scripts\deploy.bat
```

**执行流程**：
1. 构建静态网站
2. 切换到 `gh-pages` 分支
3. 复制构建文件
4. 推送到 GitHub
5. 切换回 `main` 分支

**访问地址**（部署后）：
```
https://wlxklyh.github.io/ufbook/
```

**注意事项**：
- 首次部署需要在 GitHub 仓库设置中启用 Pages
- Settings → Pages → Source 选择 `gh-pages` 分支
- 部署后可能需要等待几分钟生效

---

### 7️⃣ release.bat - 创建发布

**功能**：创建 GitHub Release 版本

**用法**：
```bash
scripts\release.bat
```

**前置要求**：
- 安装 [GitHub CLI](https://cli.github.com/)
- 使用 `gh auth login` 登录 GitHub

**执行流程**：
1. 检查 GitHub CLI 和登录状态
2. 输入版本号（如 v1.0.0）
3. 输入发布说明
4. 创建 Git Tag
5. 可选：生成 PDF 并附加到 Release
6. 创建 GitHub Release

**适用场景**：
- 项目达到里程碑
- 发布新版本供下载

**示例**：
```
请输入版本号: v1.0.0
请输入发布说明: 完成所有UF2025演讲总结
是否生成 PDF 并附加到 Release? (Y/N): Y
```

---

### 8️⃣ stats.bat - 项目统计

**功能**：显示项目统计信息

**用法**：
```bash
scripts\stats.bat
```

**显示内容**：
- Markdown 文件数量
- Git 提交次数
- 最近 5 次提交
- 仓库信息
- 项目文件大小

**适用场景**：
- 了解项目进度
- 生成项目报告

---

### 9️⃣ clean.bat - 清理文件

**功能**：清理构建文件和缓存

**用法**：
```bash
scripts\clean.bat
```

**清理内容**：
- `_book\` - 构建输出目录
- `node_modules\` - 依赖包
- `*.pdf` - 生成的 PDF 文件
- GitBook 缓存

**适用场景**：
- 构建出现问题时清理重试
- 节省磁盘空间
- 重新安装依赖

**注意**：清理后需要重新运行 `install.bat`

---

### 🎯 menu.bat - 快速菜单

**功能**：交互式菜单，统一入口

**用法**：
```bash
scripts\menu.bat
```

**菜单界面**：
```
====================================
  GitBook 快速菜单
====================================

请选择操作:

 [1] 安装依赖 (首次使用)
 [2] 本地预览
 [3] 构建网站
 [4] 生成 PDF
 [5] 更新并推送
 [6] 部署到 GitHub Pages
 [7] 创建 Release
 [8] 查看统计
 [9] 清理文件
 [0] 退出
```

---

## 🔄 常用工作流

### 📝 日常更新内容
```bash
1. 编辑 Markdown 文件
2. scripts\serve.bat    # 本地预览
3. scripts\update.bat   # 推送到 GitHub
```

### 🚀 发布新版本
```bash
1. scripts\build.bat    # 构建测试
2. scripts\pdf.bat      # 生成 PDF
3. scripts\release.bat  # 创建 Release
4. scripts\deploy.bat   # 部署到 GitHub Pages
```

### 🔧 首次搭建
```bash
1. git clone https://github.com/wlxklyh/ufbook.git
2. cd ufbook
3. scripts\install.bat  # 安装依赖
4. scripts\serve.bat    # 预览测试
```

### 🐛 遇到问题时
```bash
1. scripts\clean.bat    # 清理文件
2. scripts\install.bat  # 重新安装
3. scripts\serve.bat    # 测试是否正常
```

---

## 💡 高级技巧

### 1. 自定义 PDF 文件名

编辑 `scripts\pdf.bat`，修改这一行：
```batch
set OUTPUT_FILE=你的自定义名称_%date:~0,4%%date:~5,2%%date:~8,2%.pdf
```

### 2. 自动化部署

可以配合 GitHub Actions 实现自动部署：
- 推送到 main 分支时自动构建
- 自动部署到 GitHub Pages

### 3. 批量操作

创建快捷方式到桌面：
```
目标: D:\myws\github\proj\ufbook\scripts\menu.bat
起始位置: D:\myws\github\proj\ufbook
```

---

## ❓ 常见问题

### Q: 运行脚本时提示编码错误？
**A**: 脚本已使用 UTF-8 编码（`chcp 65001`），如果仍有问题，请确保终端支持 UTF-8。

### Q: GitBook 安装失败？
**A**: 尝试以下步骤：
1. 检查 Node.js 版本（建议 v14-v16）
2. 清理 npm 缓存：`npm cache clean --force`
3. 使用管理员权限运行

### Q: PDF 生成失败？
**A**: 确保：
1. Calibre 已正确安装
2. Calibre 路径已添加到系统 PATH
3. 重启命令行窗口

### Q: 部署到 GitHub Pages 失败？
**A**: 检查：
1. 是否有 GitHub 仓库的推送权限
2. 仓库设置中是否启用了 Pages
3. `gh-pages` 分支是否正确创建

---

## 📞 获取帮助

如果遇到问题：
- 查看脚本输出的错误信息
- 检查 `使用指南.md` 中的说明
- 加微信群交流：**wlxklyh**

---

## 🎉 快速开始

**新手推荐**：
```bash
# 第一步：安装
scripts\menu.bat
选择 [1] 安装依赖

# 第二步：预览
选择 [2] 本地预览

# 第三步：编辑内容...

# 第四步：推送
选择 [5] 更新并推送
```

就是这么简单！🚀

