# 从 GitBook 到 MkDocs 的迁移说明

## 📅 迁移时间

**2025-01-07**

## 🎯 迁移原因

1. **GitBook CLI 已停止维护**：GitBook 3.2.3 不再更新，兼容性差
2. **PDF 生成复杂**：GitBook 需要额外安装 Calibre 等软件
3. **功能受限**：主题定制困难，功能扩展性差
4. **现代化需求**：需要更好的搜索、深色模式、响应式设计等

## ✅ 迁移到 MkDocs 的优势

1. **✨ 现代化界面**：Material 主题美观且功能强大
2. **🔍 强大搜索**：支持中文全文搜索
3. **📱 响应式设计**：完美支持移动端
4. **🌓 深色模式**：自动切换深色/浅色主题
5. **📄 多格式导出**：轻松生成 PDF、ePub 等
6. **⚡ 快速构建**：Python 实现，速度快
7. **🔧 易于维护**：活跃的社区，持续更新
8. **🎨 丰富扩展**：Mermaid 图表、数学公式、代码高亮等

## 🔄 迁移完成的工作

### 1. 环境配置

✅ 创建 `requirements.txt`
```
mkdocs>=1.5.0
mkdocs-material>=9.0.0
pymdown-extensions>=10.0.0
mkdocs-minify-plugin>=0.7.0
mkdocs-mermaid2-plugin>=1.0.0
```

✅ 创建 `scripts/install.bat` 自动安装脚本

### 2. 项目结构调整

✅ 创建新的目录结构：
```
docs/                        # MkDocs 内容目录
├── rendering/               # 各章节 markdown
│   ├── wuthering-waves-raytracing/      # 文章专属图片文件夹
│   ├── wuthering-waves-raytracing.md
│   └── ...
├── performance/
│   ├── locke-kingdom-mobile-pipeline/   # 文章专属图片文件夹
│   ├── locke-kingdom-mobile-pipeline.md
│   └── ...
├── ... (其他章节)
├── images/                  # 可选：共享图片（如logo等）
└── index.md                 # 首页
```

✅ 迁移所有 Markdown 文件到 `docs/` 目录

### 3. 配置文件创建

✅ 创建 `mkdocs.yml` 主配置文件
- 站点信息配置
- Material 主题配置（颜色、字体、功能）
- 导航结构（11个章节，40+文章）
- Markdown 扩展配置
- 插件配置

### 4. 脚本工具

✅ 创建完整的 bat 脚本套件：
- `scripts/install.bat` - 依赖安装
- `scripts/serve.bat` - 本地预览
- `scripts/build-web.bat` - 构建网站
- `scripts/build-pdf.bat` - 生成PDF
- `scripts/deploy.bat` - 部署到 GitHub Pages
- `scripts/start.bat` - 交互式菜单

### 5. 文档更新

✅ 创建新的文档：
- `README.md` - 项目主页（全新设计）
- `使用指南-MkDocs.md` - 详细使用说明
- `docs/images/README.md` - 图片使用规范
- `MIGRATION.md` - 本迁移说明
- `.gitignore` - Git 忽略配置

### 6. 测试验证

✅ 测试通过的功能：
- Python 环境检测（Python 3.13.7）
- 依赖安装成功
- 网站构建成功（site/ 目录）
- 本地预览服务可用

## 📁 目录结构对比

### 旧的 GitBook 结构
```
ufbook/
├── rendering/               # 章节目录
│   └── article.md
├── book.json               # GitBook 配置
├── SUMMARY.md              # 目录文件
└── node_modules/           # Node.js 依赖
```

### 新的 MkDocs 结构
```
ufbook/
├── docs/                    # 📝 内容目录
│   ├── rendering/           # 📂 章节目录
│   │   ├── article/         # 🖼️ 文章专属图片文件夹
│   │   └── article.md
│   ├── performance/
│   │   ├── article/         # 🖼️ 文章专属图片文件夹
│   │   └── article.md
│   ├── images/              # 可选：共享图片（如logo等）
│   └── index.md             # 🏠 首页
├── scripts/                 # 🔧 工具脚本
├── mkdocs.yml               # ⚙️ 配置文件
├── requirements.txt         # 📦 Python 依赖
└── site/                    # 🌐 构建输出
```

## 🎨 功能对比

| 功能 | GitBook (旧) | MkDocs (新) |
|------|-------------|------------|
| **本地预览** | ✅ 有 | ✅ 有（更快） |
| **热重载** | ✅ 有 | ✅ 有 |
| **全文搜索** | ✅ 基础 | ✅ 强大（中文优化） |
| **深色模式** | ❌ 无 | ✅ 自动切换 |
| **响应式设计** | ✅ 基础 | ✅ 完美 |
| **代码高亮** | ✅ 有 | ✅ 更丰富 |
| **PDF 导出** | ⚠️ 需要 Calibre | ✅ Pandoc（更简单） |
| **图表支持** | ❌ 无 | ✅ Mermaid |
| **数学公式** | ⚠️ 插件 | ✅ 原生支持 |
| **主题定制** | ⚠️ 困难 | ✅ 容易 |
| **构建速度** | ⚠️ 较慢 | ✅ 快 |
| **社区活跃度** | ❌ 停止维护 | ✅ 活跃 |

## ⚠️ 兼容性说明

### 需要手动调整的内容

1. **链接引用**：
   - 旧：`[文章](../rendering/article.md)` 或 `[目录](../SUMMARY.md)`
   - 新：MkDocs 会自动处理，无需 `../`
   - 构建时会警告无效链接（如 SUMMARY.md）

2. **图片路径**：
   - 旧：可能是 `images/pic.png`（章节内）
   - 新：使用 `文章同名文件夹/pic.png`（与文章同目录下的专属文件夹）
   - 示例：在 `docs/performance/article.md` 中引用 `article/01-demo.png`

3. **GitBook 特有语法**：
   - 旧：`{% hint %}...{% endhint %}`
   - 新：使用 Material 的 admonitions：`!!! note "提示"`

### 保留的旧文件（可选清理）

以下文件已不再使用，可以考虑删除或移入备份目录：

```
book.json                    # GitBook 配置
SUMMARY.md                   # GitBook 目录
node_modules/                # Node.js 依赖
package.json                 # Node.js 配置
package-lock.json
_book/                       # GitBook 构建输出（如果有）
build_gitbook.bat            # 旧的 GitBook 脚本
serve_gitbook.bat
```

**建议**：先保留一段时间，确认新系统运行正常后再清理。

## 📝 待完成的工作

### 内容相关
- [ ] 检查所有内部链接，移除对 SUMMARY.md 的引用
- [ ] 添加实际的图片资源（目前只有目录结构）
- [ ] 完善各章节的内容（部分文章待更新）

### 功能增强（可选）
- [ ] 配置自定义域名
- [ ] 添加 Google Analytics
- [ ] 添加评论系统（Giscus/Utterances）
- [ ] 配置版本管理（mike）
- [ ] 自定义 CSS 样式

### PDF 优化（可选）
- [ ] 安装 Pandoc 和 LaTeX
- [ ] 优化 PDF 模板
- [ ] 测试 PDF 生成功能
- [ ] 调整中文字体配置

## 🚀 下一步行动

### 立即可用
1. ✅ 本地预览：`scripts\serve.bat`
2. ✅ 构建网站：`scripts\build-web.bat`
3. ✅ 部署：`scripts\deploy.bat`（需配置 GitHub Pages）

### 推荐顺序
1. **测试本地预览**：确保所有页面正常显示
2. **检查内部链接**：修复任何失效链接
3. **添加图片**：按规范添加图片资源
4. **完善内容**：填充待更新的文章
5. **部署上线**：推送到 GitHub Pages
6. **配置 PDF**：（可选）安装 Pandoc 测试 PDF 生成

## 📚 学习资源

推荐阅读以下文档以充分利用新系统：

1. **[MkDocs 官方文档](https://www.mkdocs.org/)**
2. **[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)**
3. **[Markdown 语法](https://markdown.com.cn/)**
4. **[使用指南-MkDocs.md](使用指南-MkDocs.md)**（本项目）

## ✅ 迁移成功标志

- [x] Python 环境已配置
- [x] MkDocs 依赖已安装
- [x] 所有 Markdown 文件已迁移
- [x] 目录结构已创建
- [x] 配置文件已完成
- [x] 脚本工具已就绪
- [x] 网站构建测试通过
- [x] 文档已更新

## 🎉 总结

迁移已成功完成！项目现在使用 **MkDocs + Material 主题**，拥有：

- ✨ **更现代的界面**
- ⚡ **更快的构建速度**
- 🔍 **更强大的搜索**
- 📱 **更好的移动端体验**
- 🔧 **更容易的维护**
- 🚀 **更活跃的社区支持**

**欢迎开始使用新系统！** 🎊

---

*如有任何问题，请参考 [使用指南-MkDocs.md](使用指南-MkDocs.md) 或在 Issues 中提问。*

