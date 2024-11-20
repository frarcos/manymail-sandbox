import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandbox/constants/sandbox_colors.dart';
import 'package:sandbox/constants/sandbox_paddings.dart';
import 'package:sandbox/constants/sandbox_text_style.dart';
import 'package:sandbox/data-layer/providers/account_provider.dart';
import 'package:sandbox/ui/routing/sandbox_router.dart';
import 'package:sandbox/ui/screens/home_screen.dart';
import 'package:sandbox/ui/widgets/sandbox_button.dart';
import 'package:sandbox/ui/widgets/sandbox_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';
  static const String routePath = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SandboxColors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/logos/logo.png',
                  width: 100,
                ),
              ),
              const SizedBox(
                height: SandboxPaddings.s,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: SandboxTextStyle.headingMedium,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter your account details and start testing emails!',
                  style: SandboxTextStyle.bodyMedium.copyWith(
                    color: SandboxColors.grey3,
                  ),
                ),
              ),
              const SizedBox(
                height: SandboxPaddings.m,
              ),
              SandboxTextField(
                hint: 'Username',
                onChanged: (value) {
                  context.read<AccountProvider>().setAccount(
                        currentUsername: value,
                      );
                },
                onFieldSubmitted: (value) async {
                  bool loggedIn = await context.read<AccountProvider>().login();
                  if (loggedIn) {
                    sandboxRouter.goNamed(HomeScreen.routeName);
                  }
                },
              ),
              const SizedBox(
                height: SandboxPaddings.m,
              ),
              SandboxTextField(
                hint: 'Password',
                obscureText: true,
                onChanged: (value) {
                  context.read<AccountProvider>().setAccount(
                        currentPassword: value,
                      );
                },
                onFieldSubmitted: (value) async {
                  bool loggedIn = await context.read<AccountProvider>().login();
                  if (loggedIn) {
                    sandboxRouter.goNamed(HomeScreen.routeName);
                  }
                },
              ),
              const SizedBox(
                height: SandboxPaddings.m,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SandboxButton(
                  label: 'Login',
                  fillColor: SandboxColors.blue,
                  labelColor: SandboxColors.white,
                  onTap: () async {
                    bool loggedIn = await context.read<AccountProvider>().login();
                    if (loggedIn) {
                      sandboxRouter.goNamed(HomeScreen.routeName);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
