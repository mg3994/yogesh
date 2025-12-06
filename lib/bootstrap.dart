import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'core/router/app_router.dart';

import 'core/core.dart' show AppTheme;

Future<void> runAppAsync(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(await builder());
}

class Bootstrap extends StatefulWidget {
  const Bootstrap({super.key});

  @override
  State<Bootstrap> createState() => _BootstrapState();
}

class _BootstrapState extends State<Bootstrap> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: kDebugMode,
      restorationScopeId: 'app',
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)?.appTitle ?? "Yogesh",
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouter.router,
    );
  }
}
