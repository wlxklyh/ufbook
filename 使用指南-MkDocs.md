# UF Book 使用指南 (MkDocs版本)

本项目已从 GitBook 迁移到 **MkDocs + Material 主题**，提供更现代、更强大的文档生成功能。

## 🚀 快速开始

### 方式一：使用交互式菜单（推荐）

双击项目根目录下的 `scripts\start.bat`，会出现交互式菜单：

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

### 方式二：直接运行脚本

或者直接双击对应的脚本文件：

- **首次使用**：`scripts\install.bat` - 安装依赖
- **本地预览**：`scripts\serve.bat` - 启动开发服务器
- **构建网站**：`scripts\build-web.bat` - 生成静态HTML
- **生成PDF**：`scripts\build-pdf.bat` - 生成PDF文档
- **部署发布**：`scripts\deploy.bat` - 部署到GitHub Pages

## 📝 日常使用

### 1. 写作流程

#### 编辑 Markdown 文件

所有内容文件都在 `docs/` 目录下：

```
docs/
├── index.md                    # 首页
├── rendering/                  # 渲染技术章节
│   ├── wuthering-waves-raytracing.md
│   └── ...
├── performance/                # 性能优化章节
│   ├── frame-hitches-hunting.md
│   └── ...
└── ... (其他章节)
```

直接编辑对应的 `.md` 文件即可。

#### 添加图片

1. 在文章所在目录下创建与文章**同名的文件夹**（不含 `.md` 扩展名）
2. 将图片放在该同名文件夹中
3. 在 Markdown 中使用相对路径引用

```markdown
![图片描述](文章同名文件夹/图片.png)
```

**示例**：

假设你在编辑 `docs/rendering/wuthering-waves-raytracing.md`，要添加图片：
- 创建文件夹：`docs/rendering/wuthering-waves-raytracing/`
- 图片位置：`docs/rendering/wuthering-waves-raytracing/01-raytracing-demo.png`
- 引用方式：`![光追效果](wuthering-waves-raytracing/01-raytracing-demo.png)`

假设你在编辑 `docs/performance/locke-kingdom-mobile-pipeline.md`：
- 创建文件夹：`docs/performance/locke-kingdom-mobile-pipeline/`
- 图片位置：`docs/performance/locke-kingdom-mobile-pipeline/01-pipeline.png`
- 引用方式：`![管线图](locke-kingdom-mobile-pipeline/01-pipeline.png)`

详细规范请查看 `docs/images/README.md`

### 2. 本地预览

双击 `scripts\serve.bat` 或运行：

```bash
mkdocs serve
```

服务器会在 `http://127.0.0.1:8000` 启动，支持**热重载**（修改文件会自动刷新）。

按 `Ctrl+C` 停止服务。

### 3. 构建网站

双击 `scripts\build-web.bat` 或运行：

```bash
mkdocs build --clean
```

生成的静态网站在 `site/` 目录下，可以：
- 直接用浏览器打开 `site/index.html` 预览
- 部署到任何静态网站服务器

### 4. 生成 PDF

双击 `scripts\build-pdf.bat` 或运行相关命令。

**注意**：首次使用需要安装 [Pandoc](https://pandoc.org/installing.html) 和 LaTeX 环境（如 [MiKTeX](https://miktex.org/download)）。

生成的PDF在 `output/ufbook.pdf`。

### 5. 部署到 GitHub Pages

双击 `scripts\deploy.bat` 或运行：

```bash
mkdocs gh-deploy --clean
```

会自动：
1. 构建网站
2. 推送到 `gh-pages` 分支
3. 几分钟后在 GitHub Pages 上生效

**首次部署需要**：
- 在 GitHub 仓库设置中启用 Pages
- 选择 `gh-pages` 分支作为源

## ⚙️ 配置文件

### mkdocs.yml

主配置文件，包含：
- 站点信息（标题、作者、URL等）
- 主题配置（颜色、字体、功能特性）
- 导航结构（目录）
- Markdown 扩展
- 插件配置

修改后运行 `mkdocs serve` 即时预览效果。

### requirements.txt

Python 依赖列表，包含：
- mkdocs - 核心框架
- mkdocs-material - Material 主题
- pymdown-extensions - Markdown 扩展
- 其他插件

更新依赖：
```bash
pip install -r requirements.txt --upgrade
```

## 📚 目录结构

```
ufbook/
├── docs/                        # 📝 内容目录（MkDocs）
│   ├── rendering/               # 各章节 markdown
│   │   ├── wuthering-waves-raytracing/      # 文章专属图片文件夹
│   │   ├── wuthering-waves-raytracing.md
│   │   └── ...
│   ├── performance/
│   │   ├── locke-kingdom-mobile-pipeline/   # 文章专属图片文件夹
│   │   ├── locke-kingdom-mobile-pipeline.md
│   │   └── ...
│   ├── ... (其他章节)
│   ├── images/                  # 🖼️ 可选：共享图片（如logo等）
│   └── index.md                 # 首页
├── scripts/                     # 🔧 脚本工具
│   ├── install.bat
│   ├── serve.bat
│   ├── build-web.bat
│   ├── build-pdf.bat
│   ├── deploy.bat
│   └── start.bat                # 交互式菜单
├── site/                        # 🌐 构建输出（自动生成）
├── output/                      # 📄 PDF 输出（自动生成）
├── mkdocs.yml                   # ⚙️ MkDocs 配置
├── requirements.txt             # 📦 Python 依赖
└── README.md                    # 📖 项目说明
```

## 🎨 Material 主题特性

本项目使用 [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) 主题，内置功能：

### 界面功能
- ✅ 深色/浅色模式切换
- ✅ 全文搜索（支持中文）
- ✅ 响应式设计（移动端友好）
- ✅ 导航面包屑
- ✅ 返回顶部按钮
- ✅ 页面目录（右侧TOC）

### Markdown 增强
- ✅ 代码高亮（支持行号、复制）
- ✅ 提示块（admonitions）
- ✅ 表格、列表、脚注
- ✅ Emoji 支持 :rocket:
- ✅ 数学公式（LaTeX）
- ✅ Mermaid 图表

### 示例：提示块

```markdown
!!! note "提示"
    这是一个提示块

!!! warning "警告"
    这是一个警告块

!!! info "信息"
    这是一个信息块
```

### 示例：代码块

```markdown
​```cpp
// 支持语法高亮
void UnrealFunction() {
    UE_LOG(LogTemp, Log, TEXT("Hello UE5!"));
}
​```
```

更多功能请查看 [Material 官方文档](https://squidfunk.github.io/mkdocs-material/reference/)

## 🔧 环境要求

- **Python 3.7+**（推荐 3.10+）
- **pip**（Python 包管理器）
- **可选**：Pandoc + LaTeX（生成PDF需要）

### 检查环境

```bash
python --version    # 应显示 Python 3.x
pip --version       # 应正常显示版本号
```

### 安装依赖

```bash
cd ufbook
pip install -r requirements.txt
```

或使用国内镜像加速：
```bash
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
```

## 🆘 常见问题

### Q1: mkdocs 命令找不到？
**A**: 依赖未正确安装，运行 `scripts\install.bat` 或手动 `pip install -r requirements.txt`

### Q2: 本地预览端口冲突？
**A**: 修改端口：`mkdocs serve -a 127.0.0.1:8888`

### Q3: 图片不显示？
**A**: 检查图片路径是否正确，使用相对路径 `../images/章节/图片.png`

### Q4: 中文搜索不准确？
**A**: Material 主题已配置中文搜索，应该正常工作

### Q5: PDF 生成失败？
**A**: 确保已安装 Pandoc 和 MiKTeX/TeX Live

### Q6: 部署失败？
**A**: 检查：
- Git 仓库已初始化
- 已配置远程仓库（origin）
- 有推送权限

## 🔗 相关资源

- **MkDocs 官方文档**: https://www.mkdocs.org/
- **Material 主题文档**: https://squidfunk.github.io/mkdocs-material/
- **Markdown 语法**: https://markdown.com.cn/
- **Pandoc 用户手册**: https://pandoc.org/MANUAL.html

## 📞 技术支持

如有问题，欢迎：
- 查看本使用指南
- 阅读 `docs/appendix/faq.md`
- 加入技术交流群（见 `docs/appendix/join-community.md`）

---

**祝写作愉快！** ✨

