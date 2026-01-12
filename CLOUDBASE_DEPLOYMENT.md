# 腾讯云 CloudBase 部署指南

本文档详细说明如何将 ufbook 项目部署到腾讯云 CloudBase 静态托管服务，并集成广告、评论和访问统计功能。

---

## 📋 目录

- [前置准备](#前置准备)
- [CloudBase 环境创建](#cloudbase-环境创建)
- [本地配置](#本地配置)
- [腾讯广告集成](#腾讯广告集成)
- [Giscus 评论系统配置](#giscus-评论系统配置)
- [访问统计配置](#访问统计配置)
- [部署发布](#部署发布)
- [自定义域名配置](#自定义域名配置)
- [常见问题](#常见问题)

---

## 前置准备

### 1. 注册腾讯云账号

1. 访问 [腾讯云官网](https://cloud.tencent.com/)
2. 注册账号并完成实名认证（个人或企业）
3. 实名认证需要 1-2 个工作日审核

### 2. 本地环境要求

```bash
# 确保已安装以下工具
- Python 3.7+
- pip
- Node.js 14+（用于 CloudBase CLI）
- Git
```

### 3. 安装依赖

```bash
# 安装 MkDocs 及插件
pip install -r requirements.txt

# 安装 CloudBase CLI
npm install -g @cloudbase/cli
```

---

## CloudBase 环境创建

### 1. 开通云开发服务

1. 登录 [腾讯云控制台](https://console.cloud.tencent.com/)
2. 搜索"云开发 CloudBase"
3. 点击"立即开通"

### 2. 创建环境

1. 进入 [CloudBase 控制台](https://console.cloud.tencent.com/tcb)
2. 点击"新建环境"
3. 填写环境信息：
   - **环境名称**：ufbook-prod（或自定义）
   - **环境类型**：按量计费（推荐，有免费额度）
   - **地域**：选择离用户最近的地域（如：上海、北京）
4. 点击"确定"创建

### 3. 开通静态托管

1. 在环境详情页，找到"静态托管"
2. 点击"开通静态托管"
3. 等待开通完成（约 1-2 分钟）

### 4. 获取环境 ID

在环境概览页可以看到 **环境 ID**（envId），格式如：`your-env-id-xxxxx`

记录此 ID，后续配置需要使用。

---

## 本地配置

### 1. 配置 CloudBase 环境 ID

编辑项目根目录的 `cloudbaserc.json` 文件：

```json
{
  "$schema": "https://framework-1258016615.tcloudbaseapp.com/schema/latest.json",
  "version": "2.0",
  "envId": "your-env-id-xxxxx",  // ← 替换为您的环境 ID
  "region": "ap-shanghai",       // ← 替换为您选择的地域
  "framework": {
    "name": "ufbook",
    "plugins": {
      "hosting": {
        "use": "@cloudbase/framework-plugin-website",
        "inputs": {
          "outputPath": "site",
          "cloudPath": "/",
          "ignore": [
            ".git",
            ".github",
            "node_modules",
            "docs",
            "scripts"
          ]
        }
      }
    }
  }
}
```

**地域代码对照表：**
- `ap-shanghai`：上海
- `ap-beijing`：北京
- `ap-guangzhou`：广州
- `ap-chengdu`：成都

### 2. 登录 CloudBase CLI

```bash
# 在终端运行
tcb login

# 会打开浏览器进行授权登录
# 登录成功后会在终端显示确认信息
```

### 3. 验证登录状态

```bash
# 查看环境列表
tcb env:list

# 应该能看到您刚创建的环境
```

---

## 腾讯广告集成

### 1. 申请腾讯广告账号

1. 访问 [腾讯广告平台](https://e.qq.com/)
2. 使用 QQ 或微信登录
3. 完成账号注册和身份验证
4. 提交网站信息审核（需要提供网站 URL、ICP 备案号等）

### 2. 创建广告位

1. 登录腾讯广告管理后台
2. 选择"媒体管理" → "新建媒体"
3. 添加您的网站信息
4. 创建广告位：
   - **横幅广告**：推荐尺寸 970x90 或 728x90
   - **侧边栏广告**：推荐尺寸 300x250
   - **文章底部广告**：推荐尺寸自适应
5. 获取每个广告位的 **广告位 ID**

### 3. 配置广告

编辑 `mkdocs.yml` 文件，更新广告配置：

```yaml
extra:
  # 启用广告
  ads_enabled: true
  
  # 腾讯广告配置
  tencent_ads_enabled: true
  tencent_ad_banner_id: "1234567890"      # ← 替换为您的横幅广告位 ID
  tencent_ad_sidebar_id: "1234567891"     # ← 替换为您的侧边栏广告位 ID
  tencent_ad_article_id: "1234567892"     # ← 替换为您的文章底部广告位 ID
```

### 4. 测试广告

```bash
# 本地预览
mkdocs serve

# 访问 http://127.0.0.1:8000
# 检查广告是否正常显示（开发环境可能显示测试广告）
```

---

## Giscus 评论系统配置

Giscus 是基于 GitHub Discussions 的免费评论系统，完全免费且无需后端。

### 1. 准备 GitHub 仓库

确保您的 GitHub 仓库满足以下条件：
- ✅ 仓库是公开的（Public）
- ✅ 已安装 [Giscus App](https://github.com/apps/giscus)
- ✅ 已启用 Discussions 功能

### 2. 启用 Discussions

1. 进入 GitHub 仓库
2. 点击 **Settings** → **General**
3. 找到 **Features** 部分
4. 勾选 **Discussions**

### 3. 安装 Giscus App

1. 访问 [Giscus App](https://github.com/apps/giscus)
2. 点击 **Install**
3. 选择要安装的仓库（可以只选择 ufbook 仓库）
4. 授权安装

### 4. 获取 Giscus 配置

1. 访问 [giscus.app](https://giscus.app/zh-CN)
2. 在"仓库"输入框中输入：`yourusername/ufbook`
3. 选择 Discussion 分类（推荐：Announcements）
4. 在页面底部可以看到生成的配置代码
5. 记录以下信息：
   - `data-repo`：仓库名称
   - `data-repo-id`：仓库 ID
   - `data-category`：分类名称
   - `data-category-id`：分类 ID

### 5. 配置评论系统

编辑 `mkdocs.yml` 文件：

```yaml
extra:
  # 启用评论
  comments_enabled: true
  
  # Giscus 配置
  giscus_enabled: true
  giscus:
    repo: "yourusername/ufbook"           # ← 替换为您的仓库
    repo_id: "R_kgDOxxxxxxx"              # ← 替换为您的仓库 ID
    category: "Announcements"
    category_id: "DIC_kwDOxxxxxxx"        # ← 替换为您的分类 ID
    mapping: "pathname"
    strict: "0"
    reactions_enabled: "1"
    emit_metadata: "0"
    input_position: "bottom"
    theme: "preferred_color_scheme"
    lang: "zh-CN"
    loading: "lazy"
```

### 6. 测试评论功能

```bash
# 本地预览
mkdocs serve

# 访问任意文章页面
# 滚动到底部，应该能看到评论框
# 使用 GitHub 账号登录后可以发表评论
```

---

## 访问统计配置

### 方案一：百度统计（推荐国内使用）

#### 1. 注册百度统计

1. 访问 [百度统计](https://tongji.baidu.com/)
2. 使用百度账号登录
3. 点击"新增网站"
4. 填写网站信息：
   - **网站域名**：您的 CloudBase 域名或自定义域名
   - **网站名称**：UF2025 虚幻引擎嘉年华演讲总结
   - **网站类型**：其他
5. 提交后获取统计代码

#### 2. 获取统计 ID

在统计代码中找到类似这样的代码：

```javascript
hm.src = "https://hm.baidu.com/hm.js?a1b2c3d4e5f6g7h8";
```

其中 `a1b2c3d4e5f6g7h8` 就是您的统计 ID。

#### 3. 配置百度统计

编辑 `mkdocs.yml` 文件：

```yaml
extra:
  # 百度统计
  baidu_analytics: "a1b2c3d4e5f6g7h8"  # ← 替换为您的统计 ID
```

### 方案二：Google Analytics 4

#### 1. 创建 GA4 账号

1. 访问 [Google Analytics](https://analytics.google.com/)
2. 使用 Google 账号登录
3. 点击"开始衡量"
4. 创建账号和媒体资源
5. 选择"网站"作为数据流类型
6. 填写网站信息

#### 2. 获取测量 ID

在数据流详情页找到 **测量 ID**，格式如：`G-XXXXXXXXXX`

#### 3. 配置 Google Analytics

编辑 `mkdocs.yml` 文件：

```yaml
extra:
  # Google Analytics
  google_analytics: "G-XXXXXXXXXX"  # ← 替换为您的测量 ID
```

### 同时使用两种统计

```yaml
extra:
  baidu_analytics: "a1b2c3d4e5f6g7h8"
  google_analytics: "G-XXXXXXXXXX"
```

---

## 部署发布

### 1. 本地测试构建

```bash
# 构建静态网站
mkdocs build --clean

# 检查 site/ 目录是否生成正确
ls site/
```

### 2. 部署到 CloudBase

使用提供的部署脚本：

#### Windows 用户：

```bash
# 双击运行或在终端执行
scripts\deploy-to-cloudbase.bat
```

#### 手动部署：

```bash
# 1. 构建网站
mkdocs build --clean

# 2. 部署到 CloudBase
tcb hosting:deploy site -e production

# 3. 查看部署详情
tcb hosting:detail -e production
```

### 3. 查看部署结果

部署成功后，在终端会显示访问地址，格式如：

```
https://your-env-id-xxxxx.tcloudbaseapp.com/
```

在浏览器访问此地址，检查：
- ✅ 页面是否正常显示
- ✅ 广告是否加载
- ✅ 评论框是否显示
- ✅ 统计代码是否生效（可在浏览器控制台查看）

### 4. 刷新 CDN 缓存（可选）

如果更新后页面未变化，可以手动刷新缓存：

```bash
# 刷新所有缓存
tcb hosting:detail -e production
```

或在 CloudBase 控制台：
1. 进入"静态托管"
2. 点击"缓存配置"
3. 点击"刷新缓存"

---

## 自定义域名配置

使用自定义域名可以提升品牌形象和 SEO 效果。

### 1. 准备域名

- 确保您拥有一个已备案的域名（国内服务器必须备案）
- 如果没有备案，需先完成 [ICP 备案](https://console.cloud.tencent.com/beian)

### 2. 在 CloudBase 添加域名

1. 进入 CloudBase 控制台
2. 选择您的环境
3. 点击"静态托管" → "域名管理"
4. 点击"添加域名"
5. 输入您的域名，如：`docs.yourdomain.com`
6. 点击"确定"

### 3. 配置 DNS 解析

1. 登录 [腾讯云 DNS 解析控制台](https://console.cloud.tencent.com/cns)
2. 找到您的域名，点击"解析"
3. 添加 CNAME 记录：
   - **主机记录**：`docs`（或其他子域名）
   - **记录类型**：`CNAME`
   - **记录值**：CloudBase 提供的 CNAME 地址（如：`your-env-id.tcloudbaseapp.com`）
   - **TTL**：`600`
4. 点击"保存"

### 4. 配置 HTTPS 证书

1. 在"域名管理"页面，找到刚添加的域名
2. 点击"配置证书"
3. 选择以下方式之一：
   - **自动申请**：CloudBase 自动申请免费证书（推荐）
   - **上传证书**：使用您自己的 SSL 证书
4. 等待证书配置完成（自动申请约需 10-30 分钟）

### 5. 更新项目配置

编辑 `mkdocs.yml` 文件：

```yaml
site_url: https://docs.yourdomain.com/  # ← 替换为您的自定义域名
```

重新部署：

```bash
scripts\deploy-to-cloudbase.bat
```

### 6. 验证域名

1. 等待 DNS 解析生效（5-30 分钟）
2. 访问您的自定义域名
3. 检查 HTTPS 证书是否正常

---

## 常见问题

### 1. 部署失败：未找到环境

**错误信息：**
```
Error: 未找到环境 your-env-id
```

**解决方案：**
- 检查 `cloudbaserc.json` 中的 `envId` 是否正确
- 运行 `tcb env:list` 查看可用环境列表
- 确保已登录：`tcb login`

### 2. 广告不显示

**可能原因：**
- 广告位 ID 配置错误
- 广告审核未通过
- 浏览器安装了广告拦截插件
- 本地开发环境（广告可能仅在生产环境显示）

**解决方案：**
- 检查 `mkdocs.yml` 中的广告配置
- 在腾讯广告后台查看广告状态
- 在浏览器无痕模式测试
- 部署到 CloudBase 后再测试

### 3. 评论框不显示

**可能原因：**
- GitHub Discussions 未启用
- Giscus App 未安装
- 仓库不是公开的
- 配置信息错误

**解决方案：**
- 检查仓库设置
- 重新在 giscus.app 生成配置
- 检查浏览器控制台是否有错误信息
- 确保 `comments_enabled` 和 `giscus_enabled` 都设置为 `true`

### 4. 统计不生效

**可能原因：**
- 统计 ID 配置错误
- 浏览器启用了隐私保护（如 Brave、Firefox 严格模式）
- 本地开发环境（统计在 localhost 可能不工作）

**解决方案：**
- 检查 `mkdocs.yml` 中的统计配置
- 部署到 CloudBase 后等待 24 小时查看数据
- 在浏览器控制台查看是否有统计脚本加载
- 使用浏览器开发者工具的 Network 标签查看请求

### 5. 自定义域名访问 404

**可能原因：**
- DNS 解析未生效
- CNAME 记录配置错误
- 域名未备案

**解决方案：**
- 使用 `nslookup` 或 `dig` 命令检查 DNS 解析
- 等待更长时间（DNS 最长可能需要 48 小时生效）
- 检查域名备案状态
- 在 CloudBase 控制台查看域名状态

### 6. 部署后页面样式丢失

**可能原因：**
- `site_url` 配置错误
- 静态资源路径错误
- CDN 缓存问题

**解决方案：**
- 检查 `mkdocs.yml` 中的 `site_url` 是否正确
- 确保 `site_url` 以 `/` 结尾
- 刷新 CDN 缓存
- 清除浏览器缓存（Ctrl + Shift + R）

### 7. 构建失败：找不到模板

**错误信息：**
```
Error: Template not found: partials/ads.html
```

**解决方案：**
- 确保 `overrides/` 目录结构完整
- 检查文件路径是否正确
- 确保 `mkdocs.yml` 中配置了 `custom_dir: overrides`

### 8. CloudBase 免费额度用完了

**查看用量：**
1. 进入 CloudBase 控制台
2. 点击"资源统计"
3. 查看当前用量

**优化方案：**
- 启用 CDN 缓存（减少回源流量）
- 压缩图片（减小文件大小）
- 使用图床服务（如腾讯云 COS）
- 升级到包年包月套餐（更优惠）

---

## 技术支持

### 官方文档

- **CloudBase 文档**：https://docs.cloudbase.net/
- **MkDocs 文档**：https://www.mkdocs.org/
- **Material 主题文档**：https://squidfunk.github.io/mkdocs-material/
- **Giscus 文档**：https://giscus.app/zh-CN

### 社区支持

如果遇到问题，欢迎：
- 在 GitHub 仓库提 Issue
- 加入 UE5 技术交流群（微信：wlxklyh）
- 查看项目 FAQ 文档

---

## 附录

### 成本预估表

| 项目 | 免费额度 | 超出后价格 | 备注 |
|------|----------|------------|------|
| 存储空间 | 5GB | ¥0.02/GB/月 | 本项目约 100MB |
| CDN 流量 | 5GB/月 | ¥0.18/GB | 按实际使用计费 |
| 回源流量 | 5GB/月 | ¥0.18/GB | 启用 CDN 缓存可减少 |
| 自定义域名 | 免费 | 免费 | 需要备案 |
| HTTPS 证书 | 免费 | 免费 | 自动申请 |

**预估月成本：**
- 小型项目（1000访问/天）：¥0-10/月
- 中型项目（5000访问/天）：¥10-30/月
- 大型项目（10000+访问/天）：¥30-100/月

### 更新日志

- **2025-01-13**：初始版本
- 支持腾讯广告集成
- 支持 Giscus 评论系统
- 支持百度统计和 Google Analytics
- 支持一键部署到 CloudBase

---

**祝部署顺利！🎉**


