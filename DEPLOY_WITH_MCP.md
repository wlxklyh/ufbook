# 使用 MCP 部署 ufbook - 超简单版

既然您有 CloudBase MCP，部署就变得超级简单了！

---

## 🎯 一句话部署

直接告诉我（AI 助手）：

```
请帮我将 ufbook 部署到 CloudBase：
1. 登录 CloudBase
2. 查询或创建环境（名称：ufbook-prod）
3. 更新 cloudbaserc.json 配置
4. 构建 MkDocs 网站
5. 上传到静态托管
6. 显示访问地址
```

我会自动完成所有步骤！

---

## 📋 前置条件（首次使用）

### 1. 确认 MCP 可用

您应该已经安装了 CloudBase MCP，可以通过以下方式确认：

**告诉我：**
```
请列出可用的 CloudBase MCP 工具
```

应该能看到这些工具：
- ✅ mcp_cloudbase_login
- ✅ mcp_cloudbase_uploadFiles
- ✅ mcp_cloudbase_envQuery
- ✅ 等等...

### 2. 准备腾讯云账号

确保您已经：
- ✅ 注册腾讯云账号：https://cloud.tencent.com/
- ✅ 完成实名认证

---

## 🚀 三步部署流程

### 步骤 1：登录（首次需要）

**告诉我：**
```
请帮我登录 CloudBase
```

我会引导您完成浏览器授权。

### 步骤 2：配置环境

**告诉我：**
```
请帮我配置 CloudBase 环境：
1. 如果没有 ufbook 环境，创建一个
2. 将环境 ID 更新到 cloudbaserc.json
3. 确认静态托管已开通
```

### 步骤 3：构建并部署

**告诉我：**
```
请帮我构建并部署 ufbook：
1. 运行 mkdocs build --clean
2. 上传 site 目录到 CloudBase 静态托管
3. 显示访问地址
```

---

## 🎨 可选：启用广告和评论

### 启用腾讯广告

**告诉我：**
```
请帮我启用腾讯广告：
1. 在 mkdocs.yml 设置 ads_enabled: true
2. 设置 tencent_ads_enabled: true
3. 配置广告位 ID：
   - 横幅：[您的ID]
   - 侧边栏：[您的ID]
   - 文章底部：[您的ID]
4. 重新构建并部署
```

### 启用 Giscus 评论

**先准备：**
1. 在 GitHub 仓库启用 Discussions
2. 安装 Giscus App：https://github.com/apps/giscus
3. 访问 https://giscus.app/zh-CN 生成配置

**然后告诉我：**
```
请帮我启用 Giscus 评论：
1. 在 mkdocs.yml 设置 comments_enabled: true
2. 设置 giscus_enabled: true
3. 配置 giscus 参数：
   - repo: yourusername/ufbook
   - repo_id: [您的ID]
   - category: Announcements
   - category_id: [您的ID]
4. 重新构建并部署
```

### 启用访问统计

**告诉我：**
```
请帮我启用百度统计，ID 是：[您的统计ID]
然后重新构建并部署
```

---

## 📝 日常更新流程

内容更新后，只需告诉我：

```
文档已更新，请重新构建并部署到 CloudBase
```

就这么简单！

---

## 💡 高级用法示例

### 批量配置

```
请帮我一次性完成以下配置：
1. 启用腾讯广告（ID: xxx, xxx, xxx）
2. 启用 Giscus 评论（repo: xxx, repo_id: xxx）
3. 启用百度统计（ID: xxx）
4. 重新构建并部署
```

### 绑定自定义域名

```
请帮我绑定域名 docs.yourdomain.com 到 CloudBase，
并配置 HTTPS 证书
```

### 查看部署状态

```
请帮我检查：
1. CloudBase 环境状态
2. 静态托管文件列表
3. 当前访问地址
4. 流量使用情况
```

---

## ⚠️ 常见问题

### Q1: MCP 工具不可用？

**A:** 确认 MCP 已正确安装和配置。告诉我：
```
请检查 CloudBase MCP 是否已安装
```

### Q2: 登录失败？

**A:** 告诉我：
```
请重新登录 CloudBase，并检查登录状态
```

### Q3: 上传失败？

**A:** 告诉我：
```
请检查：
1. CloudBase 环境是否存在
2. 静态托管是否已开通
3. site 目录是否已构建
```

### Q4: 网站访问 404？

**A:** 告诉我：
```
请检查：
1. 文件是否上传成功
2. cloudPath 配置是否正确（应该是 /）
3. 显示静态托管的文件列表
```

---

## 🎯 快速检查清单

部署前确认：

- [ ] CloudBase MCP 已安装
- [ ] 腾讯云账号已准备好
- [ ] 已通过 MCP 登录
- [ ] `cloudbaserc.json` 环境 ID 已配置
- [ ] （可选）广告、评论、统计配置已准备

然后一句话搞定：

```
请帮我部署 ufbook 到 CloudBase！
```

---

## 📚 详细文档

- **MCP 完整指南**：`CLOUDBASE_MCP_SETUP.md`
- **传统部署方式**：`CLOUDBASE_DEPLOYMENT.md`
- **快速开始**：`README_CLOUDBASE.md`

---

**准备好了吗？直接告诉我您想做什么！** 🚀

