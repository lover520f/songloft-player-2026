import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// 当前进程是否注册了 `flutter_inappwebview` 的平台实现。
///
/// 背景：flutter_inappwebview 的平台矩阵只有 Android/iOS/macOS/Windows/Web，
/// **没有 Linux 实现**（上游 Linux/WPE 支持停留在 6.2.0-beta 且要求 WPE WebKit
/// 运行时，Ubuntu 24.04+ 已无该运行时包）。Linux 上 `InAppWebView` 会在构造期
/// 抛 `Null check operator used on a null value`（`InAppWebViewPlatform.instance!`），
/// `onLoadStart`/`onLoadStop` 永不触发，`PluginRenderView` 继而报出一个误导性的
/// 「加载超时」（songloft-org/songloft-player#47）。
///
/// native 平台的插件注册先于 `runApp` 完成，故「instance 非 null」即可作为
/// 「本平台有 WebView 渲染面」的判据；为 false 时宿主页面不得挂载渲染面，
/// 应改走降级视图。Web 端永远走 iframe stub，不使用本函数。
bool isWebViewPlatformAvailable() => InAppWebViewPlatform.instance != null;
