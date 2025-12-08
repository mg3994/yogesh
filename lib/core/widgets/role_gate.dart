import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import '../../features/auth/application/auth_service.dart';
import '../../features/auth/domain/models/user_model.dart';

class RoleGate extends StatelessWidget {
  final UserRole requiredRole;
  final Widget child;
  final Widget? fallback;

  const RoleGate({
    super.key,
    required this.requiredRole,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final hasRole = AuthService.instance.hasRole(requiredRole);

      if (hasRole) {
        return child;
      }

      return fallback ?? const SizedBox.shrink();
    });
  }
}
