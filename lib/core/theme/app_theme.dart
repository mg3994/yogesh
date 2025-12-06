import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'brand_theme.dart' show BrandTheme;

/// Central theme configuration for the app.
abstract final class AppTheme {
  // Private constructor to prevent instantiation.
  const AppTheme._();

  // Default fallback scheme.
  static const FlexScheme _defaultScheme = FlexScheme.material;

  /// Helper to get the primary brand color based on brightness and optional custom scheme.
  static Color _getPrimaryColor({
    required Brightness brightness,
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) {
    if (flexSchemeEnum == FlexScheme.custom) {
      return flexSchemeColor?.primary ??
          _defaultScheme.colors(brightness).primary;
    }
    return (flexSchemeEnum ?? _defaultScheme).colors(brightness).primary;
  }

  /// ⚙️ Core theme builder logic for both light and dark modes.
  static ThemeData _buildTheme({
    required Brightness brightness,
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) {
    // 1. Determine if this is a dark theme for text theme calculation
    final bool isDark = brightness == Brightness.dark;

    // 2. Define the base ThemeData creator (FlexThemeData.light or FlexThemeData.dark)
    final themeDataFactory = isDark ? FlexThemeData.dark : FlexThemeData.light;
    
    // 3. Get the theme from the default Material ThemeData for context-aware text themes
    final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();

    return themeDataFactory(
      colors: (flexSchemeEnum == FlexScheme.custom) ? flexSchemeColor : null,
      scheme: (flexSchemeEnum != FlexScheme.custom) ? flexSchemeEnum : null,
      subThemesData:  FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        // Only blend colors in dark mode for better contrast/visuals
        blendOnColors: isDark, 
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),

      // 4. Apply premium font using Google Fonts
      // Pass the base theme's text theme to GoogleFonts to merge and ensure
      // colors/styles match the current brightness (dark or light).
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
      primaryTextTheme: GoogleFonts.interTextTheme(baseTheme.primaryTextTheme),
      
      // 5. Add custom extension
      extensions: <BrandTheme>[
        BrandTheme(
          isDarkThemeMode: isDark,
          brandColor: _getPrimaryColor(
            brightness: brightness,
            flexSchemeColor: flexSchemeColor,
            flexSchemeEnum: flexSchemeEnum,
          ),
        ),
      ],
    );
  }

  /// 💡 Light theme data (Delegates to the builder).
  static ThemeData light({
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) {
    return _buildTheme(
      brightness: Brightness.light,
      flexSchemeColor: flexSchemeColor,
      flexSchemeEnum: flexSchemeEnum,
    );
  }

  /// 🌙 Dark theme data (Delegates to the builder).
  static ThemeData dark({
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) {
    return _buildTheme(
      brightness: Brightness.dark,
      flexSchemeColor: flexSchemeColor,
      flexSchemeEnum: flexSchemeEnum,
    );
  }
}
