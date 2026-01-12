# GitHub Pages 关联腾讯云服务器配置指南

## 📋 概述

GitHub Pages 可以通过自定义域名关联到你的腾讯云服务器，主要有两种方式：

1. **方式一：使用自定义域名指向 GitHub Pages**（推荐）
   - 通过 DNS CNAME 记录将你的域名指向 GitHub Pages
   - 内容仍托管在 GitHub，但通过你的域名访问

2. **方式二：将内容同步到腾讯云服务器**
   - 将 GitHub Pages 的内容部署到你的腾讯云服务器
   - 完全由你的服务器托管

---

## 🌐 方式一：自定义域名指向 GitHub Pages（推荐）

### 优势
- ✅ 免费使用 GitHub Pages 的 CDN
- ✅ 自动 HTTPS 证书
- ✅ 无需维护服务器
- ✅ 自动更新（推送代码即更新）

### 配置步骤

#### 1. 在 GitHub 仓库中配置自定义域名

1. 进入 GitHub 仓库
2. 点击 **Settings** → **Pages**
3. 在 **Custom domain** 输入框中输入你的域名（例如：`docs.yourdomain.com`）
4. 勾选 **Enforce HTTPS**（推荐）
5. 点击 **Save**

#### 2. 在腾讯云 DNS 解析中配置 CNAME

1. 登录 [腾讯云 DNS 解析控制台](https://console.cloud.tencent.com/cns)
2. 找到你的域名，点击 **解析**
3. 添加 **CNAME 记录**：
   - **主机记录**：`docs`（或 `www`、`@` 等，根据你的需求）
   - **记录类型**：`CNAME`
   - **记录值**：`yourusername.github.io`（替换为你的 GitHub 用户名）
   - **TTL**：`600`（或默认值）

**示例：**
```
主机记录: docs
记录类型: CNAME
记录值: wlxklyh.github.io
TTL: 600
```

#### 3. 创建 CNAME 文件（可选，但推荐）

在项目的 `docs` 目录下创建 `CNAME` 文件：

```bash
cd ufbook/docs
echo docs.yourdomain.com > CNAME
```

或者手动创建文件 `docs/CNAME`，内容为：
```
docs.yourdomain.com
```

#### 4. 更新 mkdocs.yml 配置

修改 `mkdocs.yml` 中的 `site_url`：

```yaml
site_url: https://docs.yourdomain.com/
```

#### 5. 提交并部署

```bash
cd ufbook
git add docs/CNAME mkdocs.yml
git commit -m "feat: 添加自定义域名配置"
git push origin main

# 如果使用 gh-pages 分支部署
scripts\deploy.bat
```

#### 6. 等待 DNS 生效

- DNS 解析通常需要 **5-30 分钟**生效
- 可以使用 `nslookup` 或 `dig` 命令检查：
  ```bash
  nslookup docs.yourdomain.com
  ```

#### 7. 验证 HTTPS

- GitHub 会自动为自定义域名申请 SSL 证书
- 等待 **几分钟到几小时**后，HTTPS 会自动启用
- 在 GitHub Pages 设置中可以看到证书状态

---

## 🖥️ 方式二：将内容同步到腾讯云服务器

### 优势
- ✅ 完全控制服务器
- ✅ 可以添加后端功能
- ✅ 可以自定义服务器配置

### 配置步骤

#### 1. 在腾讯云服务器上安装 Nginx

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install nginx -y

# CentOS/RHEL
sudo yum install nginx -y
```

#### 2. 配置 Nginx

创建配置文件 `/etc/nginx/sites-available/ufbook`：

```nginx
server {
    listen 80;
    server_name docs.yourdomain.com;
    
    root /var/www/ufbook;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
    
    # 静态资源缓存
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

启用配置：
```bash
sudo ln -s /etc/nginx/sites-available/ufbook /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

#### 3. 创建部署目录

```bash
sudo mkdir -p /var/www/ufbook
sudo chown -R $USER:$USER /var/www/ufbook
```

#### 4. 创建自动同步脚本

创建 `scripts/deploy-to-tencent.sh`：

```bash
#!/bin/bash
# 部署到腾讯云服务器

echo "构建网站..."
mkdocs build --clean

echo "同步到服务器..."
rsync -avz --delete \
    --exclude='.git' \
    site/ \
    user@your-server-ip:/var/www/ufbook/

echo "部署完成！"
```

或者使用 Git 方式：

```bash
#!/bin/bash
# 在服务器上执行

cd /var/www/ufbook
git pull origin gh-pages
# 或从 main 分支构建
cd /path/to/ufbook
mkdocs build --clean
cp -r site/* /var/www/ufbook/
```

#### 5. 配置 GitHub Actions 自动部署（可选）

创建 `.github/workflows/deploy-tencent.yml`：

```yaml
name: Deploy to Tencent Cloud

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: pip install -r requirements.txt
      
      - name: Build site
        run: mkdocs build --clean
      
      - name: Deploy to Tencent Cloud
        uses: easingthemes/ssh-deploy@main
        env:
          SSH_PRIVATE_KEY: ${{ secrets.TENCENT_SSH_KEY }}
          ARGS: "-avz --delete"
          SOURCE: "site/"
          REMOTE_HOST: ${{ secrets.TENCENT_HOST }}
          REMOTE_USER: ${{ secrets.TENCENT_USER }}
          TARGET: "/var/www/ufbook/"
```

在 GitHub 仓库设置中添加 Secrets：
- `TENCENT_SSH_KEY`: 服务器的 SSH 私钥
- `TENCENT_HOST`: 服务器 IP 或域名
- `TENCENT_USER`: SSH 用户名

#### 6. 配置 SSL 证书（HTTPS）

使用腾讯云 SSL 证书或 Let's Encrypt：

```bash
# 安装 Certbot
sudo apt install certbot python3-certbot-nginx -y

# 申请证书
sudo certbot --nginx -d docs.yourdomain.com
```

更新 Nginx 配置以支持 HTTPS：

```nginx
server {
    listen 80;
    server_name docs.yourdomain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name docs.yourdomain.com;
    
    ssl_certificate /etc/letsencrypt/live/docs.yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/docs.yourdomain.com/privkey.pem;
    
    root /var/www/ufbook;
    index index.html;
    
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

---

## 🔄 混合方案：GitHub Pages + 腾讯云 CDN

### 配置步骤

1. **使用 GitHub Pages 作为源站**
   - 按照方式一配置自定义域名

2. **在腾讯云 CDN 中添加域名**
   - 登录 [腾讯云 CDN 控制台](https://console.cloud.tencent.com/cdn)
   - 添加域名：`docs.yourdomain.com`
   - 源站类型：**自有源**
   - 源站地址：`yourusername.github.io`
   - 回源 Host：`yourusername.github.io`

3. **配置 DNS**
   - 将域名的 CNAME 指向腾讯云 CDN 提供的地址
   - 例如：`docs.yourdomain.com` → `docs.yourdomain.com.cdn.dnsv1.com`

4. **配置 HTTPS**
   - 在腾讯云 CDN 中上传 SSL 证书
   - 或使用腾讯云免费证书

### 优势
- ✅ 利用腾讯云 CDN 加速（国内访问更快）
- ✅ 仍使用 GitHub Pages 托管（免费）
- ✅ 自动更新（推送代码即更新）

---

## 📝 配置检查清单

### 方式一（自定义域名）
- [ ] GitHub 仓库中配置了自定义域名
- [ ] 创建了 `docs/CNAME` 文件
- [ ] 更新了 `mkdocs.yml` 中的 `site_url`
- [ ] 在腾讯云 DNS 中添加了 CNAME 记录
- [ ] 等待 DNS 生效（5-30 分钟）
- [ ] 验证 HTTPS 证书已启用

### 方式二（服务器部署）
- [ ] 服务器已安装 Nginx
- [ ] 配置了 Nginx 虚拟主机
- [ ] 创建了部署目录
- [ ] 配置了自动部署脚本或 GitHub Actions
- [ ] 配置了 SSL 证书（HTTPS）

---

## 🐛 常见问题

### 1. DNS 解析不生效
- 检查 CNAME 记录是否正确
- 等待更长时间（最长可能需要 48 小时）
- 使用 `nslookup` 或 `dig` 检查解析结果

### 2. HTTPS 证书未启用
- 等待 GitHub 自动申请证书（可能需要几小时）
- 检查 DNS 解析是否正确
- 确保域名可以正常访问

### 3. 访问显示 404
- 检查 `mkdocs.yml` 中的 `site_url` 是否正确
- 检查 `docs/CNAME` 文件是否存在且内容正确
- 重新部署：`mkdocs gh-deploy --clean`

### 4. 服务器部署后样式丢失
- 检查 Nginx 配置中的 `root` 路径是否正确
- 检查文件权限
- 检查静态资源路径是否正确

---

## 🔗 相关链接

- [GitHub Pages 自定义域名文档](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)
- [腾讯云 DNS 解析文档](https://cloud.tencent.com/document/product/302)
- [腾讯云 CDN 文档](https://cloud.tencent.com/document/product/228)
- [Nginx 配置文档](https://nginx.org/en/docs/)

---

## 💡 推荐方案

**对于大多数用户，推荐使用方式一（自定义域名指向 GitHub Pages）：**
- 免费且简单
- 自动 HTTPS
- 无需维护服务器
- 自动更新

**如果需要国内加速，推荐混合方案（GitHub Pages + 腾讯云 CDN）：**
- 利用腾讯云 CDN 加速
- 仍使用免费的 GitHub Pages
- 国内访问速度更快

