# 虚幻引擎项目技术预研：从团队协作到系统架构的最佳实践

---
![UE5 技术交流群](project-prototyping/UE5_Contact.png)
## 加入 UE5 技术交流群
如果您对虚幻引擎5的图形渲染技术感兴趣，欢迎加入我们的 **UE5 技术交流群**！
扫描上方二维码添加个人微信 **wlxklyh**，备注"UE5技术交流"，我会拉您进群。
在技术交流群中，您可以：
- 与其他UE开发者交流渲染技术经验
- 获取最新的GDC技术分享和解读
- 讨论图形编程、性能优化、构建工具流、动画系统等话题
- 分享引擎架构、基建工具等项目经验和技术难题
---

> **视频来源**: [UFSH2025]虚幻引擎项目技术预研核心要点 | Jack Condon Epic Games 开发者关系资深工程师
>
> **视频链接**: https://www.bilibili.com/video/BV1cL1fB7Efb
>
> **时长**: 43分钟 | **演讲者**: Jack Condon (Epic Games 资深开发者关系工程师)
>
> **说明**: 本文由AI基于视频内容生成，旨在帮助开发者快速了解虚幻引擎项目技术预研的核心要点

---

## 导读

> **核心观点**：
>
> 1. **技术预研不是演示Demo**：技术预研的目标是在正式投入大规模生产前，通过构建垂直切片快速且低成本地解决关键技术问题
> 2. **文档的责任在于编写者**：如果团队没有阅读和理解你的文档，那是文档作者的责任，而不是团队的问题
> 3. **Blueprint与C++的选择是协作问题**：技术栈的选择不仅仅是性能考量，更重要的是如何通过合理的系统设计减少团队协作中的资源竞争

**前置知识要求**：
- 了解虚幻引擎的基本开发流程
- 熟悉Blueprint和C++在UE中的基本使用
- 对游戏开发的生产流程有基本认知

---

## 一、技术预研的三个核心交付物

![](project-prototyping/Screenshots/022_plus0.0s.png)

技术预研（Technical Pre-production）是游戏项目在扩大团队规模、大规模生产之前的关键阶段。Jack Condon 在演讲中强调，技术预研并非简单的概念验证或融资演示，而是一个系统性的工程实践过程。

### 1.1 可玩的垂直切片（Playable Level）

![](project-prototyping/Screenshots/034_plus0.0s.png)

**垂直切片不等于美术方向探索**，也不是为了获得融资而制作的Demo。这些早期Demo往往"靠一根线吊着"，充满了技术债务。

真正的垂直切片应该解决以下核心问题：

![](project-prototyping/Screenshots/038_plus0.0s.png)

- **资产管线（Asset Pipeline）**：如何高效地将美术资产从DCC工具导入引擎？需要什么样的自动化流程？
- **性能预算分配（Performance Budget）**：如何在目标设备上达到目标帧率？各系统（渲染、物理、AI等）的性能预算如何分配？
- **内容组织方式（Content Organization）**：从命名规范到资产编码标准，如何确保大团队协作时内容井然有序？
- **世界构建难度（World Building Complexity）**：实际构建游戏世界有多困难？哪些流程是瓶颈？需要什么工具来提高效率？

通过构建垂直切片，团队可以识别出生产过程中的痛点，并据此开发工具来提升大团队的工作效率。

### 1.2 "什么是优秀"文档（What Does Good Look Like Document）

![](project-prototyping/Screenshots/047_plus0.0s.png)

这是技术预研中**最重要但也最无聊**的部分。它有许多名字，但核心目标是统一的：将垂直切片开发过程中的所有经验教训转化为文档。

这份文档**不是美术圣经（Art Bible）**，也**不是游戏设计文档（GDD）**，而是：

![](project-prototyping/Screenshots/050_plus0.0s.png)

> **定义**：一套用于资产和代码生产的规则集合，是团队在开发过程中对抗熵增和混乱的规范准则。

文档应该包含：
- 资产制作标准（多边形数量、纹理分辨率、材质规范等）
- 命名约定（Naming Conventions）
- 代码风格规范
- 性能基准和优化准则
- 工作流程最佳实践

### 1.3 协作基础设施（Collaboration Infrastructure）

![](project-prototyping/Screenshots/054_plus0.0s.png)

确保每个团队成员都能访问项目和工具，包括：

- **源代码管理布局（Source Control Layout）**：Perforce/Git的仓库结构设计
- **共享DDC（Derived Data Cache）**：减少本地计算开销，提高编辑器启动速度
- **CI/CD流程**：持续集成和持续部署，确保构建稳定性
- **内容审查机制（Content Review）**：如何在资产提交前进行质量把关
- **编辑器工具（Editor Tools）**：自定义编辑器扩展，提升生产力

---

## 二、文档的可访问性比内容本身更重要

![](project-prototyping/Screenshots/057_plus0.0s.png)

Jack Condon 提出了一个颇具争议但深刻的观点：

> **如果你的团队未能阅读和理解你的文档，那是你的错，而不是他们的错。**

![](project-prototyping/Screenshots/058_plus0.0s.png)

### 2.1 为什么文档会失败？

很多技术主管会抱怨："我已经写了文档，但团队就是不看。" 但问题的根源往往在于：

- **文档太长太枯燥**：50页的PDF没人会从头读到尾
- **获取不便**：藏在某个共享盘深处的文件夹里
- **缺乏情境（Context）**：没有在工作流程中出现的文档会被遗忘
- **单一形式**：只有文字描述，没有视觉辅助或示例

**关键洞察**：人们学习的方式不同，文档的传递方式应该多样化。

### 2.2 文档传递的多种策略

#### 策略一：使用GitHub进行实时文档管理

![](project-prototyping/Screenshots/063_plus0.0s.png)

Jack 推荐了 [Linter Style Guide](https://github.com/Allar/ue5-style-guide) 作为优秀范例。

![](project-prototyping/Screenshots/064_plus0.0s.png)

这份指南的优势在于：

![](project-prototyping/Screenshots/065_plus0.0s.png)

1. **可Fork（可分叉）**：每个项目可以基于这份指南创建自己的版本
2. **版本控制**：所有修改历史清晰可见
3. **协作编辑**：团队成员可以通过Pull Request提出改进
4. **易于查找**：Markdown格式，支持全文搜索

![](project-prototyping/Screenshots/066_plus0.0s.png)

更重要的是，这份指南不仅列出规则，还**解释了为什么**这样做，并**提供了示例**。

![](project-prototyping/Screenshots/068_plus0.0s.png)

通过Fork机制，团队可以在保持通用规范的同时，添加项目特定的约定。

#### 策略二：将代码规范嵌入到编程解决方案中

![](project-prototyping/Screenshots/069_plus0.0s.png)

另一个绝妙的思路是将代码规范作为编程解决方案（Solution）的一部分。

![](project-prototyping/Screenshots/071_plus0.0s.png)

> **优势**：程序员无法辩称"没有访问文档的权限"——因为文档就在他们正在编辑的解决方案里。

这个方法来自 Valentin Galea 在 2019 年 Unreal Fest Europe 的演讲：**"Growing a Healthy UE4 Ecosystem"**。

![](project-prototyping/Screenshots/072_plus0.0s.png)

![](project-prototyping/Screenshots/073_plus0.0s.png)

该仓库的亮点：

![](project-prototyping/Screenshots/075_plus0.0s.png)

- 代码规范以Markdown形式存在于源码仓库
- 配合编译脚本，可以在CI/CD中强制检查规范
- 规范本身也需要"通过编译"，确保示例代码可运行

![](project-prototyping/Screenshots/076_plus0.0s.png)

![](project-prototyping/Screenshots/077_plus0.0s.png)

#### 策略三：自动化验证和执行

![](project-prototyping/Screenshots/078_plus0.0s.png)

除了文档，还可以通过自动化工具主动阻止不符合规范的内容进入源代码库。例如：

- **资产验证（Asset Validation）**：在提交前检查资产命名、文件大小、引用完整性
- **Pre-commit Hooks**：Git钩子在提交前运行代码检查工具（Linter）
- **编辑器内提示**：通过插件在编辑器中实时提示不符合规范的操作

![](project-prototyping/Screenshots/081_plus0.0s.png)

#### 策略四：无处不在的创意传播

Jack 提到了一些有趣的方法：

- **桌面壁纸**：将关键规范做成壁纸
- **浴室隔间门**：在办公室洗手间贴海报（人们在那里会认真阅读）
- **鼠标垫**：常用快捷键印在鼠标垫上
- **海报**：关键流程图贴在工位附近

![](project-prototyping/Screenshots/082_plus0.0s.png)

> **核心理念**：所有潜在的"画布"都可以用来传达你的想法。记住，这是你的责任。

---

## 三、构建技术栈：Blueprint还是C++？

![](project-prototyping/Screenshots/083_plus0.0s.png)

技术预研阶段最关键的决策之一是确定技术栈。

![](project-prototyping/Screenshots/084_plus0.0s.png)

常见的选择包括：

![](project-prototyping/Screenshots/085_plus0.0s.png)

- **Gameplay Ability System (GAS)** vs 自研能力系统？
- **State Tree** vs **Behavior Tree**？

![](project-prototyping/Screenshots/087_plus0.0s.png)

- **Replication Graph** vs **Iris**？

![](project-prototyping/Screenshots/088_plus0.0s.png)

- **Experimental Verse** 还是 **Production Ready技术**？

![](project-prototyping/Screenshots/089_plus0.0s.png)

### 3.1 构建稳固技术栈的三个原则

Jack 提出了三个指导原则：

**原则一：保持意识（Be Aware）**

- 持续跟踪引擎和社区生态系统的发展
- 关注 [Unreal Engine Product Board](https://portal.productboard.com/epicgames/1-unreal-engine-public-roadmap)
- 产品团队花费大量精力维护该路线图，这是宝贵的资源

**原则二：验证与分享（Validate and Share）**

![](project-prototyping/Screenshots/107_plus0.0s.png)

![](project-prototyping/Screenshots/108_plus0.0s.png)

- 参加 Unreal Fest 等活动与其他团队交流
- 询问已经使用过某项技术的工作室获取实战经验
- 发展本地Meetup，建立知识分享社区

![](project-prototyping/Screenshots/111_plus0.0s.png)

- 寻找尽可能多的项目事后总结（Post-mortem）

![](project-prototyping/Screenshots/112_plus0.0s.png)

![](project-prototyping/Screenshots/113_plus0.0s.png)

- **放下自我**：将你的技术栈方案分享出去（通常不涉及机密）

![](project-prototyping/Screenshots/116_plus0.0s.png)

- 接受外部意见，准备好接受自己可能是错的

**原则三：测试（Test）**

![](project-prototyping/Screenshots/117_plus0.0s.png)

![](project-prototyping/Screenshots/118_plus0.0s.png)

- 使用 Epic 官方示例项目（Lyra、City Sample等）
- 如果示例项目恰好包含你想要的功能组合，那就最好了

![](project-prototyping/Screenshots/120_plus0.0s.png)

- 如果没有完全匹配的示例，也可能有接近的项目能加速R&D

![](project-prototyping/Screenshots/123_plus0.0s.png)

- 制作技术原型验证你的假设，脏代码没关系，只要功能能组合在一起且不会崩溃就行

![](project-prototyping/Screenshots/125_plus0.0s.png)

- 如果有EPS（Epic Partner Support）访问权限，可以直接向Epic提问

![](project-prototyping/Screenshots/126_plus0.0s.png)

- Epic不介意回答高层次的技术问题，这能为开发节省大量痛苦

![](project-prototyping/Screenshots/128_plus0.0s.png)

- 如果没有EPS访问权限，可以在Unreal Fest的开发者休息室与Epic工程师交流

### 3.2 即使做好准备，也无法避免所有摩擦

![](project-prototyping/Screenshots/129_plus0.0s.png)

Jack 坦言：

> **最佳研究和测试过的技术栈也无法让你免于开发摩擦。如果能做到那将毫无乐趣可言。**

![](project-prototyping/Screenshots/131_plus0.0s.png)

但如果做好功课，至少能够：

![](project-prototyping/Screenshots/132_plus0.0s.png)

- **预知开发痛点的大致位置**
- **围绕这些痛点规划生产流程**

---

## 四、Blueprint与C++：从技术选择到协作哲学

![](project-prototyping/Screenshots/133_plus0.0s.png)

接下来，Jack深入探讨了一个永恒的话题：**Blueprint vs C++**。

![](project-prototyping/Screenshots/134_plus0.0s.png)

### 4.1 跳出技术性能的思维定式

![](project-prototyping/Screenshots/135_plus0.0s.png)

这个话题在社区中已经被讨论到令人疲倦的地步。

![](project-prototyping/Screenshots/136_plus0.0s.png)

Jack认为，讨论通常陷入系统设计的技术细节。

![](project-prototyping/Screenshots/137_plus0.0s.png)

![](project-prototyping/Screenshots/138_plus0.0s.png)

但问题往往从错误的角度出发。

![](project-prototyping/Screenshots/139_plus0.0s.png)

典型的讨论流程：

![](project-prototyping/Screenshots/140_plus0.0s.png)

1. 比较优点和缺点
2. 最终达成共识：它们各有所长

![](project-prototyping/Screenshots/141_plus0.0s.png)

共识通常是：

- **Blueprint擅长流程控制、数据处理和资产引用**
- **C++擅长合并（Merging）和差异对比（Diffing）**

![](project-prototyping/Screenshots/143_plus0.0s.png)

但Jack提出了一个新的视角：**通过协作的视角来看待这个问题**。

### 4.2 技术差异与职能边界的映射

![](project-prototyping/Screenshots/144_plus0.0s.png)

> **关键洞察**：技术上的差异通常代表着职能上的分界。

![](project-prototyping/Screenshots/145_plus0.0s.png)

![](project-prototyping/Screenshots/146_plus0.0s.png)

让我们更仔细地分析：

![](project-prototyping/Screenshots/148_plus0.0s.png)

通常情况下，我们期望：
- **程序员**精通C++和Blueprint

![](project-prototyping/Screenshots/149_plus0.0s.png)

- **美术和设计师**了解一些Blueprint

![](project-prototyping/Screenshots/150_plus0.0s.png)

那么为什么项目需要工程师？

![](project-prototyping/Screenshots/151_plus0.0s.png)

一个原因是：我们需要具备基础软件技能的人，能够**编写和维护可扩展的代码**。

但美术和设计师的核心工作就是他们的职位名称所示。

![](project-prototyping/Screenshots/153_plus0.0s.png)

尽管如此，我们都知道能够用Blueprint原型化自己想法的设计师有多强大。Blueprint在这方面的表现非常出色。

![](project-prototyping/Screenshots/154_plus0.0s.png)

![](project-prototyping/Screenshots/155_plus0.0s.png)

他们的工作需要扩展吗？不需要。但对开发过程仍然至关重要。

![](project-prototyping/Screenshots/156_plus0.0s.png)

此外，让程序员完全实现每个功能的最后细节是资源浪费。

这就是为什么数据驱动设计（Data-driven Design）在游戏开发中如此流行——它让设计师拥有控制权。

![](project-prototyping/Screenshots/161_plus0.0s.png)

但这带来了一个摩擦点：

如果美术在游戏玩法中实现自己的VFX，或者设计师在扩展能力系统，总会有这样的担忧：他们会不会陷入麻烦？

![](project-prototyping/Screenshots/163_plus0.0s.png)

每个人最担心的最坏情况是：脆弱的代码会破坏构建（Break the Build）。

正因如此，程序员通常喜欢严格控制。这也是为什么他们讨厌设计师喜欢的那些巨大的CSV表格。

![](project-prototyping/Screenshots/164_plus0.0s.png)

（现场观众的微笑和点头表示认同）

### 4.3 C++与Blueprint之间的"控制边界"

![](project-prototyping/Screenshots/165_plus0.0s.png)

但关键在于：

> **C++和Blueprint之间的差距恰好可以成为实现控制的完美空间。**

![](project-prototyping/Screenshots/166_plus0.0s.png)

因此，除了思考C++和Blueprint各自擅长什么，我们还需要思考**如何以及暴露什么给我们的系统**。

![](project-prototyping/Screenshots/167_plus0.0s.png)

> **目标**：为团队中的每个人创建灵活的开发环境，同时确保系统不会变得脆弱。

![](project-prototyping/Screenshots/168_plus0.0s.png)

控制哪些内容暴露给Blueprint是实现这一点的绝佳方式。

![](project-prototyping/Screenshots/169_plus0.0s.png)

**实用建议**：认真思考你的宏（Macros）——它们是控制流程的最佳工具。

常用的C++暴露宏：
- `UFUNCTION(BlueprintCallable)` - 允许Blueprint调用
- `UFUNCTION(BlueprintImplementableEvent)` - 在Blueprint中实现
- `UPROPERTY(BlueprintReadOnly)` - Blueprint只读
- `UPROPERTY(EditAnywhere, Category = "Combat")` - 编辑器中可编辑

---

## 五、始终用C++创建基类

![](project-prototyping/Screenshots/170_plus0.0s.png)

### 5.1 为什么基类应该用C++？

![](project-prototyping/Screenshots/171_plus0.0s.png)

Jack承认，很多人已经这样做了，但仍有团队不遵循这个惯例。

![](project-prototyping/Screenshots/173_plus0.0s.png)

他强调的不是每个类都要用C++，而是**游戏核心类必须用C++作为基类**。

原因包括：

1. **更好的版本控制**：C++代码是纯文本，易于Diff和Merge
2. **编译时错误检查**：在编译阶段就能发现许多问题
3. **性能优化空间**：关键路径的性能优化通常需要C++
4. **重构便利性**：重命名、移动类层级结构更安全
5. **稳定性**：核心逻辑不会因Blueprint的二进制格式问题而损坏

![](project-prototyping/Screenshots/174_plus0.0s.png)

但Jack理解，如果你想做一个纯Blueprint游戏（也许没有专职程序员，或者团队主要是设计师），这也是可以的。

### 5.2 最低限度的妥协方案

![](project-prototyping/Screenshots/175_plus0.0s.png)

即使不想完全用C++实现基类，Jack 也强烈建议至少用C++创建**头文件（Header）**：

![](project-prototyping/Screenshots/176_plus0.0s.png)

- 核心属性（Properties）
- 委托（Delegates）
- 合适的Getter和Setter

![](project-prototyping/Screenshots/177_plus0.0s.png)

如果这还太多，至少考虑**枚举（Enums）和结构体（Structs）**。

![](project-prototyping/Screenshots/178_plus0.0s.png)

这仍然能在重构和稳定性方面带来巨大优势。

### 5.3 Blueprint Header工具：从Blueprint生成C++头文件

![](project-prototyping/Screenshots/179_plus0.0s.png)

![](project-prototyping/Screenshots/180_plus0.0s.png)

好消息是，这个过程已经变得非常简单和易于访问，即使对于不擅长C++的团队也是如此。

![](project-prototyping/Screenshots/181_plus0.0s.png)

这要归功于**Blueprint Header Tool**，它能够基于Blueprint类生成C++头文件。

![](project-prototyping/Screenshots/182_plus0.0s.png)

让我们看一个例子。这是一个Blueprint类。

![](project-prototyping/Screenshots/183_plus0.0s.png)

这是生成的C++头文件。

![](project-prototyping/Screenshots/184_plus0.0s.png)

工具会创建所有变量和组件，甚至复制Blueprint中设置的元数据属性（Meta Attributes）。

![](project-prototyping/Screenshots/185_plus0.0s.png)

在更复杂的场景中（例如Replication），工具还会告诉你需要做哪些修改才能让功能以相同方式工作。

![](project-prototyping/Screenshots/186_plus0.0s.png)

有了这些功能，Jack相信团队可以适应这种工作方式。Bush Ranger（堡垒之夜角色）也这么认为！

---

## 六、系统设计中的资产竞争问题

![](project-prototyping/Screenshots/187_plus0.0s.png)

接下来，Jack通过一个具体案例深入分析如何通过系统设计减少资产竞争。

### 6.1 问题定义：一个简单的武器开火能力

![](project-prototyping/Screenshots/189_plus0.0s.png)

让我们看一个"简单"的能力：**武器开火**。

但在游戏开发中，没有什么是简单的：

- **设计团队**需要处理伤害和效果
- **音效团队**需要处理各种声音：开火音效、近距未命中、命中、空响等等
- **VFX团队**需要处理武器开火特效、命中特效、弹孔贴花（Decals）

![](project-prototyping/Screenshots/191_plus0.0s.png)

- **动画团队**需要处理命中反应动画

![](project-prototyping/Screenshots/194_plus0.0s.png)

这一个功能涉及团队的大部分成员。而且这些成员中的大多数都需要在Blueprint中工作。

![](project-prototyping/Screenshots/196_plus0.0s.png)

然而，Blueprint在Diff方面困难得多，合并就更不用说了。所以我们需要在系统设计中考虑这一点。

### 6.2 案例分析：Gameplay Ability System (GAS) 如何解决竞争

![](project-prototyping/Screenshots/197_plus0.0s.png)

让我们看看Gameplay Ability System是如何处理这个问题的。

![](project-prototyping/Screenshots/198_plus0.0s.png)

我们将以Lyra示例项目为例。

![](project-prototyping/Screenshots/199_plus0.0s.png)

这只是系统的一部分。我们不会涉及AnimNotify和其他一些内容。

![](project-prototyping/Screenshots/201_plus0.0s.png)

![](project-prototyping/Screenshots/202_plus0.0s.png)

但我认为这足以说明我的整体观点，同时也为我们之前讨论的一些概念提供了具体示例。

#### 第一层：C++基类

![](project-prototyping/Screenshots/203_plus0.0s.png)

系统从C++基类开始。这是定义能力核心特性的完美层级。

![](project-prototyping/Screenshots/205_plus0.0s.png)

它处理一些复杂的Replication逻辑，我们并不希望设计团队关心甚至理解这些。将这些逻辑封装在这里是很好的方式。

#### 第二层：Blueprint子类（流程控制）

![](project-prototyping/Screenshots/207_plus0.0s.png)

接下来，这被拉入一个Blueprint子类。

![](project-prototyping/Screenshots/208_plus0.0s.png)

在这里，我们处理能力的整体流程，比如触发动画之类的东西。技术设计师和程序员很可能会在这个层级工作。

![](project-prototyping/Screenshots/211_plus0.0s.png)

那些复杂的Replication代码从Blueprint中被触发。

![](project-prototyping/Screenshots/213_plus0.0s.png)

它会启动子弹的所有复杂客户端-服务器网络逻辑，而这些都在C++中。设计师不需要担心这些，他们只需调用函数。

![](project-prototyping/Screenshots/214_plus0.0s.png)

这也是添加默认数据的好地方。

#### 第三层：数据专用Blueprint（Data-Only Blueprint）

![](project-prototyping/Screenshots/215_plus0.0s.png)

从这里，我们可以继续为每种射线追踪能力创建子类。

![](project-prototyping/Screenshots/216_plus0.0s.png)

在这个例子中，我们看步枪。

![](project-prototyping/Screenshots/217_plus0.0s.png)

这是一个**数据专用Blueprint**，意味着完全没有编程。这非常适合设计和美术团队成员。

![](project-prototyping/Screenshots/218_plus0.0s.png)

数据专用Blueprint的好处是它们在编辑器中的Diff效果非常好。

![](project-prototyping/Screenshots/219_plus0.0s.png)

这意味着有更好的工具来协作处理它们。

![](project-prototyping/Screenshots/220_plus0.0s.png)

![](project-prototyping/Screenshots/221_plus0.0s.png)

使用它们的另一个好技巧是选择模式（Selection Modes），允许不同的数据视图。例如，"仅修改过的"视图会准确显示是什么让我们的步枪成为步枪。

#### 第四层：Gameplay Effect（伤害处理）

![](project-prototyping/Screenshots/222_plus0.0s.png)

接下来是用于在GAS中处理伤害的Blueprint：这被称为**Gameplay Effect**。

![](project-prototyping/Screenshots/224_plus0.0s.png)

它们用于应用各种东西，但在这个例子中，它会对任何被命中的目标施加伤害。这个层级完全属于设计团队。

顺便说一句，设计师可以导入那些巨大的CSV图表到曲线（Curves）中来改变不同等级的伤害。在这个例子中，它只是造成12点静态伤害。

#### 第五层：Gameplay Cue（视听反馈）

![](project-prototyping/Screenshots/227_plus0.0s.png)

GAS还使用一种叫做**Gameplay Cues**的东西。它们可以基于能力标签（Ability Tags）间接触发。

基本上，它们响应游戏玩法动作，但它们是审美性的——比如如果我获得了火焰属性，在我身上创建火焰粒子。

在这个例子中，我们有一个Gameplay Cue在武器开火时触发。

![](project-prototyping/Screenshots/230_plus0.0s.png)

因为它们只是审美性的，它们专门用于处理VFX、音效和一般反馈。

![](project-prototyping/Screenshots/231_plus0.0s.png)

我们的音效和美术团队可以直接在这里工作。

![](project-prototyping/Screenshots/232_plus0.0s.png)

在这个例子中，我们的Cue生成了两个Actor，不同的工作：一个处理武器开火、枪口闪光和弹壳，另一个处理弹孔贴花和武器撞击。

但我们可以设置Cues来处理其他特定的事情，比如角色受到伤害。你可以想象美术和音效美术可以为他们想要覆盖的各种事情设置Cues，所有这些都与能力和效果分离。

### 6.3 系统设计的核心思想

![](project-prototyping/Screenshots/237_plus0.0s.png)

这个系统不仅仅是关于封装，更是**帮助所有这些部门减少资源竞争**。

**设计模式总结**：

> **分层架构（Layered Architecture）**：
>
> - **Layer 1 (C++)**: 核心逻辑和网络同步
> - **Layer 2 (Blueprint)**: 流程控制和协调
> - **Layer 3 (Data-Only Blueprint)**: 具体配置
> - **Layer 4 (Gameplay Effect)**: 设计参数
> - **Layer 5 (Gameplay Cue)**: 视听反馈

每一层都有明确的职责边界，不同职能的团队成员在不同层级工作，**最大限度减少文件冲突**。

---

## 七、UI开发中的前后端协作：MVVM模式

![](project-prototyping/Screenshots/238_plus0.0s.png)

接下来，Jack转向另一个常见的协作难题：**UI前端和后端的协作**。

### 7.1 问题场景

![](project-prototyping/Screenshots/239_plus0.0s.png)

设计团队给我们传递了一些UI线框图（Wireframes）。

![](project-prototyping/Screenshots/240_plus0.0s.png)

现在我们知道需要哪些按钮，大概知道它们会放在哪里以及它们如何相互关联。

![](project-prototyping/Screenshots/241_plus0.0s.png)

现在我们需要将其转化为既美观又功能完善的东西。

![](project-prototyping/Screenshots/242_plus0.0s.png)

我们的UI团队会立即投入工作，运用他们所有的美术技能，制作出很棒的东西。

![](project-prototyping/Screenshots/243_plus0.0s.png)

与此同时，我们的UI总是与游戏状态绑定，大量变量将来自我们的游戏玩法编程团队。

![](project-prototyping/Screenshots/244_plus0.0s.png)

所以我们要做的就是结合这些元素，应该就能得到一个功能完善的用户界面。

### 7.2 并行开发的困境

![](project-prototyping/Screenshots/244_plus0.0s.png)

但这常常会造成问题，因为两个团队彼此并行工作。

当涉及到集成时，最坏的情况是我们的UI从代码库的各个地方拉取数据。

随着这些游戏系统的变化，我们整个UI系统就会崩溃。

此外，我们的UI团队在游戏玩法系统完成之前看不到他们正在处理的数据，这并不理想。

### 7.3 解决方案：MVVM（Model-View-ViewModel）

![](project-prototyping/Screenshots/249_plus0.0s.png)

然而，通过一些预见和规划，两个团队可以就**哪些信息需要在两个独立系统之间流动以及如何流动达成一致**。

然后他们只需要担心如何连接到这个协议，而不是彼此的工作。

![](project-prototyping/Screenshots/251_plus0.0s.png)

我们称之为**契约（Contract）**。这种与UI协作的风格已经存在很长时间，通常称为**MVVM（Model-View-ViewModel）**。

它实际上是通过解耦前端和后端来允许并行开发。

![](project-prototyping/Screenshots/253_plus0.0s.png)

虽然这是一种哲学，但虚幻引擎已经围绕这一点构建了工具，使其成为一个非常棒的流程。

我们称之为**UMG ViewModel Plugin**。

### 7.4 UMG ViewModel的工作流程

![](project-prototyping/Screenshots/255_plus0.0s.png)

基本流程如下：

1. **用户交互 → ViewModel**：当用户通过UMG与UI交互时，它不是直接调用它想要修改的对象的事件，而是与ViewModel通信。

![](project-prototyping/Screenshots/256_plus0.0s.png)

2. **ViewModel → 游戏对象**：例如，也许我们选择改变角色的攻击姿态。ViewModel会向对象发送更新，告诉角色："嘿，我们请求了一个新的攻击姿态。"

![](project-prototyping/Screenshots/258_plus0.0s.png)

3. **游戏对象 → ViewModel**：如果对象发生变化（比如我们的攻击姿态改变了），我们把这个变化发送回ViewModel。

![](project-prototyping/Screenshots/259_plus0.0s.png)

4. **ViewModel → UMG → 用户**：然后从那里通过绑定发送到UMG，最终反馈给用户。

### 7.5 ViewModel的优势

![](project-prototyping/Screenshots/261_plus0.0s.png)

在这种情况下，我们的ViewModel充当游戏玩法编程团队和UI团队的契约。

- **游戏玩法程序员**只需要关心如何连接到ViewModel，将其纳入他们的开发范围
- **UI团队**只需要关心从ViewModel的绑定，也不用担心游戏玩法编程团队

![](project-prototyping/Screenshots/264_plus0.0s.png)

这样我们就最小化了重构，并允许并行开发。

而且有了新的**Preview Widget工具**，UI团队甚至可以在游戏玩法系统准备好之前查看UI并修改值。

---

## 八、高层级代码组织：插件与模块化

![](project-prototyping/Screenshots/267_plus0.0s.png)

让我们转向更高层级的代码库组织话题。

### 8.1 为什么需要模块化？

Jack强调，随着项目规模扩大，单一的Game Module会变得难以管理：

- **编译时间**：修改任何代码都需要重新编译整个模块
- **职责不清**：所有代码混在一起，难以划分ownership
- **复用性差**：无法在其他项目中重用某些系统
- **依赖混乱**：所有代码都能相互访问，容易形成循环依赖

### 8.2 插件（Plugins）的分类

![](project-prototyping/Screenshots/340_plus0.0s.png)

虚幻引擎中的插件可以分为几类：

**类型一：引擎插件（Engine Plugins）**
- Epic官方维护
- 通用功能（如Niagara、Chaos等）
- 跨项目复用

**类型二：项目插件（Project Plugins）**
- 项目特定但可移植
- 例如：自研的库存系统、对话系统

![](project-prototyping/Screenshots/343_plus0.0s.png)

**类型三：游戏功能插件（Game Feature Plugins）**

![](project-prototyping/Screenshots/345_plus0.0s.png)

与传统插件不同，Game Features往往与Game Module耦合，用于扩展或创建新功能。

![](project-prototyping/Screenshots/346_plus0.0s.png)

它们失去了跨项目的可移植性，但获得了强大的注入能力。

![](project-prototyping/Screenshots/347_plus0.0s.png)

例如，可以在Game Feature开启后添加额外的Primary Asset扫描目录。

![](project-prototyping/Screenshots/348_plus0.0s.png)

然后可以从Asset Registry获取所有这些Primary Assets的列表。

想象一下向商店添加一堆武器，然后只需从模块化功能传播所有这些新武器。

### 8.3 插件依赖可视化工具

![](project-prototyping/Screenshots/350_plus0.0s.png)

![](project-prototyping/Screenshots/351_plus0.0s.png)

这些工作流程往往会产生相当复杂的插件依赖关系。因此Epic构建了一个非常好的工具来查看依赖链，称为**Plugin Reference Viewer**（插件引用查看器）。

### 8.4 接口驱动开发（Interface-Driven Development）

![](project-prototyping/Screenshots/352_plus0.0s.png)

![](project-prototyping/Screenshots/353_plus0.0s.png)

在结束关于高层级代码的讨论之前，Jack想介绍一个许多人可能已经在思考的想法：

当我们设计所有这些系统时，可以通过**优先规划公共接口（Public Headers）**来获得巨大的生产力提升。

![](project-prototyping/Screenshots/355_plus0.0s.png)

也就是说，在开始开发之前，先布局这些系统打算如何相互通信。

![](project-prototyping/Screenshots/356_plus0.0s.png)

记得之前的MVVM吗？在概念上，我们可以通过定义这些插件将如何通信来做同样的事情——为每个系统制定团队可以订阅的契约。

![](project-prototyping/Screenshots/357_plus0.0s.png)

这非常接近**接口驱动开发**。这里的主要目标是真正强制解耦和模块化。

它非常适合诸如Mock数据、测试或为整个项目启用并行开发等场景。

![](project-prototyping/Screenshots/360_plus0.0s.png)

有很多软件开发方法。你可能能说出10种我从未听说过的技术。我只是用这个例子，因为这是你在技术预研中需要考虑的事情类型。

---

## 九、技术预研阶段就要考虑DLC策略

![](project-prototyping/Screenshots/361_plus0.0s.png)

### 9.1 为什么这么早就谈DLC？

为什么我们在技术预研中讨论DLC？我们甚至还没有卖出游戏！

答案是：**事后改装DLC是可怕的**。

![](project-prototyping/Screenshots/361_plus0.0s.png)

如果有哪怕最小的可能性你可能需要DLC策略，你至少需要松散地概念化你的数据结构，并使内容升级变得容易。

这并不意味着妥协，只是意味着规划。

### 9.2 基于Game Feature的DLC方案

![](project-prototyping/Screenshots/366_plus0.0s.png)

Jack展示了一个使用前面学到的知识的方法。

![](project-prototyping/Screenshots/367_plus0.0s.png)

**限制说明**：
- DLC可以意味很多东西，这里只从**内容管理角度**来处理
- 这个方法只适用于UAssets，不能添加额外的代码模块（但通常这就够了）

![](project-prototyping/Screenshots/368_plus0.0s.png)

真正需要分块并允许单独下载的是那些重资产，从内容管理的角度来看，这个策略非常适合。

![](project-prototyping/Screenshots/371_plus0.0s.png)

### 9.3 具体实施步骤

**步骤1：创建Game Feature Plugin**

![](project-prototyping/Screenshots/372_plus0.0s.png)

为了让事情更简单，勾选"Enable by Default"。这意味着如果DLC分块存在，插件会自动挂载。

![](project-prototyping/Screenshots/374_plus0.0s.png)

记住，我们不能使用这种方法交付代码。

![](project-prototyping/Screenshots/375_plus0.0s.png)

![](project-prototyping/Screenshots/376_plus0.0s.png)

**步骤2：设置版本控制分支**

![](project-prototyping/Screenshots/377_plus0.0s.png)

![](project-prototyping/Screenshots/378_plus0.0s.png)

![](project-prototyping/Screenshots/379_plus0.0s.png)

设置一个简化的工作流程：
- 一个分支保存基础版本
- 一个分支保存DLC内容

![](project-prototyping/Screenshots/380_plus0.0s.png)

![](project-prototyping/Screenshots/381_plus0.0s.png)

**步骤3：打包基础游戏**

![](project-prototyping/Screenshots/382_plus0.0s.png)

我们需要先打包基础游戏，以便为DLC提供发布版本号。

```bash
RunUAT BuildCookRun -project=... -platform=... -clientconfig=Development -cook -stage -pak -archive -archivedirectory=... -createrelease=1.0
```

![](project-prototyping/Screenshots/383_plus0.0s.png)

注意我们指定了一个发布版本（Release Version），这在后面会用到。

![](project-prototyping/Screenshots/384_plus0.0s.png)

![](project-prototyping/Screenshots/385_plus0.0s.png)

打包完成后，会输出一堆来自核心Lyra游戏的分块（Chunks）。

Lyra为不同的体验使用不同的分块，这就是为什么有这么多。

![](project-prototyping/Screenshots/388_plus0.0s.png)

**步骤4：打包DLC**

![](project-prototyping/Screenshots/390_plus0.0s.png)

切换到DLC分支，再次运行BuildCookRun，但这次指定要构建的DLC（插件名称）。

![](project-prototyping/Screenshots/391_plus0.0s.png)

![](project-prototyping/Screenshots/392_plus0.0s.png)

还需要指定与基础版本对应的发布版本号。

![](project-prototyping/Screenshots/393_plus0.0s.png)

**步骤5：查看结果**

![](project-prototyping/Screenshots/394_plus0.0s.png)

现在在Archive目录中我们看到一个Plugins文件夹，里面有以DLC名称命名的额外分块。

![](project-prototyping/Screenshots/395_plus0.0s.png)

将它们与Lyra分块放在同一文件夹中，我们就有了为你特别制作的非常性感的DLC地图！

---

## 十、高效工作环境：避免跨插件引用错误

![](project-prototyping/Screenshots/396_plus0.0s.png)

### 10.1 模块化带来的新问题

![](project-prototyping/Screenshots/397_plus0.0s.png)

![](project-prototyping/Screenshots/398_plus0.0s.png)

你有了非常模块化的代码和功能，干得好。

![](project-prototyping/Screenshots/400_plus0.0s.png)

![](project-prototyping/Screenshots/401_plus0.0s.png)

但随着包含内容的插件如此之多，出现了一个新问题，一个坏问题：**处理跨插件的引用**。

![](project-prototyping/Screenshots/402_plus0.0s.png)

事实是，无论你的文档多么好，人们都会犯错。

![](project-prototyping/Screenshots/403_plus0.0s.png)

出错的地方太多了。

![](project-prototyping/Screenshots/404_plus0.0s.png)

与会阻止你编译的代码依赖项不同，发现跨插件的错误引用要困难得多。

或者真的很难吗?

### 10.2 编辑器内的依赖检查

![](project-prototyping/Screenshots/406_plus0.0s.png)

让我们看一个例子。这里我要尝试向游戏体验添加一个数据资产。

![](project-prototyping/Screenshots/407_plus0.0s.png)

它位于我们不依赖的插件的内容插件中。

![](project-prototyping/Screenshots/409_plus0.0s.png)

为什么这是个问题？如果那个插件没有加载，而我试图访问它的数据，这会造成非常糟糕的问题。

![](project-prototyping/Screenshots/410_plus0.0s.png)

但虚幻引擎阻止了我。发生了什么？

**答案：Unreal Editor的依赖验证系统**

虚幻引擎编辑器内置了依赖验证，可以：
- 检测跨插件的非法引用
- 在编辑器中直接阻止不当操作
- 在提交前通过Data Validation插件进行批量检查

**最佳实践建议**：

> **避坑指南（Pitfalls to Avoid）**：
>
> 1. **不要禁用编辑器的依赖检查**：虽然可以强制关闭警告，但这会在未来埋下隐患
> 2. **在CI/CD中集成资产验证**：使用Commandlet在构建管线中自动检查
> 3. **定期运行依赖审计**：使用Reference Viewer工具定期检查意外的引用链

---

## 实战总结与建议

### 关键要点回顾

**1. 技术预研三大交付物**
- 可玩的垂直切片：快速低成本解决技术问题
- "什么是优秀"文档：团队协作的规则集合
- 协作基础设施：源码管理、CI/CD、工具链

**2. 文档传播策略**
- 多样化形式：GitHub、嵌入式文档、自动化验证
- 无处不在：壁纸、海报、鼠标垫
- 核心理念：文档的可访问性比内容本身更重要

**3. Blueprint与C++的协作哲学**
- 技术差异映射职能边界
- 控制边界：C++封装核心逻辑，Blueprint提供灵活性
- 始终用C++创建基类

**4. 系统设计减少资产竞争**
- 分层架构：不同职能在不同层级工作
- GAS案例：C++基类 → Blueprint流程 → 数据专用BP → Gameplay Effect/Cue
- UI开发：MVVM模式实现前后端解耦

**5. 模块化与DLC策略**
- 插件分类：引擎插件、项目插件、Game Feature
- 技术预研阶段就考虑DLC
- 接口驱动开发：优先规划公共接口

### 方案对比

> **Blueprint vs C++：职能导向的选择**
>
> **Blueprint**
> - 🟢 优势：可视化流程、快速原型、设计师友好、资产引用便利
> - 🔴 劣势：难以Diff和Merge、运行时性能略低、重构风险高
> - 🎯 适用场景：流程控制、数据配置、非程序员原型制作
>
> **C++**
> - 🟢 优势：文本Diff友好、编译时检查、高性能、易于重构
> - 🔴 劣势：编译时间长、上手门槛高、迭代速度慢
> - 🎯 适用场景：核心逻辑、网络同步、性能关键路径、基类定义
>
> **推荐策略**：C++定义骨架（基类、接口、数据结构），Blueprint填充血肉（流程、配置、特效）

> **传统插件 vs Game Feature**
>
> **传统插件（Plugins）**
> - 🟢 优势：完全独立、跨项目复用、清晰的依赖关系
> - 🔴 劣势：与Game Module解耦，扩展现有功能需要接口
> - 🎯 适用场景：通用系统（库存、对话、成就系统）
>
> **Game Feature**
> - 🟢 优势：可动态加载、支持DLC、可注入Primary Assets、运行时开关
> - 🔴 劣势：与项目耦合、不可移植
> - 🎯 适用场景：游戏模式、角色职业、地图扩展、DLC内容

### 避坑指南

**坑1：文档写了没人看**
- ❌ 错误做法：写一个50页的PDF丢到共享盘
- ✅ 正确做法：GitHub实时文档 + 嵌入式规范 + 自动化验证 + 创意传播

**坑2：Blueprint和C++职责不清**
- ❌ 错误做法：所有逻辑都在Blueprint或所有逻辑都在C++
- ✅ 正确做法：C++定义边界和核心逻辑，Blueprint处理流程和配置

**坑3：多人编辑同一个Blueprint导致冲突**
- ❌ 错误做法：所有功能都塞在一个巨大的Blueprint里
- ✅ 正确做法：分层设计 + 数据专用BP + Gameplay Cue分离视听

**坑4：UI前后端耦合导致重构噩梦**
- ❌ 错误做法：UI直接引用游戏逻辑类
- ✅ 正确做法：使用UMG ViewModel建立契约层

**坑5：项目后期才考虑DLC**
- ❌ 错误做法：先做完游戏再想DLC怎么加
- ✅ 正确做法：技术预研阶段就规划数据结构和打包策略

**坑6：跨插件引用混乱**
- ❌ 错误做法：忽略编辑器警告，强制引用
- ✅ 正确做法：启用依赖检查 + CI/CD验证 + 定期审计

---

## 结语

Jack Condon的这场演讲为我们提供了一个全面的技术预研框架，从文档编写到系统架构，从团队协作到DLC规划，每一个环节都蕴含着来自实战的宝贵经验。

技术预研不是简单的技术选型，而是一个**系统工程**：它需要我们站在整个团队协作的角度思考，用**工程化的手段**解决**人的问题**。

当我们谈论Blueprint vs C++时，我们实际上在讨论如何让程序员、设计师和美术师**高效协作而不相互阻塞**；当我们设计模块化架构时，我们实际上在为未来的**可扩展性和可维护性**投资。

正如Jack所说：

> **"如果你的团队没有遵循你的文档，那是你的责任，不是他们的。"**

技术领导者的职责不仅是写出优秀的代码和文档，更是要**确保团队能够理解、记住并实施最佳实践**。

希望这篇文章能帮助你在下一个虚幻引擎项目的技术预研阶段少走弯路，构建更加稳固和高效的技术基础。

---

## 相关资源

- **Linter UE5 Style Guide**: https://github.com/Allar/ue5-style-guide
- **Valentin Galea - Growing a Healthy UE4 Ecosystem**: Unreal Fest Europe 2019
- **Unreal Engine Product Board**: https://portal.productboard.com/epicgames/1-unreal-engine-public-roadmap
- **Lyra Sample Project**: Epic Games官方示例项目
- **UMG ViewModel Plugin**: Unreal Engine官方文档

---

**作者说明**：本文基于 Jack Condon 在 Unreal Fest Shanghai 2025 的演讲内容整理而成，结合了个人对虚幻引擎开发的理解和实践经验。文章旨在为中文开发者社区提供一份系统化的技术预研指南。

如有任何问题或讨论，欢迎加入UE5技术交流群！
