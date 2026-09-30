import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';

/// 当前平台没有 WebView 平台实现时的降级视图（songloft-org/songloft-player#47）。
///
/// Linux 桌面端没有 flutter_inappwebview 平台实现，挂载渲染面会在构造期直接崩溃；
/// 与其让用户转圈 20s 后看到误导性的「加载超时」，不如明确说明限制并给出
/// 「在浏览器中打开」的出口。样式对齐 `PluginRenderView` 的错误视图。
class PluginUnsupportedView extends StatelessWidget {
  /// 已拼好的完整插件页 URL（含 theme / access_token），原样交给「在浏览器中打开」。
  final String url;

  const PluginUnsupportedView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.web_asset_off_outlined,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              AppLocalizations.of(context).homePluginWebViewUnsupported,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context).homePluginWebViewUnsupportedHint,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed:
                  () => launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  ),
              icon: const Icon(Icons.open_in_browser),
              label: Text(AppLocalizations.of(context).homePluginOpenInBrowser),
            ),
          ],
        ),
      ),
    );
  }
}
