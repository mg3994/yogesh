import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signals/signals_flutter.dart';

import 'core/core.dart' show AppTheme;
import 'core/router/app_router.dart';
import 'core/state/app_state.dart';
import 'l10n/app_localizations.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppState.instance.init();

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(const Bootstrap());
}

class Bootstrap extends StatefulWidget {
  const Bootstrap({super.key});

  @override
  State<Bootstrap> createState() => _BootstrapState();
}

class _BootstrapState extends State<Bootstrap> {
  @override
  Widget build(BuildContext context) {
    final appState = AppState.instance;
    final themeMode = appState.themeMode.watch(context);
    final flexScheme = appState.flexScheme.watch(context);
    final customFlexSchemeColor = appState.customFlexSchemeColor.watch(context);
    final locale = appState.locale.watch(context);
    final fontFamily = appState.fontFamily.watch(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: kDebugMode,
      restorationScopeId: 'app',
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)?.appTitle ?? "Yogesh",

      theme: AppTheme.light(
        flexSchemeEnum: flexScheme,
        flexSchemeColor: customFlexSchemeColor,
        fontTextThemeBuilder: _getFontBuilder(fontFamily),
      ),
      darkTheme: AppTheme.dark(
        flexSchemeEnum: flexScheme,
        flexSchemeColor: customFlexSchemeColor,
        fontTextThemeBuilder: _getFontBuilder(fontFamily),
      ),
      themeMode: themeMode,

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,

      routerConfig: AppRouter.router,
    );
  }

  TextTheme Function(TextTheme) _getFontBuilder(String fontFamily) {
    return (textTheme) => GoogleFonts.getTextTheme(fontFamily, textTheme);
  }
}
