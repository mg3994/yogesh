import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yogesh/l10n/app_localizations.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Basic responsive implementation:
    // Large screen -> NavigationRail
    // Small screen -> BottomNavigationBar
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return ScaffoldWithBottomNavBar(
            navigationShell: navigationShell,
            onTap: (index) => _onTap(context, index),
          );
        } else {
          return ScaffoldWithNavRail(
            navigationShell: navigationShell,
            onTap: (index) => _onTap(context, index),
          );
        }
      },
    );
  }
}

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    super.key,
    required this.navigationShell,
    required this.onTap,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: onTap,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            label: l10n.dashboard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.store_outlined),
            selectedIcon: const Icon(Icons.store),
            label: l10n.marketplace,
          ),
          NavigationDestination(
            icon: const Icon(Icons.design_services_outlined),
            selectedIcon: const Icon(Icons.design_services),
            label: l10n.services,
          ),
          NavigationDestination(
            icon: const Icon(Icons.work_outline),
            selectedIcon: const Icon(Icons.work),
            label: l10n.projects,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }
}

class ScaffoldWithNavRail extends StatelessWidget {
  const ScaffoldWithNavRail({
    super.key,
    required this.navigationShell,
    required this.onTap,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: theme.colorScheme.surface,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: onTap,
            labelType: NavigationRailLabelType.all,
            groupAlignment: -0.85,
            leading: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: FloatingActionButton(
                elevation: 0,
                onPressed:
                    () {}, // Add functionality if needed, e.g. quick create
                child: const Icon(Icons.add),
              ),
            ),
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.dashboard_outlined),
                selectedIcon: const Icon(Icons.dashboard),
                label: Text(l10n.dashboard),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.store_outlined),
                selectedIcon: const Icon(Icons.store),
                label: Text(l10n.marketplace),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.design_services_outlined),
                selectedIcon: const Icon(Icons.design_services),
                label: Text(l10n.services),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.work_outline),
                selectedIcon: const Icon(Icons.work),
                label: Text(l10n.projects),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.person_outline),
                selectedIcon: const Icon(Icons.person),
                label: Text(l10n.profile),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}
