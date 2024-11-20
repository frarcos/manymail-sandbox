import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:sandbox/ui/sandbox_app.dart';

void main() async {
  usePathUrlStrategy();

  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('it')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const SandboxApp(),
    ),
  );
}
