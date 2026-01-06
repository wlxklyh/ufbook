# 🚀 快速开始指南

## 📦 首次使用（3步）

### 1️⃣ 安装依赖
双击 `scripts\install.bat`

或手动运行：
```bash
pip install -r requirements.txt
```

### 2️⃣ 本地预览
双击 `scripts\serve.bat`

或手动运行：
```bash
mkdocs serve
```

### 3️⃣ 访问网站
打开浏览器访问：http://127.0.0.1:8000

---

## ⚡ 日常使用

### 📝 写作流程
1. 编辑 `docs/章节名/文章.md`
2. 图片放在 `docs/images/章节名/`
3. 保存文件（自动热重载）

### 🖼️ 添加图片
```markdown
![图片描述](../images/章节名/图片.png)
```

### 🌐 构建网站
双击 `scripts\build-web.bat`
→ 输出到 `site/` 目录

### 📄 生成 PDF
双击 `scripts\build-pdf.bat`（需要先安装 Pandoc）
→ 输出到 `output/ufbook.pdf`

### 🚀 部署发布
双击 `scripts\deploy.bat`
→ 自动部署到 GitHub Pages

---

## 🎯 交互式菜单

双击 `scripts\start.bat` 打开菜单：

```
========================================
  UF Book - 项目管理菜单
========================================

  1. 安装依赖环境
  2. 本地预览（实时更新）
  3. 构建静态网站
  4. 生成 PDF 文档
  5. 部署到 GitHub Pages

  0. 退出
========================================
```

---

## 📚 文档目录

| 文档 | 说明 |
|------|------|
| `README.md` | 项目介绍和总览 |
| `QUICKSTART.md` | 本快速指南 ⭐ |
| `使用指南-MkDocs.md` | 详细使用说明 |
| `MIGRATION.md` | 迁移说明 |
| `docs/images/README.md` | 图片使用规范 |

---

## 🔧 常用命令

```bash
# 本地预览
mkdocs serve

# 构建
mkdocs build --clean

# 部署
mkdocs gh-deploy --clean

# 安装/更新依赖
pip install -r requirements.txt --upgrade
```

---

## 💡 提示

- ✅ 修改 Markdown 后无需重启，自动刷新
- ✅ 支持深色/浅色模式切换（右上角图标）
- ✅ 使用左侧搜索框快速查找内容
- ✅ 代码块有一键复制按钮
- ✅ 图片点击可放大查看

---

## 🆘 遇到问题？

1. **命令找不到**：运行 `scripts\install.bat`
2. **端口冲突**：`mkdocs serve -a 127.0.0.1:8888`
3. **图片不显示**：检查路径 `../images/章节名/`
4. **更多帮助**：查看 `使用指南-MkDocs.md`

---

## 📞 获取帮助

- 📖 查看完整文档：`使用指南-MkDocs.md`
- 🐛 报告问题：GitHub Issues
- 💬 技术交流：加微信 wlxklyh

---

**祝写作愉快！** ✨

