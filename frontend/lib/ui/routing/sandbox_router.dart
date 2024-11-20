import 'package:go_router/go_router.dart';
import 'package:sandbox/ui/routing/no_transition.dart';
import 'package:sandbox/ui/routing/sandbox_navigator_key.dart';
import 'package:sandbox/ui/screens/home_screen.dart';
import 'package:sandbox/ui/screens/login_screen.dart';
import 'package:sandbox/ui/screens/splash_screen.dart';

final sandboxRouter = GoRouter(
  navigatorKey: sandboxNavigatorKey,
  initialLocation: SplashScreen.routePath,
  routes: [
    GoRoute(
      name: SplashScreen.routeName,
      path: SplashScreen.routePath,
      pageBuilder: (context, state) => noTransition(
        context,
        state,
        const SplashScreen(),
      ),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routePath,
      pageBuilder: (context, state) => noTransition(
        context,
        state,
        const LoginScreen(),
      ),
    ),
    GoRoute(
      name: HomeScreen.routeName,
      path: HomeScreen.routePath,
      pageBuilder: (context, state) => noTransition(
        context,
        state,
        const HomeScreen(),
      ),
    ),
  ],
);
