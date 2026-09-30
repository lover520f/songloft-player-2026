import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:songloft_flutter/features/home/presentation/plugin_unsupported_view.dart';
import 'package:songloft_flutter/l10n/app_localizations.dart';

void main() {
  testWidgets('降级视图说明限制并提供浏览器出口（zh）', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('zh'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: PluginUnsupportedView(url: 'http://localhost:58091/x/'),
        ),
      ),
    );

    expect(find.text('当前平台暂不支持应用内插件页'), findsOneWidget);
    expect(find.text('在浏览器中打开'), findsOneWidget);
    expect(find.byIcon(Icons.open_in_browser), findsOneWidget);
  });

  testWidgets('降级视图英文文案可用（en）', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: PluginUnsupportedView(url: 'http://localhost:58091/x/'),
        ),
      ),
    );

    expect(
      find.text('In-app plugin pages are not supported on this platform'),
      findsOneWidget,
    );
    expect(find.text('Open in browser'), findsOneWidget);
  });
}
