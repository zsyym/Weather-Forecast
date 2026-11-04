# 天气预报

一款使用 Objective-C 和 UIKit 编写的 iOS 天气应用，可搜索城市、保存关注城市，并查看当前天气与未来预报。

![Platform](https://img.shields.io/badge/platform-iOS-lightgrey) ![Language](https://img.shields.io/badge/language-Objective--C-blue) ![UI](https://img.shields.io/badge/UI-UIKit-orange) ![Weather%20data](https://img.shields.io/badge/data-WeatherAPI-4A90E2)

## 项目介绍

应用通过 WeatherAPI 获取天气和城市搜索数据，以本地保存的城市列表作为首页内容。天气详情页展示当前天气、空气质量、逐小时天气、7 日预报和天气指标；天气背景图来自项目内的 Asset Catalog。

## 核心功能

- 搜索城市并查看对应天气详情。
- 保存或删除关注城市，城市列表使用 `NSUserDefaults` 持久化；首次使用时显示北京。
- 首页展示已保存城市的当前天气。
- 查看当前天气、空气质量、24 小时天气、7 日预报及体感温度、风速、日出日落等指标。
- 按天气状况代码选择本地天气背景图和 SF Symbols 图标。

## 技术栈

| 类别 | 技术 |
| --- | --- |
| 语言与界面 | Objective-C、UIKit |
| 网络 | `NSURLSession`、WeatherAPI REST API |
| 数据解析 | `NSJSONSerialization`、手动模型映射 |
| 布局 | Masonry |
| 本地存储 | `NSUserDefaults` |
| 资源 | Storyboard、Asset Catalog、SF Symbols |

## 架构

项目按职责分组，采用 UIKit 的视图控制器组织页面，由独立服务封装远端请求，模型负责将 API 字典映射为应用对象。城市持久化由 `SavedCityStore` 管理。

```text
.
├── Base.lproj/                 # 主界面和启动页 Storyboard
├── Resource/
│   ├── Assets.xcassets/         # 天气背景、应用图标和颜色资源
│   └── SceneDelegate.*          # Scene 生命周期与根页面
├── Services/
│   └── WeatherAPIService.*      # 天气查询和城市搜索
├── model/                       # 天气、城市、预报与存储模型
├── view/                        # 列表、天气详情和预报单元格
├── viewControll/                # 首页、搜索、详情和翻页控制器
├── AppDelegate.*
├── Info.plist
├── ViewController.*             # Storyboard 初始控制器
└── main.m
```

## 页面与资源

仓库当前没有应用运行截图。`Resource/Assets.xcassets` 中包含晴、云、雨、雪、雾、雨夹雪和雷暴等天气背景资源；这些资源用于应用界面，不是页面截图。

## 关键实现

- `WeatherAPIService` 使用 `NSURLComponents` 和 `NSURLQueryItem` 构建请求参数，并将完成回调切回主线程。
- `CurrentWeatherModel` 与 `totalWeatherModel` 等模型负责映射 WeatherAPI 返回的数据；天气代码映射为本地背景和 SF Symbols。
- `SavedCityStore` 将城市经纬度和名称存入 `NSUserDefaults`，首页根据城市列表加载天气。
- 首页搜索通过延迟触发请求降低输入过程中的请求频率。

## 环境与运行

这是 iOS 原生源码，但当前仓库未包含 `.xcodeproj`、`.xcworkspace`、依赖管理清单或构建脚本，因此无法从此仓库直接打开并构建应用。源码引用了 Masonry（`#import <Masonry/Masonry.h>`），需要在 Xcode 工程中配置该依赖；还需要配置有效的 WeatherAPI API Key。

准备好包含这些源码文件、Storyboard 与 `Resource/Assets.xcassets` 的 Xcode iOS App 工程，并集成 Masonry 后，可在 Xcode 中选择 iOS 模拟器或设备运行。当前仓库没有声明最低 iOS 版本；实际最低版本需由工程 Deployment Target 确定。API Key 当前硬编码在 `Services/WeatherAPIService.m`，公开仓库前应撤销/轮换该密钥，并改为由安全的服务端代理提供，不能把新的私钥放入客户端源码。

## 项目亮点与学习内容

- 覆盖 UIKit 页面导航、表格和集合视图的组合使用。
- 展示基于 `NSURLSession` 的异步 API 调用与 JSON 模型映射。
- 将城市搜索、天气展示和本地收藏拆分到不同职责模块。
- 使用 Auto Layout（Masonry）和 Asset Catalog 构建动态天气界面。

## 已知限制

- 当前仓库缺少 Xcode 工程和依赖声明，构建入口与支持的 iOS 版本无法从现有文件确认。
- WeatherAPI 密钥存在于客户端源码中；客户端内的 API Key 可被提取，不应视为秘密。
- 仓库没有测试目标、CI 配置或应用截图。
