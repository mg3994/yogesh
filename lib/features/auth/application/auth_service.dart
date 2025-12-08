import 'package:flutter/foundation.dart';
import 'package:signals/signals_flutter.dart';
import '../domain/models/user_model.dart';

class AuthService {
  static final instance = AuthService._();

  final _isAuthenticated = signal(false);
  final _currentUser = signal<User?>(null);

  bool get isAuthenticated => _isAuthenticated.value;
  User? get currentUser => _currentUser.value;
  List<UserRole> get userRoles => _currentUser.value?.roles ?? [];

  // Bridge signal to Listenable for GoRouter
  late final ValueNotifier<bool> authListenable = ValueNotifier(false);

  AuthService._() {
    effect(() {
      authListenable.value = _isAuthenticated.value;
    });
  }

  bool hasRole(UserRole role) {
    return _currentUser.value?.hasRole(role) ?? false;
  }

  void toggleRole(UserRole role) {
    final user = _currentUser.value;
    if (user == null) return;

    final currentRoles = List<UserRole>.from(user.roles);
    if (currentRoles.contains(role)) {
      currentRoles.remove(role);
    } else {
      currentRoles.add(role);
    }

    _currentUser.value = user.copyWith(roles: currentRoles);
  }

  void login() {
    // Mock login - in efficient app this would come from API/Storage
    _currentUser.value = const User(
      id: '1',
      email: 'user@example.com',
      name: 'Test User',
      roles: [UserRole.client],
    );
    _isAuthenticated.value = true;
  }

  void logout() {
    _isAuthenticated.value = false;
    _currentUser.value = null;
  }
}
