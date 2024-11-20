import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';
import 'package:sandbox/data-layer/providers/_providers.dart';
import 'package:sandbox/ui/routing/sandbox_router.dart';

class SandboxApp extends StatefulWidget {
  const SandboxApp({super.key});

  @override
  State<SandboxApp> createState() => _SandboxAppState();
}

class _SandboxAppState extends State<SandboxApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp.router(
        title: 'ManyMail Sandbox',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          colorSchemeSeed: SandboxColors.black,
        ).copyWith(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: SandboxColors.blue,
            selectionColor: SandboxColors.blue.withOpacity(0.25),
          ),
          textTheme: const TextTheme(
            displayLarge: SandboxTextStyle.displayLarge,
            displayMedium: SandboxTextStyle.displayMedium,
            displaySmall: SandboxTextStyle.displaySmall,
            headlineLarge: SandboxTextStyle.headingLarge,
            headlineMedium: SandboxTextStyle.headingMedium,
            headlineSmall: SandboxTextStyle.headingSmall,
            titleLarge: SandboxTextStyle.titleLarge,
            titleMedium: SandboxTextStyle.titleMedium,
            titleSmall: SandboxTextStyle.titleSmall,
            bodyLarge: SandboxTextStyle.bodyLarge,
            bodyMedium: SandboxTextStyle.bodyMedium,
            bodySmall: SandboxTextStyle.bodySmall,
            labelLarge: SandboxTextStyle.labelLarge,
            labelMedium: SandboxTextStyle.labelMedium,
            labelSmall: SandboxTextStyle.labelSmall,
          ),
        ),
        routerConfig: sandboxRouter,
      ),
    );
  }
}
