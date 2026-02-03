# 智能座舱3D HMI深度解析：从量产交付到持续运营的技术演进之路

---

![UE5 技术交流群](3d-hmi-operations/UE5_Contact.png)

## 加入 UE5 技术交流群

如果您对虚幻引擎5的图形渲染技术感兴趣，欢迎加入我们的 **UE5 技术交流群**！

扫描上方二维码添加个人微信 **wlxklyh**，备注"UE5技术交流"，我会拉您进群。

在技术交流群中，您可以：
- 与其他UE开发者交流渲染技术经验
- 获取最新的GDC技术分享和解读
- 讨论图形编程、性能优化、构建工具流、动画系统等话题
- 分享引擎架构、基建工具等项目经验和技术难题

---

**源视频信息**
- **视频标题**: [UFSH2025]虚幻引擎助力智能座舱3D HMI从交付走向运营 | 陈治 武汉光庭信息 技术总监
- **视频链接**: https://www.bilibili.com/video/BV1p5mzBAEtq
- **视频时长**: 约29分钟
- **AI生成说明**: 本文基于AI技术对视频内容进行整理和深度解析，结合截图进行图文并茂的呈现。

---

> **导读摘要**
> 
> - 本文深入解析智能座舱3D HMI领域从量产交付到持续运营的技术演进，涵盖行业发展趋势、技术挑战与解决方案
> - 核心技术路线：基于虚幻引擎的座舱一体化渲染方案 + 参数化场景构建系统 + 云端配置下发机制
> - 前置知识：虚幻引擎基础、嵌入式系统开发、车载HMI设计原理

---

## 一、背景与行业演进

### 1.1 3D HMI 的发展历程

![Screenshot 1](3d-hmi-operations/Screenshots/001_plus0.0s.png)

武汉光庭信息作为 Epic 在座舱领域的官方合作伙伴，从 2020 年开始接触虚幻引擎，将其应用于智能座舱 3D HMI 的量产开发。这是一个从 2021 年开始到 2025 年发展极为迅速的行业方向。

![Screenshot 2](3d-hmi-operations/Screenshots/008_plus0.0s.png)

演讲主要分为四个部分：
1. 3D HMI 的发展演进
2. 量产交付中的未来方向判断
3. **如何从交付走向运营**（核心重点）
4. 对虚幻引擎后续发展的期望

### 1.2 为什么汽车需要 3D 化

![Screenshot 3](3d-hmi-operations/Screenshots/015_plus0.0s.png)

> **核心洞察**：虚幻引擎对各个行业都是一个技术红利，但不能单纯让技术来驱动，要考虑如何落实到产品中真正起到产品的价值。

从信息呈现维度来分析：

**一维信息载体（书籍）**
- 体积可以忽略不计
- 能够传达信息是最核心的价值

**二维信息载体（电视、平板、手机）**
- 呈现图片、视频及交互
- 面积是关注的重点
- 体积厚度相对不重要

**三维信息载体（汽车）**
- 汽车是天然的三维产品
- 运行在真实世界的三维空间中
- 内部提供一个空间让用户体验
- 自身也是完整的三维形态，需要美感设计

因此，**3D 界面的设计更多会围绕汽车的三维价值来落地**。

### 1.3 当前量产的 3D HMI 功能模块

![Screenshot 4](3d-hmi-operations/Screenshots/051_plus0.0s.png)

当前量产工作主要围绕四个方面展开：
- **3D 桌面**
- **车模车控**
- **行车地图**
- **泊车地图**

在 2021-2023 年初期阶段，这些功能实际上存在于不同的模块，用不同的渲染技术来实现。从 2024 年下半年到 2025 年，这些功能逐步向**一体化**发展。

![Screenshot 5](3d-hmi-operations/Screenshots/061_plus0.0s.png)

![Screenshot 6](3d-hmi-operations/Screenshots/062_plus0.0s.png)

未来趋势：**舱、行、泊**都会集成到一体，用一个引擎、一个渲染服务来提升整体的渲染效率。

![Screenshot 7](3d-hmi-operations/Screenshots/065_plus0.0s.png)

以领克为例，其座舱和行泊都用虚幻引擎实现，但现阶段还没有做到舱行泊一体化渲染——行泊这一块和座舱这一块仍然是分离的。不过根据交流，后续也需要让它们合在一起。

---

## 二、技术挑战与痛点分析

### 2.1 游戏 vs 座舱开发的本质差异

![Screenshot 8](3d-hmi-operations/Screenshots/077_plus0.0s.png)

> **根本挑战**：游戏是一个**应用级**的开发，而座舱是一个**系统级**的开发。

最初认为用虚幻引擎在汽车里做 3D HMI 应该是比较简单的——游戏已经做得非常炫酷了，汽车行业来做的话应该会少很多。但实际落地时发现挑战比想象的大得多，并没有那么乐观。

**系统级开发的复杂性**：
- 涉及外部环境的各个模块
- 车身的各种交互
- 需要做很多集成工作
- 不是在一个场景中去实现伪一体化的体验

### 2.2 座舱一体化的技术挑战

![Screenshot 9](3d-hmi-operations/Screenshots/116_plus0.0s.png)

**挑战一：层级管理**

汽车系统有非常严格的层级定义，不同的舱行泊在不同的运行时段要处于不同的层级：
- **壁纸层级**：可以提升到应用层级
- **设计面层级**：与壁纸层级不同
- **泊车层级**：当车打到 P 档时处于最高层级

这需要对引擎在渲染时进行相应的适配，可能会有内存泄漏等问题需要处理。

![Screenshot 10](3d-hmi-operations/Screenshots/141_plus0.0s.png)

**挑战二：架构设计**

需要有很好的架构设计来涵盖不同的域控：
- 要跟车身的很多域控单元打交道
- 车身的信号是海量并发的状态
- 需要做非常多的架构层级处理

**挑战三：多屏支持与复用渲染**

![Screenshot 11](3d-hmi-operations/Screenshots/165_plus0.0s.png)

![Screenshot 12](3d-hmi-operations/Screenshots/166_plus0.0s.png)

![Screenshot 13](3d-hmi-operations/Screenshots/167_plus0.0s.png)

座舱基本上都是多屏异显的方式：
- 需要在操作系统操作多屏
- 每个硬件屏可能还多层
- 这些都是游戏本身没有的需求

在 UE 5.6 里面，基本上可以实现比较好的复用——一个服务支持多屏渲染，而且支持多屏的输入。在 UE 5.7 里面，还可以支持多个关卡，每一屏可以支持不同的关卡。

**挑战四：SR-MAP 数据处理**

![Screenshot 14](3d-hmi-operations/Screenshots/194_plus0.0s.png)

作为 SR-MAP，需要处理：
- 兼容不同主机的数据协议
- 对数据进行防抖
- 平滑交通相应的处理

![Screenshot 15](3d-hmi-operations/Screenshots/204_plus0.0s.png)

**挑战五：可视化技术**

![Screenshot 16](3d-hmi-operations/Screenshots/205_plus0.0s.png)

![Screenshot 17](3d-hmi-operations/Screenshots/210_plus0.0s.png)

追求更好的可视化技术，比如：
- 音乐节奏驱动的动感桌面
- 基于类似 3D 高斯的技术，让一张图变成一个环境
- 在一张图上呈现空间变化
- 实现情感化的沉浸式体验

### 2.3 光庭的技术积累

![Screenshot 18](3d-hmi-operations/Screenshots/220_plus0.0s.png)

![Screenshot 19](3d-hmi-operations/Screenshots/221_plus0.0s.png)

光庭做了大概三年多的量产开发，同时也有相应的框架——**UE4Tmotiv**，这是针对汽车行业的虚幻引擎定制版，针对汽车行业的座舱特点做相应的裁剪，并提供各种中间件做可复用高效率的开发。

![Screenshot 20](3d-hmi-operations/Screenshots/232_plus0.0s.png)

> **阶段性成果**：三年下来，虚幻引擎已经证明自己可以在汽车行业的量产中很好的落地，那些痛点也都在逐步解决，基本上现在各家都有自己的量产方案来实现。

---

## 三、从交付走向运营：核心技术方案

### 3.1 运营化的核心诉求

![Screenshot 21](3d-hmi-operations/Screenshots/250_plus0.0s.png)

到了这一点还远远不够。除了 3D 桌面和现有的行泊地图之外的体验值，还能给用户带来怎样的体验？否则大家又会陷入一种同质化的竞争。

![Screenshot 22](3d-hmi-operations/Screenshots/251_plus0.0s.png)

在 2025 年上海车展，光庭提出了一套新的 3D 场景构建方案——构想一套**更灵活的摆弄空间**的方案。

### 3.2 参数化场景构建系统

![Screenshot 23](3d-hmi-operations/Screenshots/252_plus0.0s.png)

![Screenshot 24](3d-hmi-operations/Screenshots/253_plus0.0s.png)

这个系统展示的核心特点：
- 整个场景中在不断地从一个导变的房间
- 房间还有呈现出不同的风格化场景
- 这些变化其实都在一个关卡里面

![Screenshot 25](3d-hmi-operations/Screenshots/255_plus0.0s.png)

![Screenshot 26](3d-hmi-operations/Screenshots/258_plus0.0s.png)

基于一套组件，通过不同的**参数化、模块化和配置化**的效果来让它呈现出来。

![Screenshot 27](3d-hmi-operations/Screenshots/262_plus0.0s.png)

![Screenshot 28](3d-hmi-operations/Screenshots/263_plus0.0s.png)

通过这样一个方式，设想是能让整个的 3D 场景能够具备更多的可玩性。

### 3.3 从预制场景到千人千面

![Screenshot 29](3d-hmi-operations/Screenshots/267_plus0.0s.png)

![Screenshot 30](3d-hmi-operations/Screenshots/268_plus0.0s.png)

现在展示的不管是 Smart 还是领克，都做了很好的预制场景。但这种预制场景还没达到用户可以定制 DIY，或者能够很简单、很快速地 DIY 或 OTA 的方式来不断更换的效果。

![Screenshot 31](3d-hmi-operations/Screenshots/274_plus0.0s.png)

![Screenshot 32](3d-hmi-operations/Screenshots/277_plus0.0s.png)

所以想构建一套基于引擎的相应能力，能实现一套更动态的机制，让 3D 场景的更新可以更容易。

### 3.4 节日彩蛋的运营案例

![Screenshot 33](3d-hmi-operations/Screenshots/281_plus0.0s.png)

![Screenshot 34](3d-hmi-operations/Screenshots/282_plus0.0s.png)

以小鹏为例，在春节时推送了一个节日彩蛋——在车旁边有一个小鞭炮，点一下可以交互，很有意思。但是一年下来也只推送了这样一个节日彩蛋。

> **痛点分析**：做这种彩蛋对于车厂来说，流程应该是比较重的，成本可能也有一定高，并不是在每个节日都给用户推送这种彩蛋。

通过参数化场景技术，可以快速做这种节日彩蛋，而不需要每次都重新开发完整的场景。

### 3.5 元素级场景构建架构

![Screenshot 35](3d-hmi-operations/Screenshots/317_plus0.0s.png)

![Screenshot 36](3d-hmi-operations/Screenshots/318_plus0.0s.png)

![Screenshot 37](3d-hmi-operations/Screenshots/321_plus0.0s.png)

整个架构分为几层：

**底层：基础元素层**
- 各种基础的 3D 元素
- 材质、贴图、模型等

**中层：组件层**
- 将基础元素组合成可复用的组件
- 支持参数化配置

**上层：场景配置层**
- 通过配置文件定义场景
- 支持云端下发

![Screenshot 38](3d-hmi-operations/Screenshots/322_plus0.0s.png)

![Screenshot 39](3d-hmi-operations/Screenshots/323_plus0.0s.png)

**核心思路**：把场景的构建从"开发"变成"配置"。

### 3.6 参数化配置示例

![Screenshot 40](3d-hmi-operations/Screenshots/326_plus0.0s.png)

![Screenshot 41](3d-hmi-operations/Screenshots/327_plus0.0s.png)

![Screenshot 42](3d-hmi-operations/Screenshots/329_plus0.0s.png)

通过参数配置，可以实现：
- 房间的大小、形状变化
- 材质、颜色的切换
- 光照、氛围的调整
- 物件的增减和位置变化

![Screenshot 43](3d-hmi-operations/Screenshots/337_plus0.0s.png)

![Screenshot 44](3d-hmi-operations/Screenshots/340_plus0.0s.png)

这种方式让场景的变化不再需要重新打包发布，而是通过配置文件的下发就能实现。

### 3.7 云端配置下发机制

![Screenshot 45](3d-hmi-operations/Screenshots/380_plus0.0s.png)

![Screenshot 46](3d-hmi-operations/Screenshots/381_plus0.0s.png)

![Screenshot 47](3d-hmi-operations/Screenshots/382_plus0.0s.png)

配置下发的核心流程：

1. **云端配置管理**：在云端管理各种场景配置
2. **实时下发**：通过 OTA 或实时连接下发配置
3. **本地解析**：车端解析配置并应用到场景

![Screenshot 48](3d-hmi-operations/Screenshots/383_plus0.0s.png)

![Screenshot 49](3d-hmi-operations/Screenshots/384_plus0.0s.png)

![Screenshot 50](3d-hmi-operations/Screenshots/385_plus0.0s.png)

可以发不同的配置参数，下面在同样的内容，它就会变成不同的主题。同时可以 DIY，可以随意的变化，然后可以实时地下发。

![Screenshot 51](3d-hmi-operations/Screenshots/386_plus0.0s.png)

![Screenshot 52](3d-hmi-operations/Screenshots/387_plus0.0s.png)

将来用户在手机或者平板上面就可以玩一下自己的车机，可以做一定的定义，然后传给自己的车上，或者在车上去做这种交互的自定义控制。

### 3.8 运营化的核心价值

![Screenshot 53](3d-hmi-operations/Screenshots/390_plus0.0s.png)

![Screenshot 54](3d-hmi-operations/Screenshots/391_plus0.0s.png)

如果能做到这一点快速的更新，那么车机就逐步的可以走向运营：
- 不再是一个出厂预制的固定内容
- 哪怕做很多主题，也不再是固定的
- 可以做到**千人千面**，而不是"千人四面五面"

![Screenshot 55](3d-hmi-operations/Screenshots/399_plus0.0s.png)

![Screenshot 56](3d-hmi-operations/Screenshots/401_plus0.0s.png)

### 3.9 工作流的变革

![Screenshot 57](3d-hmi-operations/Screenshots/404_plus0.0s.png)

![Screenshot 58](3d-hmi-operations/Screenshots/406_plus0.0s.png)

![Screenshot 59](3d-hmi-operations/Screenshots/407_plus0.0s.png)

![Screenshot 60](3d-hmi-operations/Screenshots/410_plus0.0s.png)

**传统模式**：
- 设计、美术和程序要一起配合完成整个场景
- 沟通成本很高
- 需要不断的 PK

**元素级构建模式**：
- 美术和程序更多地去构建基础元素
- 场景的 3D 直接可以基于这些元素在场景中去搭最终效果
- 输出只需要一套配置
- 可以下发给程序，将新的场景变过去
- 不需要程序很重的参与，甚至可以不让程序参与就能更新场景

---

## 四、AI 与未来技术展望

### 4.1 对虚幻引擎的期望

![Screenshot 61](3d-hmi-operations/Screenshots/547_plus0.0s.png)

![Screenshot 62](3d-hmi-operations/Screenshots/549_plus0.0s.png)

**期望一：黑科技落地**

希望 Nanite、Lumen 能够在车机平台上流畅支持。虽然在高通的一些平台上好像已经可以落地了，但是车机里面不可能把所有的性能都吃掉。

如果这些东西用起来，虚幻引擎与其他引擎的差距就能够拉大。否则经常要向客户去证明为什么要用虚幻引擎。

**期望二：新平台支持**

在新的平台上（如高通 8397、MTK 8678、AMD 2000 等更高算力的平台），实际上是可以释放更多的潜力。

### 4.2 渲染管线定制化

![Screenshot 63](3d-hmi-operations/Screenshots/626_plus0.0s.png)

车机行业团队规模都是有限的，不能跟游戏行业去比规模。游戏行业大厂们可以维护渲染管线不断迭代，但车机行业要跟进的话会是很大的负担。

**期望**：
- 希望有一些开关可以简化或关闭某些流程
- 如果能够提供定制管线的能力，就不用去绑定某一个版本，用非回去改源码来做差异化

### 4.3 拥抱 AI 编程

![Screenshot 64](3d-hmi-operations/Screenshots/712_plus0.0s.png)

现阶段基本上大家编程都是 AI 直接猜出代码。如果工程一旦是比较稳定的话，AI 的猜中概率非常高，可以达到九成（如果一直在一个工程做过一段时间，有一些可参考的源码的话）。

现在的程序员很少会真正一行一行去敲代码了，更多是与 AI 的协同。

**期望**：官方能够更好地支持 AI 编程的集成，让开发效率进一步提升。

### 4.4 AI 生成 3D 模型

![Screenshot 65](3d-hmi-operations/Screenshots/520_plus0.0s.png)

当前要生成一个 3D 模型，在一个 1090 的设备上面，大约需要两分钟的时间就可以生成一个 3D 模型并能够实时地推送回来。

这套架构结合灵活的 3D 构建体系，将来座舱的空间实际上是可以做很多不同的探索。

---

## 五、实战总结与建议

### 5.1 方案对比

**方案 A：传统预制场景模式**
- 优势：场景质量可控，开发流程成熟
- 劣势：更新成本高，无法做到千人千面
- 适用场景：初期量产项目，资源有限的团队

**方案 B：参数化场景构建模式**
- 优势：更新灵活，支持运营化，可实现千人千面
- 劣势：前期架构设计复杂，需要建立完善的元素库
- 适用场景：追求差异化体验的高端车型，有运营诉求的项目

**方案 C：AI 辅助生成模式**
- 优势：生成速度快，创意空间大
- 劣势：质量不稳定，需要人工审核
- 适用场景：快速原型验证，创意探索阶段

### 5.2 避坑指南

1. **层级管理陷阱**
   - 不要忽视汽车系统的层级定义
   - 不同场景（舱、行、泊）在不同时段的层级不同
   - 需要提前设计好层级切换的机制

2. **内存泄漏风险**
   - 引擎在渲染时的 Swapchain 切换可能导致内存泄漏
   - 需要做好内存监控和清理机制

3. **多屏同步问题**
   - 多屏异显时的同步是个技术难点
   - 需要考虑每个屏的输入响应和渲染同步

4. **信号处理复杂度**
   - 车身信号是海量并发的
   - 需要做好防抖和平滑处理
   - 不要期望信号会按照文档描述的顺序到来

5. **版本升级负担**
   - 不要过度定制源码
   - 尽量使用配置化的方式实现差异化
   - 为后续版本升级留好接口

### 5.3 最佳实践

1. **架构设计原则**
   - 分层设计：基础元素层、组件层、场景配置层
   - 配置驱动：尽量用配置而不是代码来控制场景
   - 热更新支持：设计时就考虑 OTA 更新的需求

2. **性能优化建议**
   - 合理使用 LOD
   - 做好资源的按需加载
   - 监控 GPU 和 CPU 的占用，预留余量

3. **团队协作建议**
   - 建立统一的元素库规范
   - 设计好配置文件的格式和校验机制
   - 做好版本管理和回滚机制

---

## 六、总结

智能座舱 3D HMI 从量产交付走向持续运营，是行业发展的必然趋势。通过参数化场景构建、云端配置下发、AI 辅助生成等技术手段，可以实现：

1. **快速更新**：从重开发变为轻配置
2. **千人千面**：从固定主题变为个性化定制
3. **降本增效**：减少程序参与，提高美术效率
4. **持续运营**：支持节日彩蛋、个性化推荐等运营活动

虚幻引擎在智能座舱领域已经证明了自己的价值，随着引擎能力的不断增强和 AI 技术的深度融合，未来的座舱体验将会更加丰富和个性化。

![Screenshot 66](3d-hmi-operations/Screenshots/896_plus0.0s.png)

![Screenshot 67](3d-hmi-operations/Screenshots/897_plus0.0s.png)

---

> **作者说明**：本文基于 UFSH2025 大会上武汉光庭信息技术总监陈治的演讲内容整理，结合 AI 技术进行深度解析和扩展。如有技术交流需求，欢迎加入 UE5 技术交流群。



