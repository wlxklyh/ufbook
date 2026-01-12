# GitHub Pages 配置方法说明

## 📋 概述

GitHub Pages 支持多种配置方式，**可以同时存在多个配置，但只能激活一个**。

## 🔧 配置方式对比

### 方式 1: gh-pages 分支（当前使用）

**特点：**
- ✅ 使用 `mkdocs gh-deploy` 命令自动部署
- ✅ 简单快速，适合手动部署
- ✅ 不需要 GitHub Actions

**使用方法：**
```bash
cd ufbook
scripts\deploy.bat
# 或
mkdocs gh-deploy --clean
```

**GitHub 设置：**
- Settings → Pages → Source: `gh-pages` 分支

---

### 方式 2: GitHub Actions（已添加）

**特点：**
- ✅ 自动部署，每次推送到 main 分支时自动构建
- ✅ 不需要手动执行部署命令
- ✅ 更灵活，可以自定义构建流程

**使用方法：**
1. 推送到 main 分支即可自动触发
2. 或手动触发：Actions → Deploy to GitHub Pages → Run workflow

**GitHub 设置：**
- Settings → Pages → Source: `GitHub Actions`

**配置文件：**
- `.github/workflows/gh-pages.yml`

---

## ⚙️ 如何切换配置方式

### 从方式 1 切换到方式 2

1. **在 GitHub 仓库设置中：**
   - 进入 Settings → Pages
   - 将 Source 从 `gh-pages` 分支改为 `GitHub Actions`
   - 保存

2. **之后的工作流：**
   - 每次推送到 main 分支，GitHub Actions 会自动构建和部署
   - 不再需要手动运行 `mkdocs gh-deploy`

### 从方式 2 切换回方式 1

1. **在 GitHub 仓库设置中：**
   - 进入 Settings → Pages
   - 将 Source 从 `GitHub Actions` 改为 `gh-pages` 分支
   - 保存

2. **手动部署：**
   - 运行 `scripts\deploy.bat` 或 `mkdocs gh-deploy --clean`

---

## 🔄 同时保留两种方式

**可以同时保留两种配置：**

- ✅ 保留 `gh-pages` 分支（即使不使用）
- ✅ 保留 `.github/workflows/gh-pages.yml`（即使不使用）
- ✅ 在 GitHub 设置中只激活其中一个

**优势：**
- 可以随时切换部署方式
- 如果一种方式出问题，可以快速切换到另一种
- 团队成员可以选择自己习惯的方式

---

## 📝 推荐方案

### 个人项目 / 小团队
**推荐：方式 1（gh-pages 分支）**
- 简单直接
- 手动控制部署时机
- 适合内容更新不频繁的情况

### 团队协作 / 频繁更新
**推荐：方式 2（GitHub Actions）**
- 自动化部署
- 每次推送自动更新网站
- 减少手动操作

---

## ⚠️ 注意事项

1. **只能激活一个源**
   - GitHub 设置中只能选择一个部署源
   - 同时激活两个会导致冲突

2. **gh-pages 分支**
   - 如果使用 GitHub Actions，gh-pages 分支可以保留但不会被使用
   - 可以删除，但建议保留作为备份

3. **首次使用 GitHub Actions**
   - 需要在仓库设置中启用 Pages
   - 选择 Source 为 `GitHub Actions`
   - 可能需要等待几分钟生效

4. **自定义域名**
   - 两种方式都支持自定义域名
   - 在 Settings → Pages → Custom domain 中配置
   - **详细配置指南**：请查看 [CUSTOM_DOMAIN_SETUP.md](./CUSTOM_DOMAIN_SETUP.md)
   - 支持关联腾讯云服务器（通过 DNS CNAME 或 CDN）

---

## 🚀 快速开始

### 使用方式 1（当前）
```bash
cd ufbook
scripts\deploy.bat
```

### 使用方式 2（自动）
```bash
cd ufbook
git add .
git commit -m "docs: 更新内容"
git push origin main
# GitHub Actions 会自动部署
```

---

## 🌐 自定义域名和服务器配置

### 关联腾讯云服务器

GitHub Pages 可以通过自定义域名关联到腾讯云服务器，支持以下方式：

1. **自定义域名指向 GitHub Pages**（推荐）
   - 通过 DNS CNAME 记录将域名指向 GitHub Pages
   - 内容仍托管在 GitHub，但通过你的域名访问
   - 免费且自动 HTTPS

2. **将内容同步到腾讯云服务器**
   - 将构建后的静态文件部署到你的服务器
   - 完全由你的服务器托管

3. **混合方案：GitHub Pages + 腾讯云 CDN**
   - 使用 GitHub Pages 作为源站
   - 通过腾讯云 CDN 加速（国内访问更快）

**详细配置步骤**：请查看 [CUSTOM_DOMAIN_SETUP.md](./CUSTOM_DOMAIN_SETUP.md)

---

## 📚 参考链接

- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [MkDocs 部署文档](https://www.mkdocs.org/user-guide/deploying-your-docs/)
- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [自定义域名配置指南](./CUSTOM_DOMAIN_SETUP.md)

