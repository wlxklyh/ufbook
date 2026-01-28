# UF2025(Shanghai) 虚幻引擎嘉年华演讲文字总结

> 📚 本项目是对 **Unreal Fest Shanghai 2025（虚幻引擎嘉年华2025上海站）** 所有演讲内容的文字总结版本（AI总结 + 人工review），方便开发者快速查阅和检索技术要点。

[![Made with MkDocs](https://img.shields.io/badge/Made%20with-MkDocs-blue)](https://www.mkdocs.org/)
[![Material Theme](https://img.shields.io/badge/Theme-Material-pink)](https://squidfunk.github.io/mkdocs-material/)
[![License](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

## 📖 关于本书

这些内容基于 **B站官方发布的演讲视频** 整理而成，涵盖了虚幻引擎5的最新功能、性能优化、渲染技术、移动开发、项目实战等多个领域的深度技术分享。

**本书特色**：
- ✅ **完整覆盖** - 包含所有UF2025上海站演讲内容
- ✅ **AI+人工** - AI总结后经人工review确保准确性
- ✅ **快速检索** - 支持全文搜索，快速定位技术要点
- ✅ **现代化阅读** - 基于 MkDocs Material 主题，深色/浅色模式
- ✅ **多种格式** - 提供网站版和PDF版
- ✅ **持续更新** - 内容将持续更新完善

## 🚀 快速开始

### 在线阅读（推荐）

🌐 访问在线版本：**[https://wlxklyh.site/](https://wlxklyh.site/)**

### 本地运行

如果你想在本地运行或参与贡献：

#### 1. 克隆仓库

```bash
git clone https://github.com/wlxklyh/ufbook.git
cd ufbook
```

#### 2. 安装依赖

**Windows 用户**：双击 `scripts\install.bat`

**或手动安装**：
```bash
pip install -r requirements.txt
```

#### 3. 本地预览

**Windows 用户**：双击 `scripts\serve.bat`

**或手动运行**：
```bash
mkdocs serve
```

然后访问 http://127.0.0.1:8000

## 📂 内容分类

本书按照技术主题分为以下章节：

| 章节 | 说明 | 文章数 |
|------|------|--------|
| 📌 **引擎功能** | UE5最新功能与特性 | 4篇 |
| ⚡ **性能优化** | 跨平台性能优化策略 | 4篇 |
| 🎮 **渲染技术** | 光线追踪、全局光照等 | 5篇 |
| 📱 **移动开发** | 移动端开发最新进展 | 2篇 |
| 🎨 **程序化生成** | PCG系统应用 | 1篇 |
| 🏃 **动画与物理** | 布料、动画系统 | 2篇 |
| 🌐 **网络** | 网络架构与优化 | 待更新 |
| 🛠️ **开发工具** | 调试工具与开发流程 | 4篇 |
| 🎯 **项目实战** | 商业项目技术分享 | 5篇 |
| 🏢 **行业应用** | 数字孪生、AEC等 | 3篇 |
| 🚀 **引擎生态** | 引擎发展方向 | 4篇 |
| 📚 **附录** | 资源、FAQ等 | 3篇 |

**总计：40+ 篇专业技术文章**

## 🎯 适合人群

- 🎮 虚幻引擎开发者
- 💻 游戏程序员/TA/美术
- 🔍 想了解UE5最新技术的开发者
- 🚀 寻找项目优化方案的团队
- 📚 UE5学习者和研究者

## 🛠️ 技术栈

本项目使用以下技术构建：

- **[MkDocs](https://www.mkdocs.org/)** - 文档生成框架
- **[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)** - 现代化主题
- **[Pandoc](https://pandoc.org/)** - PDF生成（可选）
- **[GitHub Pages](https://pages.github.com/)** - 网站托管

### 功能特性

- ✨ 深色/浅色模式自动切换
- 🔍 全文搜索（支持中文）
- 📱 响应式设计（移动端友好）
- 🎨 语法高亮（支持多种语言）
- 📊 支持 Mermaid 图表
- 🔗 一键复制代码
- 📄 支持导出为 PDF

## 📝 使用指南

详细的使用说明请查看：

- **[使用指南-MkDocs.md](使用指南-MkDocs.md)** - 完整使用文档
- **[docs/images/README.md](docs/images/README.md)** - 图片使用规范

### 常用命令

```bash
# 本地预览（支持热重载）
mkdocs serve

# 构建静态网站
mkdocs build --clean

# 部署到 GitHub Pages
mkdocs gh-deploy --clean
```

### Windows 脚本快捷方式

双击 `scripts\start.bat` 打开交互式菜单，或直接运行：

- `scripts\install.bat` - 安装依赖
- `scripts\serve.bat` - 本地预览
- `scripts\build-web.bat` - 构建网站
- `scripts\build-pdf.bat` - 生成PDF
- `scripts\deploy.bat` - 部署发布

## 🤝 如何贡献

欢迎各种形式的贡献！你可以：

### 1. 报告问题
在 [Issues](https://github.com/wlxklyh/ufbook/issues) 中提交：
- 内容错误或不准确
- 排版问题
- 建议和想法

### 2. 改进内容
1. Fork 本仓库
2. 创建你的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的修改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

### 3. 内容规范
- Markdown 文件使用 UTF-8 编码
- 图片放在文章同名文件夹中，如 `docs/章节名/文章名/` 目录
- 图片命名使用英文，如 `01-feature-name.png`
- 图片引用格式：`![描述](文章名/图片.png)`
- 提交前本地预览确保无误

## 💬 技术交流

如果你在学习 UE5 过程中有任何问题，或者想与其他开发者交流经验：

**欢迎加我微信：wlxklyh**

一起加入 **UE5技术交流群**，目前群内已有众多真实的UE开发者，大家会分享：
- 💡 技术问题解答
- 📦 项目经验分享
- 🔗 独家学习资源
- 🤝 行业信息交流

**目标：打造500人的高质量UE5技术社区！**

## 📌 项目历程

- **2025-01-04**：项目初始化，创建基础框架（GitBook）
- **2025-01-07**：迁移到 MkDocs + Material 主题
- **持续更新中**...

## 📊 项目统计

- 📖 **章节数量**: 11 个技术章节
- 📝 **文章数量**: 40+ 篇深度技术文章
- 🖼️ **图片管理**: 支持按章节分类
- 🌐 **多种输出**: HTML网站 + PDF文档

## 🔗 相关链接

- **B站官方频道**: [虚幻引擎官方](https://space.bilibili.com/)
- **Epic Games**: https://www.unrealengine.com/
- **Unreal Fest**: https://www.unrealengine.com/zh-CN/events

## 📄 版权声明

本项目内容基于 B站官方公开演讲视频整理，仅供学习交流使用。

- 📚 文字内容采用 [CC BY-NC-SA 4.0](http://creativecommons.org/licenses/by-nc-sa/4.0/) 协议
- 🎥 视频版权归原作者和 Epic Games 所有
- ⚠️ 如有侵权，请联系删除

## ⭐ Star History

如果这个项目对你有帮助，欢迎给个 Star ⭐！

---

<div align="center">

**Built with ❤️ for Unreal Engine Community**

[📖 开始阅读](https://wlxklyh.site/) | [💬 加入交流群](#技术交流) | [🐛 报告问题](https://github.com/wlxklyh/ufbook/issues)

</div>
