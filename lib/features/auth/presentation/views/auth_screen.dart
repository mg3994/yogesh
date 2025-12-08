import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:yogesh/l10n/app_localizations.dart';
import '../../application/auth_service.dart';
import '../../domain/models/user_model.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    // Watch signal for reactive updates
    // In actual app, we would probably watch the user or roles signal specifically
    // But since AuthService exposes computed signals, we can watch them.
    // However, SignalsFlutter's Watch widget or .watch(context) is needed.
    // The original code used AuthService.instance.selectedRoles which was a signal?
    // No, it was a getter for .value in the previous code?
    // Let's assume we need to rebuild when roles change.

    // We can use the Watch widget to react to signal changes
    return Watch((context) {
      // Accessing signal to subscribe
      AuthService.instance.isAuthenticated;

      return _AuthScreenBody(l10n: l10n!, theme: theme);
    });
  }
}

class _AuthScreenBody extends StatefulWidget {
  final AppLocalizations l10n;
  final ThemeData theme;

  const _AuthScreenBody({required this.l10n, required this.theme});

  @override
  State<_AuthScreenBody> createState() => _AuthScreenBodyState();
}

class _AuthScreenBodyState extends State<_AuthScreenBody> {
  // Local state for role selection before mock login
  final Set<UserRole> _selectedRoles = {UserRole.client};

  void _toggleRole(UserRole role) {
    setState(() {
      if (_selectedRoles.contains(role)) {
        _selectedRoles.remove(role);
      } else {
        _selectedRoles.add(role);
      }
    });
  }

  void _handleLogin() {
    // In a real app, we'd send credentials.
    // Here we just set the mock user with selected roles.

    // We need to update AuthService to accept roles for the mock login
    // Or we just update the user after login?
    // Let's update AuthService.login to accept roles optionally or we just toggle them after.

    // Let's modify AuthService to accept roles in login for this specific mock flow
    // OR just use what I wrote: login() creates a user with Client role.
    // Then we can toggle.

    AuthService.instance.login(); // Creates user with Client role

    // Apply other roles
    for (final role in _selectedRoles) {
      if (role != UserRole.client) {
        AuthService.instance.toggleRole(role);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.l10n.authHeader,
                textAlign: TextAlign.center,
                style: widget.theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Select your role(s) to continue',
                style: widget.theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _RoleChip(
                    label: 'Client',
                    icon: Icons.person_outline,
                    isSelected: _selectedRoles.contains(UserRole.client),
                    onSelected: () => _toggleRole(UserRole.client),
                  ),
                  _RoleChip(
                    label: 'Contractor',
                    icon: Icons.engineering_outlined,
                    isSelected: _selectedRoles.contains(UserRole.contractor),
                    onSelected: () => _toggleRole(UserRole.contractor),
                  ),
                  _RoleChip(
                    label: 'Supplier',
                    icon: Icons.inventory_2_outlined,
                    isSelected: _selectedRoles.contains(UserRole.supplier),
                    onSelected: () => _toggleRole(UserRole.supplier),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _selectedRoles.isNotEmpty ? _handleLogin : null,
                  child: Text(widget.l10n.continueButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FilterChip(
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? theme.colorScheme.onPrimaryContainer
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outline,
        ),
      ),
    );
  }
}
