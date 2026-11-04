# 代码质量审查报告

审查范围：当前仓库中的 Objective-C 源文件、Storyboard、Info.plist 与资源目录。此次只新增文档，没有修改业务代码或现有资源。

## 发现

### [P1] WeatherAPI 凭据硬编码在客户端

位置：[Services/WeatherAPIService.m:12](Services/WeatherAPIService.m#L12)

WeatherAPI Key 作为源码常量提交，并被直接放入请求 URL。任何拿到应用包或仓库的人都能提取该值，可能导致额度滥用或账号费用风险。若该值是真实密钥，应立即在供应商处轮换；公开仓库前移除旧值。长期方案是让客户端调用受控后端，由后端保存供应商凭据。仅移入客户端配置文件不能保护密钥。

### [P1] JSON 解析失败后仍继续使用无效对象

位置：[Services/WeatherAPIService.m:60](Services/WeatherAPIService.m#L60)、[Services/WeatherAPIService.m:152](Services/WeatherAPIService.m#L152)

解析错误分支调度 `completion(nil, jsonError)` 后没有从网络回调返回；当 JSON 顶层类型不匹配且 `jsonError == nil` 时，也会把 nil 错误交给调用方，随后继续以无效字典创建模型。应在错误回调后立即返回，并为非预期响应结构生成明确 NSError。城市搜索的同类分支位于 [Services/WeatherAPIService.m:102](Services/WeatherAPIService.m#L102)，目前会回调后返回，但顶层类型错误时错误对象同样可能为 nil。

### [P1] 天气页面可能因失败请求留下空控制器而崩溃

位置：[viewControll/HomeViewController.m:127](viewControll/HomeViewController.m#L127)、[viewControll/HomeViewController.m:133](viewControll/HomeViewController.m#L133)、[viewControll/HomeViewController.m:151](viewControll/HomeViewController.m#L151)、[viewControll/weatherPageViewController.m:58](viewControll/weatherPageViewController.m#L58)

翻页页会并发请求所有城市天气。请求失败时对应数组位置仍为 `NSNull`，但组通知仍会展示分页控制器，初始化时将该对象传给 `setViewControllers:`，可能触发 UIKit 异常。应只展示成功创建的详情页，并确保当前选中城市请求失败时提供错误状态而不是空页面。

### [P2] 搜索响应可能以旧结果覆盖新关键词

位置：[viewControll/SearchViewController.m:26](viewControll/SearchViewController.m#L26)、[viewControll/SearchViewController.m:36](viewControll/SearchViewController.m#L36)、[viewControll/SearchViewController.m:47](viewControll/SearchViewController.m#L47)

延迟调用只取消尚未发出的 `performSelector`，不会取消已经开始的网络请求，也没有在回调时比较请求关键词。用户快速输入时，较早请求若较晚返回，会覆盖当前关键词的结果。建议保存请求序号或发起时的关键词，并仅接纳仍对应最新输入的响应。

### [P2] 存储中的城市数据缺少结构校验

位置：[model/SavedCityStore.m:14](model/SavedCityStore.m#L14)、[model/SavedCityStore.m:17](model/SavedCityStore.m#L17)

代码假设 `NSUserDefaults` 中的值必定是字典数组，且每项都支持下标访问。历史版本或异常/损坏数据可能导致类型错误或对象访问异常。读取时应校验顶层和每项类型，并对缺失字段提供一致的默认处理。

### [P2] 城市详情页直接索引预报数组与小时数组

位置：[viewControll/weatherDetailViewController.m:45](viewControll/weatherDetailViewController.m#L45)、[viewControll/weatherDetailViewController.m:154](viewControll/weatherDetailViewController.m#L154)、[viewControll/weatherDetailViewController.m:157](viewControll/weatherDetailViewController.m#L157)

页面假设预报至少有两天且每天都有 24 个小时数据，并直接访问 `[0]`、`[1]` 和按小时计算出的下标。API 返回部分数据、模型字段缺失或异常时间值时可能越界。建议在模型/页面边界验证数量和范围，并让缺失数据显示空状态。

### [P2] 快速删除城市期间，首页天气回调仍使用旧索引

位置：[viewControll/HomeViewController.m:51](viewControll/HomeViewController.m#L51)、[viewControll/HomeViewController.m:65](viewControll/HomeViewController.m#L65)、[viewControll/HomeViewController.m:106](viewControll/HomeViewController.m#L106)

天气请求闭包捕获发起请求时的 `i`。如果用户在响应到达前删除城市，数组和表格 section 会移动，旧回调可能把模型写入错误位置或按失效 section 刷新。可按城市稳定标识关联请求结果，并在更新前确认城市仍存在。

## 其他质量建议

- 网络请求的 URL 构造失败路径只记录日志并直接返回，调用方 completion 永远不触发（例如 [Services/WeatherAPIService.m:34](Services/WeatherAPIService.m#L34)）。改为返回统一错误，保证每个请求都有完成结果。
- 三个天气请求方法重复实现状态码检查、JSON 解析和主线程回调。修复错误分支后，可抽取小型私有请求/解析辅助方法，避免行为逐渐分叉；无需为此进行大规模重构。
- 首页天气、搜索错误目前只写入日志，用户看不到失败原因或重试入口。建议补充轻量错误状态和重试交互。
- `SavedCityStore` 每次保存都调用 `synchronize`（[model/SavedCityStore.m:45](model/SavedCityStore.m#L45)、[model/SavedCityStore.m:60](model/SavedCityStore.m#L60)）。现代 iOS 通常由系统异步持久化，无需显式同步；可在后续存储调整中移除并验证写入语义。
- 模型图标映射逻辑在多个模型中重复（例如 [model/CurrentWeatherModel.m:71](model/CurrentWeatherModel.m#L71) 与 [model/HourWeatherModel.m:35](model/HourWeatherModel.m#L35)）。如果后续维护频繁，可集中到一个天气代码映射器；这是可维护性建议，不是当前必须重构项。
- 命名风格混用 Pascal/camel case 与拼写不一致（如 `totalWeatherModel`、`pageControll`、`cityListTableview`）；建议新代码采用统一的 Objective-C 命名，不必为纯风格原因批量改名。

## 架构与资源评估

项目采用按职责分目录的 UIKit MVC 结构：控制器负责页面/交互，`WeatherAPIService` 负责远程请求，模型映射 JSON，`SavedCityStore` 管理城市偏好数据，`view/` 提供复用单元格。边界整体可辨认；目前主要风险集中在服务错误路径和控制器直接依赖数据完整性的部分。资源管理方面未发现明显手动内存管理问题，项目使用 ARC 风格和弱引用避免主要网络回调持有控制器；未发现文件句柄等需要手动释放的资源。

## 验证限制

仓库没有 `.xcodeproj`、`.xcworkspace`、依赖清单、测试目标或 CI 配置，因而无法执行 Xcode 构建或自动化测试。代码审查基于静态读取；以上问题尚未通过复现测试验证。现有 `.jpg` 是天气界面资源，不是完整应用截图。
