import 'package:go_router/go_router.dart';
import 'package:surface/screens/account.dart';
import 'package:surface/screens/auth/login.dart';
import 'package:surface/screens/auth/register.dart';
import 'package:surface/screens/explore.dart';
import 'package:surface/screens/home.dart';
import 'package:surface/widgets/navigation/app_scaffold.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(
        body: child,
        showBottomNavigation: true,
      ),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/posts',
          name: 'explore',
          builder: (context, state) => const ExploreScreen(),
        ),
        GoRoute(
          path: '/account',
          name: 'account',
          builder: (context, state) => const AccountScreen(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) => AppScaffold(
        body: child,
        autoImplyAppBar: true,
      ),
      routes: [
        GoRoute(
          path: '/auth/login',
          name: 'authLogin',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/auth.register',
          name: 'authRegister',
          builder: (context, state) => const RegisterScreen(),
        ),
      ],
    ),
  ],
);
