import 'package:flutter/foundation.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthService {
  static final instance = AuthService._();

  final _isAuthenticated = signal(false);
  final _selectedRoles = signal<List<String>>([]);

  bool get isAuthenticated => _isAuthenticated.value;
  List<String> get selectedRoles => _selectedRoles.value;

  // Bridge signal to Listenable for GoRouter
  late final ValueNotifier<bool> authListenable = ValueNotifier(false);

  AuthService._() {
    effect(() {
      authListenable.value = _isAuthenticated.value;
    });
  }

  void toggleRole(String role) {
    final currentRoles = List<String>.from(_selectedRoles.value);
    if (currentRoles.contains(role)) {
      currentRoles.remove(role);
    } else {
      currentRoles.add(role);
    }
    _selectedRoles.value = currentRoles;
  }

  void login() {
    if (_selectedRoles.value.isNotEmpty) {
      _isAuthenticated.value = true;
    }
  }

  void logout() {
    _isAuthenticated.value = false;
    _selectedRoles.value = [];
  }
}
