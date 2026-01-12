# GitHub Pages 部署完整指南

## 📋 当前部署状态

✅ **Git 仓库已配置**: `https://github.com/wlxklyh/ufbook.git`  
⏳ **正在部署中**: 使用 `mkdocs gh-deploy --clean`

---

## 🚀 部署步骤（您正在执行）

### 第一步：自动部署（当前步骤）

```bash
cd d:\myws\github\proj\ufbook
mkdocs gh-deploy --clean
```

这个命令会：
1. 🏗️ 构建静态网站（生成 `site/` 目录）
2. 📤 创建/更新 `gh-pages` 分支
3. ⬆️ 自动推送到 GitHub

**预计时间**: 2-5 分钟（取决于网络速度）

---

### 第二步：GitHub 仓库配置（部署完成后执行）

部署命令执行完成后，需要在 GitHub 上配置 Pages：

#### 1️⃣ 进入仓库设置
访问：https://github.com/wlxklyh/ufbook/settings/pages

#### 2️⃣ 配置 Pages 源
在 **"Build and deployment"** 部分：
- **Source**: 选择 `Deploy from a branch`
- **Branch**: 选择 `gh-pages` 分支
- **Folder**: 选择 `/ (root)`
- 点击 **Save** 保存

#### 3️⃣ 等待部署完成
- 首次部署需要 3-10 分钟
- 可以在 Actions 标签页查看部署进度
- 部署成功后会显示网站 URL

---

## 🌐 访问地址

部署成功后，您的网站将在以下地址可访问：

**主要地址**:
```
https://wlxklyh.github.io/ufbook/
```

---

## ⚙️ mkdocs.yml 配置检查

让我检查一下您的配置文件是否需要调整：

### 当前配置
```yaml
site_url: https://wlxkly-cloudbase-6fpwf09dd84f56e.tcloudbaseapp.com/
repo_url: https://github.com/yourusername/ufbook
```

### 需要修改的配置

1. **site_url** - 更新为 GitHub Pages 地址：
```yaml
site_url: https://wlxklyh.github.io/ufbook/
```

2. **repo_url** - 更新为您的真实仓库：
```yaml
repo_url: https://github.com/wlxklyh/ufbook
```

3. **repo_name** - 保持不变即可：
```yaml
repo_name: ufbook
```

---

## 🔧 配置文件自动修复

执行以下脚本将自动修复配置：

### 方式 1：使用 PowerShell
```powershell
cd d:\myws\github\proj\ufbook

# 备份原配置
Copy-Item mkdocs.yml mkdocs.yml.backup

# 修改配置（下面会提供具体命令）
```

### 方式 2：手动修改
直接编辑 `mkdocs.yml` 文件，修改以下两行：
- 第 4 行：`site_url: https://wlxklyh.github.io/ufbook/`
- 第 8 行：`repo_url: https://github.com/wlxklyh/ufbook`

---

## 📝 部署后的工作流程

以后每次更新内容，只需要：

### 方式 1：使用脚本（推荐）
```bash
# Windows
scripts\deploy.bat
```

### 方式 2：使用命令
```bash
cd d:\myws\github\proj\ufbook
mkdocs gh-deploy --clean
```

### 方式 3：Git + 自动构建（需要配置 GitHub Actions）
```bash
git add .
git commit -m "docs: 更新内容"
git push origin main
# GitHub Actions 会自动部署（需要先配置 .github/workflows/）
```

---

## ⚠️ 常见问题排查

### 问题 1：部署命令卡住或超时
**原因**：网络连接问题或文件太大  
**解决**：
```bash
# 检查网络连接
git push origin main

# 如果推送成功，重新部署
mkdocs gh-deploy --clean
```

### 问题 2：404 错误
**原因**：GitHub Pages 未正确配置  
**解决**：
1. 检查是否选择了 `gh-pages` 分支
2. 确保分支已推送到远程
3. 等待 3-5 分钟让 GitHub 完成部署

### 问题 3：样式丢失或图片不显示
**原因**：`site_url` 配置不正确  
**解决**：
```yaml
# mkdocs.yml
site_url: https://wlxklyh.github.io/ufbook/  # 必须以 / 结尾
```

### 问题 4：权限错误
**原因**：Git 推送权限问题  
**解决**：
```bash
# 检查 Git 凭据
git config --list | findstr user

# 如果需要，重新配置
git config user.name "your-name"
git config user.email "your-email@example.com"
```

---

## 🎯 下一步操作清单

- [ ] 1. 等待 `mkdocs gh-deploy --clean` 命令完成
- [ ] 2. 修改 `mkdocs.yml` 中的 `site_url` 和 `repo_url`
- [ ] 3. 访问 GitHub 仓库设置页面配置 Pages
- [ ] 4. 等待 GitHub 部署完成（3-10分钟）
- [ ] 5. 访问 `https://wlxklyh.github.io/ufbook/` 检查网站
- [ ] 6. 如果有问题，查看 Actions 标签页的日志

---

## 📚 相关文档

- [GitHub Pages 配置说明](./GITHUB_PAGES_CONFIG.md)
- [自定义域名配置](./CUSTOM_DOMAIN_SETUP.md)
- [MkDocs 官方文档](https://www.mkdocs.org/)
- [GitHub Pages 文档](https://docs.github.com/en/pages)

---

## 💡 提示

### 双重部署支持
您可以同时保持：
- ✅ **GitHub Pages**: `https://wlxklyh.github.io/ufbook/`
- ✅ **腾讯云开发**: `https://wlxkly-cloudbase-6fpwf09dd84f56e.tcloudbaseapp.com/`

只需要分别部署即可：
```bash
# 部署到 GitHub Pages
mkdocs gh-deploy --clean

# 部署到腾讯云开发
scripts\deploy-to-cloudbase.bat
```

---

**创建时间**: 2025-01-13  
**最后更新**: 2025-01-13


