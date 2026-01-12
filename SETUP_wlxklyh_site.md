# wlxklyh.site 域名关联 GitHub Pages 配置指南

## 📋 目标

将腾讯云域名 `wlxklyh.site` 关联到你的 GitHub Pages 网站

## 🎯 推荐方案

**使用自定义域名指向 GitHub Pages**（免费、简单、自动HTTPS）

---

## 🔧 配置步骤

### 第一步：在 GitHub 仓库中配置自定义域名

1. 进入你的 GitHub 仓库（例如：`https://github.com/wlxklyh/ufbook`）
2. 点击 **Settings** → **Pages**
3. 在 **Custom domain** 输入框中输入：`wlxklyh.site`
4. 点击 **Save**
5. 勾选 **Enforce HTTPS**（等 DNS 生效后再勾选）

### 第二步：创建 CNAME 文件

在项目的 `docs` 目录下创建 `CNAME` 文件：

```bash
cd d:\myws\github\proj\ufbook
echo wlxklyh.site > docs\CNAME
```

或者手动创建 `docs/CNAME` 文件，内容为：
```
wlxklyh.site
```

### 第三步：更新 mkdocs.yml 配置

修改 `mkdocs.yml` 中的 `site_url`：

```yaml
site_url: https://wlxklyh.site/
```

### 第四步：在腾讯云配置 DNS 解析（重要！）

**是的，你需要在腾讯云配置 DNS 解析！**

#### 具体操作：

1. 登录 [腾讯云 DNS 解析控制台](https://console.cloud.tencent.com/cns)
2. 找到域名 `wlxklyh.site`，点击 **解析**
3. 添加以下记录：

#### 选项 A：使用 CNAME 记录（推荐）

如果你想使用 `www.wlxklyh.site` 访问：

| 主机记录 | 记录类型 | 记录值 | TTL |
|---------|---------|--------|-----|
| www | CNAME | wlxklyh.github.io | 600 |

然后添加一个 URL 转发，将 `wlxklyh.site` 转发到 `www.wlxklyh.site`

#### 选项 B：使用 A 记录（推荐用于根域名）

如果你想直接使用 `wlxklyh.site` 访问（不带 www）：

| 主机记录 | 记录类型 | 记录值 | TTL |
|---------|---------|--------|-----|
| @ | A | 185.199.108.153 | 600 |
| @ | A | 185.199.109.153 | 600 |
| @ | A | 185.199.110.153 | 600 |
| @ | A | 185.199.111.153 | 600 |
| www | CNAME | wlxklyh.github.io | 600 |

> **说明：** 
> - `@` 表示根域名（wlxklyh.site）
> - 四个 A 记录是 GitHub Pages 的官方 IP 地址
> - www 的 CNAME 记录让 www.wlxklyh.site 也能访问

#### 腾讯云 DNS 设置截图示例：

```
记录列表：
┌─────────┬──────────┬────────────────────┬─────┐
│ 主机记录 │ 记录类型 │ 记录值              │ TTL │
├─────────┼──────────┼────────────────────┼─────┤
│ @       │ A        │ 185.199.108.153    │ 600 │
│ @       │ A        │ 185.199.109.153    │ 600 │
│ @       │ A        │ 185.199.110.153    │ 600 │
│ @       │ A        │ 185.199.111.153    │ 600 │
│ www     │ CNAME    │ wlxklyh.github.io  │ 600 │
└─────────┴──────────┴────────────────────┴─────┘
```

### 第五步：提交代码并部署

```bash
cd d:\myws\github\proj\ufbook

# 提交更改
git add docs\CNAME mkdocs.yml
git commit -m "feat: 添加自定义域名 wlxklyh.site"
git push origin main

# 部署到 GitHub Pages
scripts\deploy.bat
```

### 第六步：等待 DNS 生效

- DNS 解析通常需要 **5-30 分钟**生效
- 你可以使用以下命令检查：

```bash
# Windows PowerShell
nslookup wlxklyh.site

# 或使用在线工具
# https://tool.chinaz.com/dns/
```

### 第七步：启用 HTTPS

- 返回 GitHub Pages 设置页面
- 勾选 **Enforce HTTPS**
- GitHub 会自动为你的域名申请 SSL 证书
- 等待 **几分钟到几小时**后，HTTPS 会自动启用

---

## ✅ 验证步骤

完成所有配置后，你可以通过以下方式验证：

1. **检查 DNS 解析**
   ```bash
   nslookup wlxklyh.site
   ```
   应该看到指向 GitHub Pages 的 IP

2. **访问网站**
   - 打开浏览器访问 `http://wlxklyh.site`
   - 打开浏览器访问 `http://www.wlxklyh.site`

3. **检查 HTTPS**
   - 访问 `https://wlxklyh.site`
   - 查看浏览器地址栏是否显示安全锁图标

4. **检查 GitHub Pages 状态**
   - 进入仓库 Settings → Pages
   - 看到绿色提示："Your site is published at https://wlxklyh.site"

---

## 🐛 常见问题

### 1. DNS 解析不生效怎么办？

- 检查 DNS 记录是否正确配置
- 等待更长时间（最长可能需要 24-48 小时）
- 清除本地 DNS 缓存：
  ```bash
  ipconfig /flushdns
  ```

### 2. 网站显示 404 错误

- 确保 `docs/CNAME` 文件存在且内容正确
- 检查 GitHub Pages 设置中的自定义域名是否正确
- 重新部署：`scripts\deploy.bat`

### 3. HTTPS 证书未启用

- 等待 GitHub 自动申请证书（可能需要几小时）
- 确保 DNS 解析已生效
- 检查 GitHub Pages 设置中是否有错误提示

### 4. www 和非 www 都想访问怎么办？

- 按照"选项 B"配置 DNS
- 两个域名都可以正常访问
- GitHub 会自动处理重定向

---

## 📝 配置检查清单

- [ ] GitHub Pages 中配置了自定义域名 `wlxklyh.site`
- [ ] 创建了 `docs/CNAME` 文件
- [ ] 更新了 `mkdocs.yml` 中的 `site_url`
- [ ] 在腾讯云 DNS 中添加了 A 记录或 CNAME 记录
- [ ] 提交并推送了代码
- [ ] 执行了部署脚本
- [ ] 等待 DNS 生效（5-30 分钟）
- [ ] 验证网站可以访问
- [ ] 启用了 HTTPS

---

## 🎉 完成！

完成所有步骤后，你的网站将通过以下地址访问：
- `https://wlxklyh.site`
- `https://www.wlxklyh.site`（如果配置了 www）

同时仍然可以通过 GitHub Pages 默认地址访问：
- `https://wlxklyh.github.io/ufbook/`

---

## 🔗 相关链接

- [GitHub Pages 自定义域名文档](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)
- [腾讯云 DNS 解析控制台](https://console.cloud.tencent.com/cns)
- [DNS 解析检测工具](https://tool.chinaz.com/dns/)

---

## 💡 提示

如果你需要国内访问加速，可以考虑：
- 使用腾讯云 CDN（参考 `CUSTOM_DOMAIN_SETUP.md` 中的混合方案）
- 或者将内容部署到腾讯云服务器

但对于文档网站来说，直接使用 GitHub Pages + 自定义域名已经足够好用！

