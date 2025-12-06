import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/application/auth_service.dart';
import '../../features/auth/presentation/views/auth_screen.dart';
import '../../features/dashboard/presentation/views/dashboard_screen.dart';
import '../../features/marketplace/presentation/views/marketplace_screen.dart';
import '../../features/services/presentation/views/services_screen.dart';
import '../../features/projects/presentation/views/projects_screen.dart';
import '../../features/profile/presentation/views/profile_screen.dart';
import '../widgets/scaffold_with_nav_bar.dart';

class AppRouter {
  const AppRouter._();
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _shellNavigatorDashboardKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellDashboard');
  static final GlobalKey<NavigatorState> _shellNavigatorMarketplaceKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellMarketplace');
  static final GlobalKey<NavigatorState> _shellNavigatorServicesKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellServices');
  static final GlobalKey<NavigatorState> _shellNavigatorProjectsKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellProjects');
  static final GlobalKey<NavigatorState> _shellNavigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellProfile');

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/dashboard',
    debugLogDiagnostics: kDebugMode,
    refreshListenable: AuthService.instance.authListenable,
    redirect: (context, state) {
      final isAuthenticated = AuthService.instance.isAuthenticated;
      final isProfileRoute = state.uri.path == '/profile';
      final isAuthRoute = state.uri.path == '/auth';

      // Protect Profile Route
      if (isProfileRoute && !isAuthenticated) {
        return '/auth';
      }

      // Redirect to Profile if visiting Auth while logged in
      if (isAuthRoute && isAuthenticated) {
        return '/profile';
      }

      return null;
    },
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Page not found'))),
    routes: [
      // Auth Route (outside shell)
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(), // Auth entry
      ),
      // App Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Dashboard
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDashboardKey,
            routes: [
              GoRoute(
                path: '/dashboard',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: DashboardScreen()),
              ),
            ],
          ),
          // Marketplace
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMarketplaceKey,
            routes: [
              GoRoute(
                path: '/marketplace',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: MarketplaceScreen()),
              ),
            ],
          ),
          // Services
          StatefulShellBranch(
            navigatorKey: _shellNavigatorServicesKey,
            routes: [
              GoRoute(
                path: '/services',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ServicesScreen()),
              ),
            ],
          ),
          // Projects
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProjectsKey,
            routes: [
              GoRoute(
                path: '/projects',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProjectsScreen()),
              ),
            ],
          ),
          // Profile
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfileScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
