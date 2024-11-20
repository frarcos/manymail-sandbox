import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/data-layer/providers/account_provider.dart';
import 'package:sandbox/ui/routing/sandbox_router.dart';
import 'package:sandbox/ui/screens/home_screen.dart';
import 'package:sandbox/ui/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash';
  static const String routePath = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool isLoggedIn = await context.read<AccountProvider>().isLoggedIn();
      if (isLoggedIn) {
        sandboxRouter.goNamed(HomeScreen.routeName);
      } else {
        sandboxRouter.goNamed(LoginScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SandboxColors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logos/logo.png',
          width: 200,
        ),
      ),
    );
  }
}
