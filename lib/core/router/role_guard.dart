import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/application/auth_service.dart';
import '../../features/auth/domain/models/user_model.dart';

class RoleGuard {
  final UserRole requiredRole;
  final String fallbackRoute;

  const RoleGuard({
    required this.requiredRole,
    this.fallbackRoute = '/', // Default redirect to home/dashboard if unauthorized
  });

  FutureOr<String?> call(BuildContext context, GoRouterState state) {
    if (!AuthService.instance.hasRole(requiredRole)) {
      return fallbackRoute;
    }
    return null;
  }
}
