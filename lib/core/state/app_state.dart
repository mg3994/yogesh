import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  AppState._();
  static final AppState instance = AppState._();

  // Signals
  final themeMode = signal<ThemeMode>(ThemeMode.system);
  final flexScheme = signal<FlexScheme>(FlexScheme.materialBaseline);
  final customFlexSchemeColor = signal<FlexSchemeColor?>(null);
  final locale = signal<Locale>(const Locale('en'));
  final fontFamily = signal<String>('Inter');

  // Persistence Key Constants
  static const _kThemeModeKey = 'theme_mode';
  static const _kFlexSchemeKey = 'flex_scheme';
  static const _kCustomSchemeColorKey = 'custom_scheme_color';
  static const _kLocaleKey = 'locale';
  static const _kFontFamilyKey = 'font_family';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    // Load ThemeMode
    final themeModeIndex = prefs.getInt(_kThemeModeKey);
    if (themeModeIndex != null) {
      themeMode.value = ThemeMode.values[themeModeIndex];
    }

    // Load FlexScheme
    final flexSchemeIndex = prefs.getInt(_kFlexSchemeKey);
    if (flexSchemeIndex != null) {
      flexScheme.value = FlexScheme.values[flexSchemeIndex];
    }

    // Load Custom FlexSchemeColor
    final customColorJson = prefs.getString(_kCustomSchemeColorKey);
    if (customColorJson != null) {
      try {
        // Simple serialization: we just stored primary, secondary, etc as a comma user string or similar
        // For robustness, let's assume we stored it as comma separated int values of standard colors
        // primary, primaryContainer, secondary, secondaryContainer, tertiary, tertiaryContainer, error
        final parts = customColorJson.split(',');
        if (parts.length >= 7) {
          customFlexSchemeColor.value = FlexSchemeColor(
            primary: Color(int.parse(parts[0])),
            primaryContainer: Color(int.parse(parts[1])),
            secondary: Color(int.parse(parts[2])),
            secondaryContainer: Color(int.parse(parts[3])),
            tertiary: Color(int.parse(parts[4])),
            tertiaryContainer: Color(int.parse(parts[5])),
            error: Color(int.parse(parts[6])),
          );
        }
      } catch (e) {
        debugPrint('Failed to load custom scheme color: $e');
      }
    }

    // Load Locale
    final localeTag = prefs.getString(_kLocaleKey);
    if (localeTag != null) {
      locale.value = Locale(localeTag);
    }

    // Load Font Family
    final fontFamilyName = prefs.getString(_kFontFamilyKey);
    if (fontFamilyName != null) {
      fontFamily.value = fontFamilyName;
    }
  }

  // Actions
  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    _saveThemeMode(mode);
  }

  void setFlexScheme(FlexScheme scheme) {
    flexScheme.value = scheme;
    _saveFlexScheme(scheme);
  }

  void setCustomFlexSchemeColor(FlexSchemeColor? color) {
    customFlexSchemeColor.value = color;
    _saveCustomFlexSchemeColor(color);
  }

  void setLocale(Locale loc) {
    locale.value = loc;
    _saveLocale(loc);
  }

  void setFontFamily(String family) {
    fontFamily.value = family;
    _saveFontFamily(family);
  }

  // Persistence Helpers
  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kThemeModeKey, mode.index);
  }

  Future<void> _saveFlexScheme(FlexScheme scheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kFlexSchemeKey, scheme.index);
  }

  Future<void> _saveCustomFlexSchemeColor(FlexSchemeColor? color) async {
    final prefs = await SharedPreferences.getInstance();
    if (color == null) {
      await prefs.remove(_kCustomSchemeColorKey);
      return;
    }
    // Serialize to CSV string of ints
    final serialized = [
      color.primary.value,
      color.primaryContainer.value,
      color.secondary.value,
      color.secondaryContainer.value,
      color.tertiary.value,
      color.tertiaryContainer.value,
      color.error?.value ??
          0, // Handle error color potential null or defaulting
    ].join(',');
    await prefs.setString(_kCustomSchemeColorKey, serialized);
  }

  Future<void> _saveLocale(Locale loc) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLocaleKey, loc.languageCode);
  }

  Future<void> _saveFontFamily(String family) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kFontFamilyKey, family);
  }
}
