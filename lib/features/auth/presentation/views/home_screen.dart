import 'package:flutter/material.dart';
import 'package:yogesh/l10n/app_localizations.dart';
import '../../application/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n!.appTitle),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement actual login
                // For now, mock login for testing router
                AuthService.instance.login();
              },
              child: const Text('Login (Mock)'),
            ),
          ],
        ),
      ),
    );
  }
}
