import 'package:flutter/foundation.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthService {
  static final instance = AuthService._();

  final _isAuthenticated = signal(false);

  bool get isAuthenticated => _isAuthenticated.value;

  // Bridge signal to Listenable for GoRouter
  late final ValueNotifier<bool> authListenable = ValueNotifier(false);

  AuthService._() {
    effect(() {
      authListenable.value = _isAuthenticated.value;
    });
  }

  void login() {
    _isAuthenticated.value = true;
  }

  void logout() {
    _isAuthenticated.value = false;
  }
}
