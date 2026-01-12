# CloudBase 部署快速开始

本文档提供快速部署 ufbook 到腾讯云 CloudBase 的步骤说明。

---

## 💡 选择部署方式

### 方式一：使用 MCP（推荐，最简单）

如果您已安装 CloudBase MCP，直接告诉 AI 助手：

```
请帮我将 ufbook 部署到 CloudBase
```

AI 会自动完成所有步骤！

**详细说明**：[DEPLOY_WITH_MCP.md](DEPLOY_WITH_MCP.md) 或 [CLOUDBASE_MCP_SETUP.md](CLOUDBASE_MCP_SETUP.md)

### 方式二：使用 CLI（传统方式）

按照下面的步骤手动操作。

---

## 🚀 快速部署（5 分钟）- CLI 方式

### 步骤 1：创建 CloudBase 环境

1. 登录 [腾讯云 CloudBase 控制台](https://console.cloud.tencent.com/tcb)
2. 点击"新建环境"，选择"按量计费"
3. 记录环境 ID（如：`your-env-id-xxxxx`）
4. 开通"静态托管"服务

### 步骤 2：配置项目

编辑 `cloudbaserc.json`，替换环境 ID：

```json
{
  "envId": "your-env-id-xxxxx"  // ← 替换为您的环境 ID
}
```

### 步骤 3：安装 CLI 工具

```bash
# 安装 CloudBase CLI
npm install -g @cloudbase/cli

# 登录
tcb login
```

### 步骤 4：一键部署

**Windows 用户：**
```bash
scripts\deploy-to-cloudbase.bat
```

**或手动执行：**
```bash
mkdocs build --clean
tcb hosting:deploy site -e production
```

### 步骤 5：访问网站

部署成功后访问：`https://your-env-id.tcloudbaseapp.com/`

---

## 📝 配置广告和评论（可选）

### 启用腾讯广告

编辑 `mkdocs.yml`：

```yaml
extra:
  ads_enabled: true
  tencent_ads_enabled: true
  tencent_ad_banner_id: "您的广告位ID"
  tencent_ad_sidebar_id: "您的广告位ID"
  tencent_ad_article_id: "您的广告位ID"
```

### 启用评论系统

编辑 `mkdocs.yml`：

```yaml
extra:
  comments_enabled: true
  giscus_enabled: true
  giscus:
    repo: "yourusername/ufbook"
    repo_id: "您的仓库ID"
    category: "Announcements"
    category_id: "您的分类ID"
```

配置详情请参考：[giscus.app](https://giscus.app/zh-CN)

### 启用访问统计

编辑 `mkdocs.yml`：

```yaml
extra:
  # 百度统计
  baidu_analytics: "您的统计ID"
  
  # Google Analytics
  google_analytics: "G-XXXXXXXXXX"
```

---

## 📚 详细文档

- **完整部署指南**：[CLOUDBASE_DEPLOYMENT.md](CLOUDBASE_DEPLOYMENT.md)
- **自定义域名配置**：见完整文档第 8 章
- **常见问题排查**：见完整文档第 9 章

---

## 💰 成本说明

**免费额度：**
- 存储空间：5GB
- CDN 流量：5GB/月
- 回源流量：5GB/月

**预估费用：**
- 小型项目（< 1000访问/天）：**免费**
- 中型项目（< 5000访问/天）：¥10-30/月
- 大型项目（> 10000访问/天）：¥30-100/月

---

## 🛠️ 常用命令

```bash
# 本地预览
mkdocs serve

# 构建网站
mkdocs build --clean

# 部署到 CloudBase
tcb hosting:deploy site -e production

# 查看环境列表
tcb env:list

# 查看部署详情
tcb hosting:detail -e production
```

---

## 🔗 相关链接

- **CloudBase 控制台**：https://console.cloud.tencent.com/tcb
- **CloudBase 文档**：https://docs.cloudbase.net/
- **腾讯广告平台**：https://e.qq.com/
- **百度统计**：https://tongji.baidu.com/

---

## 📞 技术支持

遇到问题？
- 查看 [CLOUDBASE_DEPLOYMENT.md](CLOUDBASE_DEPLOYMENT.md) 完整文档
- 在 GitHub 提 Issue
- 加入 UE5 技术交流群（微信：wlxklyh）

---

**祝您部署顺利！🎉**

