import 'package:flutter/material.dart';

/// 全局间距规范（基于 8px 基数）
class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// 全局圆角规范
class AppRadius {
  AppRadius._();
  static const double sm = 8; // 小组件（图标、标签）
  static const double md = 12; // 卡片、输入框
  static const double lg = 16; // 封面、大面板
  static const double xl = 24; // 搜索栏、胶囊按钮
  static const double xxl = 28; // 播放按钮、大胶囊

  // 便捷 BorderRadius
  static final BorderRadius smAll = BorderRadius.circular(sm);
  static final BorderRadius mdAll = BorderRadius.circular(md);
  static final BorderRadius lgAll = BorderRadius.circular(lg);
  static final BorderRadius xlAll = BorderRadius.circular(xl);
  static final BorderRadius xxlAll = BorderRadius.circular(xxl);
}

/// 全局阴影规范
class AppShadows {
  AppShadows._();
  static const List<BoxShadow> light = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];
  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.08),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];
  static const List<BoxShadow> heavy = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 20,
      offset: Offset(0, 10),
    ),
  ];
}

/// 视觉特效（glow 发光阴影）
class AppEffects {
  AppEffects._();

  /// 主色发光 — 播放按钮、封面强调
  static List<BoxShadow> primaryGlow(Color primaryColor) => [
    BoxShadow(color: primaryColor.withValues(alpha: 0.30), spreadRadius: 1),
    BoxShadow(
      color: primaryColor.withValues(alpha: 0.45),
      blurRadius: 40,
      offset: const Offset(0, 18),
      spreadRadius: -10,
    ),
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.45),
      blurRadius: 18,
      offset: Offset(0, 6),
      spreadRadius: -4,
    ),
  ];

  /// 柔和发光 — 封面、浮动卡片
  static List<BoxShadow> softGlow(Color onSurfaceColor) => [
    BoxShadow(color: onSurfaceColor.withValues(alpha: 0.08), spreadRadius: 1),
    const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.55),
      blurRadius: 60,
      offset: Offset(0, 30),
      spreadRadius: -20,
    ),
  ];
}

/// 胶囊迷你播放器（`navigationStyle == 'capsule'`）尺寸规范。
///
/// 手机与大屏共用同一套结构：一条 48px 内容行（封面 / 标题 / 控制区）**相对胶囊
/// 垂直居中** + 顶边一条 3px 圆角进度（带一段点按 / 拖拽热区）。
///
/// 内容行浮在**整条**胶囊上（见 `CapsuleMiniPlayer` 的 `Stack`），不是进度热区的
/// flex 兄弟：顶边热区属于覆盖层、不占内容行的纵向空间。于是胶囊高度 = 内容行 +
/// 顶部热区高度（同一段空间同时充当底部呼吸空间）：手机 `48 + 11 = 59`、
/// 大屏 `48 + 16 = 64`。若把热区当成 `Column` 里的兄弟节点，内容行会被整块推下去，
/// 行中心落到胶囊的 56% 处 —— 看着就是「封面和按钮没有垂直居中」。
///
/// pill 圆角由高度推导（`height / 2`），因此不在这里定义 radius，也不新增 `AppRadius`
/// token。
class AppCapsulePlayer {
  AppCapsulePlayer._();

  /// 顶边进度：视觉轨道厚度。
  ///
  /// 轨道**整宽贴着胶囊顶边框**（相对 pill 顶边 y = 0，无左右 inset），两端顺着顶角
  /// 圆弧被 pill 轮廓裁掉 —— miot 插件 `.player-bar-progress`、Lynx 客户端
  /// `.mini-player__progress` 都是这个形态，因此这里只定义厚度，不定义左右边距。
  static const double progressTrackHeight = 3;

  /// 顶边进度：大屏手势热区高度（从胶囊**顶边**起算，整条横跨胶囊）。
  ///
  /// 轨道只占最上面 3px，其余是留给手指的余量 —— 3px 的细条当不了触摸目标。
  /// 热区同时也是胶囊顶部的呼吸空间：内容行居中后，封面最上沿与胶囊顶边之间正好
  /// 留出这一段（大屏封面 44 落在 64 里 → 上下各 10）。
  static const double progressHitHeightDesktop = 16;

  /// 顶边进度：手机手势热区高度（轨道 3px + 8px 留白，与大屏档同一份手指余量）
  static const double progressHitHeightMobile = progressTrackHeight + 8; // 11

  /// 内容行高度（封面 / 控制按钮所在行，两档一致）
  static const double rowHeight = 48;

  /// 胶囊整体高度 = 内容行 + 顶部热区（同时也是底部呼吸空间）
  static const double heightMobile = progressHitHeightMobile + rowHeight; // 59
  static const double heightDesktop =
      progressHitHeightDesktop + rowHeight; // 64

  /// 大屏毛玻璃模糊强度（`GlassSurface` sigma）
  static const double blurSigma = 20;

  /// 胶囊相对屏幕的水平外边距
  static const double marginHorizontalMobile = 8;
  static const double marginHorizontalDesktop = 16;

  /// 胶囊相对屏幕的底部外边距（安全区在其之上另行叠加）
  static const double marginBottomMobile = 8;
  static const double marginBottomDesktop = 12;

  /// 行内容（封面 / 标题 / 控制区）水平内边距；顶边进度整宽铺满，不受这个值影响
  static const double rowPaddingMobile = 12;
  static const double rowPaddingDesktop = 16;

  /// 封面尺寸
  static const double coverSizeMobile = 36;
  static const double coverSizeDesktop = 44;

  /// 上一首 / 下一首命中框尺寸（大屏统一 44）
  static const double skipHitSizeMobile = 36;
  static const double skipHitSizeDesktop = 44;

  /// 大屏显示右侧时间文本所需的内容行宽。
  ///
  /// 组成（实测 800 宽平板，pill 686 宽 → 内容行 654）：固定占位 ~394
  /// （封面 44 + 间距 12 + 控制区 318 + 间距 12/8）+ 标题下限 ~120 + 时间 ~95
  /// ≈ 609，取 620 留一点余量。低于此值时收起时间，把宽度整块让给标题
  /// （`ScrollingText` 自会滚动显示）。
  /// 参考：800 宽平板的行宽为 654（显示），600 宽平板为 536（收起）。
  static const double minWidthForTime = 620;

  /// 大屏工具栏总高（含底边距与呼吸空间），供滚动底部间距预留
  static const double desktopOverlayInset =
      heightDesktop + marginBottomDesktop + 8; // 84

  /// pill 圆角：全圆角由高度推导，不引入新的圆角 token
  static BorderRadius pillRadius(double height) =>
      BorderRadius.circular(height / 2);
}
