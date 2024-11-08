import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/providers/theme.dart';
import 'package:surface/providers/userinfo.dart';
import 'package:surface/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(const SolianApp());
}

class SolianApp extends StatelessWidget {
  const SolianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: [Locale('en', 'US'), Locale('zh', 'CN')],
        fallbackLocale: Locale('en', 'US'),
        useFallbackTranslations: true,
        assetLoader: JsonAssetLoader(),
        child: MultiProvider(
          providers: [
            Provider(create: (_) => SnNetworkProvider()),
            ChangeNotifierProvider(create: (_) => UserProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: Builder(builder: (context) {
            final th = context.watch<ThemeProvider>();
            return MaterialApp.router(
              theme: th.theme.light,
              darkTheme: th.theme.dark,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              routerConfig: appRouter,
            );
          }),
        ),
      ),
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
      ],
    );
  }
}