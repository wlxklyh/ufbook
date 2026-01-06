# 图片目录说明

本目录用于存放所有章节的图片资源。

## 📁 目录结构

```
images/
├── rendering/              # 渲染技术相关图片
├── performance/            # 性能优化相关图片
├── engine-features/        # 引擎功能相关图片
├── mobile/                 # 移动开发相关图片
├── pcg/                    # 程序化生成相关图片
├── animation-physics/      # 动画与物理相关图片
├── network/                # 网络相关图片
├── tools/                  # 开发工具相关图片
├── project-cases/          # 项目实战相关图片
├── industry/               # 行业应用相关图片
├── ecosystem/              # 引擎生态相关图片
└── appendix/               # 附录相关图片
```

## 📝 使用规范

### 1. 图片命名规范

- 使用英文命名，多个单词用 `-` 连接
- 包含序号便于排序（如：`01-`, `02-`）
- 命名要有描述性

**示例**：
```
01-rendering-pipeline-overview.png
02-global-illumination-comparison.jpg
03-performance-profiler-screenshot.png
```

### 2. 文件格式建议

- **截图**：PNG 格式（无损压缩，适合UI/代码截图）
- **照片**：JPG 格式（适合真实照片）
- **图表**：PNG/SVG 格式
- **动图**：GIF（小动画）或 MP4（较大动画转视频）

### 3. 文件大小控制

- 单张图片建议 < 500KB
- 大图可使用在线工具压缩：
  - TinyPNG: https://tinypng.com/
  - Squoosh: https://squoosh.app/

### 4. 在 Markdown 中引用

从任何章节的 markdown 文件引用图片，使用相对路径：

```markdown
![图片描述](../images/章节名/图片文件名.png)
```

**示例**：

在 `docs/rendering/wuthering-waves-raytracing.md` 中引用图片：
```markdown
![鸣潮光追效果对比](../images/rendering/01-raytracing-comparison.png)
```

在 `docs/performance/frame-hitches-hunting.md` 中引用图片：
```markdown
![性能分析器截图](../images/performance/01-profiler-screenshot.png)
```

### 5. 图片尺寸建议

- 常规截图：1920x1080 或更小
- 横向对比图：建议宽度 1200-1600px
- 竖向流程图：宽度 800-1200px
- 缩略图：建议 400x300 左右

## ✅ 最佳实践

1. **集中管理**：所有图片统一放在 `images/` 目录下
2. **按章节分类**：便于维护和查找
3. **版权注意**：确保图片来源合法
4. **添加描述**：在 Markdown 中使用有意义的 alt 文本
5. **定期清理**：删除未使用的图片

## 🔧 工具推荐

- **截图工具**：Snipaste, ShareX
- **图片编辑**：Paint.NET, GIMP
- **图片压缩**：TinyPNG, Squoosh
- **图片查看**：IrfanView, XnView

