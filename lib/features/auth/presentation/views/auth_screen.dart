import 'package:flutter/material.dart';
import 'package:yogesh/l10n/app_localizations.dart';
import '../../application/auth_service.dart';

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
    final selectedRoles = AuthService.instance.selectedRoles;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n!.authHeader,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Select your role(s) to continue',
                style: theme.textTheme.bodyLarge,
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
                    isSelected: selectedRoles.contains('Client'),
                    onSelected: () => setState(() {
                      AuthService.instance.toggleRole('Client');
                    }),
                  ),
                  _RoleChip(
                    label: 'Contractor',
                    icon: Icons.engineering_outlined,
                    isSelected: selectedRoles.contains('Contractor'),
                    onSelected: () => setState(() {
                      AuthService.instance.toggleRole('Contractor');
                    }),
                  ),
                  _RoleChip(
                    label: 'Supplier',
                    icon: Icons.inventory_2_outlined,
                    isSelected: selectedRoles.contains('Supplier'),
                    onSelected: () => setState(() {
                      AuthService.instance.toggleRole('Supplier');
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: selectedRoles.isNotEmpty
                      ? () {
                          AuthService.instance.login();
                        }
                      : null,
                  child: Text(l10n.continueButton),
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
