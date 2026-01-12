# 图片目录说明

本文档说明如何在项目中存放和引用图片资源。

## 📁 目录结构

每个 Markdown 文件都有一个**同名的专属图片文件夹**，图片存放在文章所在目录下：

```
docs/
├── performance/
│   ├── locke-kingdom-mobile-pipeline/       # locke-kingdom-mobile-pipeline.md 的图片
│   │   ├── 01-pipeline-overview.png
│   │   └── 02-performance-chart.png
│   ├── locke-kingdom-mobile-pipeline.md
│   ├── frame-hitches-hunting/               # frame-hitches-hunting.md 的图片
│   │   └── 01-profiler-screenshot.png
│   ├── frame-hitches-hunting.md
│   └── ...
├── rendering/
│   ├── wuthering-waves-raytracing/          # wuthering-waves-raytracing.md 的图片
│   │   └── 01-raytracing-comparison.png
│   ├── wuthering-waves-raytracing.md
│   └── ...
```

## 📝 使用规范

### 1. 图片文件夹命名

- 文件夹名称与 Markdown 文件名**完全一致**（不含 `.md` 扩展名）
- 例如：`frame-hitches-hunting.md` → `frame-hitches-hunting/` 文件夹

### 2. 图片文件命名规范

- 使用英文命名，多个单词用 `-` 连接
- 包含序号便于排序（如：`01-`, `02-`）
- 命名要有描述性

**示例**：
```
01-rendering-pipeline-overview.png
02-global-illumination-comparison.jpg
03-performance-profiler-screenshot.png
```

### 3. 文件格式建议

- **截图**：PNG 格式（无损压缩，适合UI/代码截图）
- **照片**：JPG 格式（适合真实照片）
- **图表**：PNG/SVG 格式
- **动图**：GIF（小动画）或 MP4（较大动画转视频）

### 4. 文件大小控制

- 单张图片建议 < 500KB
- 大图可使用在线工具压缩：
  - TinyPNG: https://tinypng.com/
  - Squoosh: https://squoosh.app/

### 5. 在 Markdown 中引用

在 Markdown 文件中引用图片时，使用**相对路径**指向同名文件夹：

```markdown
![图片描述](文章同名文件夹/图片文件名.png)
```

**示例**：

在 `docs/rendering/wuthering-waves-raytracing.md` 中引用图片：
```markdown
![鸣潮光追效果对比](wuthering-waves-raytracing/01-raytracing-comparison.png)
```

在 `docs/performance/frame-hitches-hunting.md` 中引用图片：
```markdown
![性能分析器截图](frame-hitches-hunting/01-profiler-screenshot.png)
```

在 `docs/performance/locke-kingdom-mobile-pipeline.md` 中引用图片：
```markdown
![洛克王国管线](locke-kingdom-mobile-pipeline/01-pipeline-overview.png)
```

### 6. 图片尺寸建议

- 常规截图：1920x1080 或更小
- 横向对比图：建议宽度 1200-1600px
- 竖向流程图：宽度 800-1200px
- 缩略图：建议 400x300 左右

## ✅ 最佳实践

1. **就近管理**：每篇文章的图片放在同名文件夹中，便于维护和查找
2. **文件夹与文章同名**：保持命名一致性，避免混淆
3. **版权注意**：确保图片来源合法
4. **添加描述**：在 Markdown 中使用有意义的 alt 文本
5. **定期清理**：删除未使用的图片
6. **相对路径引用**：使用 `文章名/图片.png` 格式引用

## 🔧 工具推荐

- **截图工具**：Snipaste, ShareX
- **图片编辑**：Paint.NET, GIMP
- **图片压缩**：TinyPNG, Squoosh
- **图片查看**：IrfanView, XnView

