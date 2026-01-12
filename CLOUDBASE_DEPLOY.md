# CloudBase 部署指南

## 📋 概述

本指南介绍如何将 ufbook 项目部署到腾讯云 CloudBase 静态网站托管服务，并集成广告功能。

## 🎯 使用 CloudBase 静态网站托管

**推荐服务**：**CloudBase Hosting（静态网站托管）**

### 为什么选择静态网站托管？

- ✅ **完全免费** - 提供免费额度，适合个人项目
- ✅ **CDN 加速** - 自动 CDN 分发，访问速度快
- ✅ **HTTPS 支持** - 自动配置 SSL 证书
- ✅ **自定义域名** - 支持绑定自己的域名
- ✅ **简单部署** - 一条命令即可部署
- ✅ **自动更新** - 支持 CI/CD 自动部署

## 🚀 快速开始

### 1. 安装 CloudBase CLI

**Windows (PowerShell)**:
```powershell
npm install -g @cloudbase/cli
```

**Linux/Mac**:
```bash
npm install -g @cloudbase/cli
```

### 2. 登录 CloudBase

```bash
tcb login
```

按照提示完成登录（支持微信扫码登录）。

### 3. 创建/选择环境

```bash
# 查看环境列表
tcb env:list

# 如果没有环境，在控制台创建：
# https://console.cloud.tencent.com/tcb
```

### 4. 设置环境 ID

**Windows**:
```cmd
set CLOUDBASE_ENV_ID=your-env-id
```

**Linux/Mac**:
```bash
export CLOUDBASE_ENV_ID=your-env-id
```

### 5. 构建并部署

**Windows**:
```cmd
scripts\deploy-to-cloudbase.bat
```

**Linux/Mac**:
```bash
chmod +x scripts/deploy-to-cloudbase.sh
./scripts/deploy-to-cloudbase.sh
```

**或手动部署**:
```bash
# 1. 构建网站
mkdocs build --clean

# 2. 部署到 CloudBase
tcb hosting:deploy site/ -e your-env-id
```

## 📢 广告集成

### 已集成的广告功能

项目已集成广告系统，支持多种广告平台：

- ✅ **Google AdSense**
- ✅ **百度联盟**
- ✅ **腾讯广告**
- ✅ **自定义广告**

### 配置广告

编辑 `docs/assets/javascripts/ads.js` 文件：

```javascript
const AD_CONFIG = {
    // 是否启用广告
    enabled: true,
    // 广告平台：'google', 'baidu', 'tencent', 'custom'
    platform: 'google',
    // 广告位置：'header', 'sidebar', 'footer', 'content'
    positions: ['sidebar', 'footer'],
    // 广告 ID（根据平台填写）
    adId: 'ca-pub-xxxxxxxxxxxxxxxx', // Google AdSense
};
```

### 广告位置

广告会在以下位置显示：

1. **侧边栏广告** (`#ad-container-sidebar`)
   - 位置：文章左侧导航栏下方
   - 推荐尺寸：300x250

2. **页脚广告** (`#ad-container-footer`)
   - 位置：页面底部
   - 推荐尺寸：728x90 或 300x250

### 添加广告容器（可选）

如果你想在特定位置添加广告，可以在 Markdown 文件中添加：

```html
<div id="ad-container-content"></div>
```

### 禁用广告

如果不想显示广告，修改 `docs/assets/javascripts/ads.js`：

```javascript
const AD_CONFIG = {
    enabled: false,  // 改为 false
    // ...
};
```

## 🔧 高级配置

### 绑定自定义域名

1. 在 CloudBase 控制台 → 静态网站托管 → 域名管理
2. 添加自定义域名
3. 配置 DNS 解析（CNAME 记录）
4. 等待 SSL 证书自动配置

### 配置 CDN 缓存

在 CloudBase 控制台可以配置：
- 缓存规则
- 压缩设置
- 防盗链
- 访问控制

### 环境变量配置

如果需要区分开发/生产环境，可以创建 `.env` 文件：

```bash
# .env
CLOUDBASE_ENV_ID=your-env-id
AD_ENABLED=true
AD_PLATFORM=google
```

## 📊 费用说明

### 免费额度

- **存储空间**：5GB
- **CDN 流量**：10GB/月
- **请求次数**：100万次/月

### 超出后计费

- 存储：0.004元/GB/天
- CDN 流量：0.21元/GB
- 请求：0.01元/万次

**对于个人文档网站，免费额度通常足够使用。**

## 🔄 CI/CD 自动部署

### GitHub Actions 示例

创建 `.github/workflows/cloudbase-deploy.yml`:

```yaml
name: Deploy to CloudBase

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: pip install -r requirements.txt
      
      - name: Build site
        run: mkdocs build --clean
      
      - name: Setup CloudBase CLI
        run: npm install -g @cloudbase/cli
      
      - name: Deploy to CloudBase
        env:
          TCB_ENV_ID: ${{ secrets.CLOUDBASE_ENV_ID }}
          TCB_SECRET_ID: ${{ secrets.CLOUDBASE_SECRET_ID }}
          TCB_SECRET_KEY: ${{ secrets.CLOUDBASE_SECRET_KEY }}
        run: |
          tcb login --apiKeyId $TCB_SECRET_ID --apiKey $TCB_SECRET_KEY
          tcb hosting:deploy site/ -e $TCB_ENV_ID
```

## 🐛 常见问题

### 1. 部署失败：未登录

**解决方案**：
```bash
tcb login
```

### 2. 部署失败：环境 ID 错误

**解决方案**：
```bash
# 查看环境列表
tcb env:list

# 设置正确的环境 ID
export CLOUDBASE_ENV_ID=your-env-id
```

### 3. 广告不显示

**检查清单**：
- ✅ 确认 `AD_CONFIG.enabled = true`
- ✅ 确认广告 ID 正确
- ✅ 检查浏览器控制台是否有错误
- ✅ 确认广告平台审核已通过（如 Google AdSense）

### 4. 访问速度慢

**优化建议**：
- 启用 CDN 加速（CloudBase 自动启用）
- 压缩图片资源
- 使用 WebP 格式图片
- 启用 Gzip 压缩

## 📚 相关资源

- [CloudBase 官方文档](https://docs.cloudbase.net/)
- [静态网站托管文档](https://docs.cloudbase.net/hosting/)
- [CloudBase CLI 文档](https://docs.cloudbase.net/cli-v1/intro)
- [Google AdSense](https://www.google.com/adsense/)
- [百度联盟](https://union.baidu.com/)

## 💡 最佳实践

1. **使用环境变量** - 不要在代码中硬编码环境 ID
2. **启用 CDN** - CloudBase 自动启用，无需额外配置
3. **配置缓存** - 合理设置静态资源缓存时间
4. **监控流量** - 定期查看控制台，避免超出免费额度
5. **备份数据** - 定期备份 `site/` 目录

---

**部署成功后，你的网站将拥有：**
- ✅ 全球 CDN 加速
- ✅ 自动 HTTPS
- ✅ 自定义域名支持
- ✅ 广告集成
- ✅ 高可用性

