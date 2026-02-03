<div align="center">

# 🎮 虚幻引擎技术文档库 | UE5 Technical Docs

### Unreal Fest 2025 上海站 · GDC 2025 演讲文字总结

**免费 · 中文 · 全面 · 持续更新**

[![在线阅读](https://img.shields.io/badge/🌐_在线阅读-wlxklyh.site-blue?style=for-the-badge)](https://wlxklyh.site/)
[![GitHub stars](https://img.shields.io/github/stars/wlxklyh/ufbook?style=for-the-badge&logo=github&label=Star)](https://github.com/wlxklyh/ufbook/stargazers)

[![Made with MkDocs](https://img.shields.io/badge/Made%20with-MkDocs-blue)](https://www.mkdocs.org/)
[![Material Theme](https://img.shields.io/badge/Theme-Material-pink)](https://squidfunk.github.io/mkdocs-material/)
[![License](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-nc-sa/4.0/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/wlxklyh/ufbook/pulls)

</div>

---

> 📚 本项目是对 **Unreal Fest 2025（虚幻引擎嘉年华）** 和 **GDC 2025** 演讲内容的文字总结版本（AI总结 + 人工校对），方便 UE5 开发者快速查阅和检索技术要点。
>
> **如果对你有帮助，请点个 ⭐ Star 支持一下！**

## 📖 关于本书

这些内容基于 **B站官方发布的演讲视频** 整理而成，涵盖了虚幻引擎5的最新功能、性能优化、渲染技术、移动开发、项目实战等多个领域的深度技术分享。

**本书特色**：
- ✅ **完整覆盖** - 52+ 篇技术文章，涵盖 UF2025 上海站全部演讲
- ✅ **AI+人工** - AI总结后经人工校对确保准确性
- ✅ **快速检索** - 支持中文全文搜索，快速定位技术要点
- ✅ **现代化阅读** - 基于 MkDocs Material 主题，深色/浅色模式
- ✅ **完全免费** - 开源项目，永久免费
- ✅ **持续更新** - 内容将持续更新完善

## 🔥 热门内容

| 热门文章 | 关键词 |
|---------|--------|
| 🎮 [漫威争锋 GAS 技能架构](https://wlxklyh.site/uf2025-shanghai/project-cases/marvel-rivals-gas/) | GAS、技能系统、网络同步 |
| 🌊 [鸣潮移动端光线追踪实现](https://wlxklyh.site/uf2025-shanghai/rendering/wuthering-waves-raytracing/) | 光线追踪、移动端、渲染优化 |
| ⚡ [UE5.7 Preview 新功能](https://wlxklyh.site/uf2025-shanghai/engine-features/ue5.7-preview/) | UE5.7、新特性、引擎更新 |
| 📊 [跨平台性能优化策略](https://wlxklyh.site/uf2025-shanghai/performance/cross-platform-optimization/) | 性能优化、帧卡顿、Profiling |
| 🎨 [PCG 程序化地牢生成](https://wlxklyh.site/uf2025-shanghai/pcg/dungeon-generation/) | PCG、程序化生成、关卡设计 |

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

| 章节 | 说明 | 关键技术点 |
|------|------|-----------|
| 📌 **引擎功能** | UE5.6/5.7 新特性 | Nanite、Lumen、MassEntity |
| ⚡ **性能优化** | 跨平台优化策略 | Profiling、内存优化、对象池 |
| 🎮 **渲染技术** | 渲染管线与光照 | 光线追踪、GI、后处理 |
| 📱 **移动开发** | 移动端适配 | 插帧、压缩、发热控制 |
| 🎨 **程序化生成** | PCG 系统 | 地牢生成、规则系统 |
| 🏃 **动画与物理** | 角色动画 | 布料模拟、物理动画 |
| 🛠️ **开发工具** | 开发效率 | Rider、调试工具、CI/CD |
| 🎯 **项目实战** | 商业案例 | 漫威争锋、鸣潮、CF 彩虹岛 |
| 🏢 **行业应用** | 非游戏领域 | 数字孪生、汽车HMI、AEC |
| 🚀 **引擎生态** | 生态发展 | Horde、EGS、元宇宙 |

**总计：52+ 篇深度技术文章，持续更新中**

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
- 📝 **文章数量**: 52+ 篇深度技术文章
- 🖼️ **配图数量**: 5000+ 张演讲截图
- 🌐 **多种输出**: HTML网站 + PDF文档

## 🏷️ GitHub Topics

本项目使用以下标签，方便开发者发现：

`unreal-engine` `ue5` `unreal-engine-5` `game-development` `gamedev` `documentation` `chinese` `unreal-fest` `gdc` `game-programming`

> 💡 如果你知道其他 UE5 相关的 awesome 列表，欢迎帮忙提交 PR 添加本项目！

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

<div align="center">

**如果这个项目对你有帮助，请点个 Star ⭐ 支持一下！**

[![Star History Chart](https://api.star-history.com/svg?repos=wlxklyh/ufbook&type=Date)](https://star-history.com/#wlxklyh/ufbook&Date)

</div>

---

<div align="center">

### 🚀 立即开始

[![在线阅读](https://img.shields.io/badge/🌐_在线阅读-wlxklyh.site-blue?style=for-the-badge)](https://wlxklyh.site/)
[![GitHub stars](https://img.shields.io/github/stars/wlxklyh/ufbook?style=for-the-badge&logo=github&label=Star)](https://github.com/wlxklyh/ufbook/stargazers)

**Built with ❤️ for Unreal Engine Community**

[📖 开始阅读](https://wlxklyh.site/) | [💬 加入交流群](#-技术交流) | [🐛 报告问题](https://github.com/wlxklyh/ufbook/issues)

---

**关键词 / Keywords**: `虚幻引擎` `UE5` `Unreal Engine 5` `游戏开发` `性能优化` `光线追踪` `Nanite` `Lumen` `GAS` `移动开发` `Unreal Fest` `GDC` `技术文档` `中文教程`

</div>
