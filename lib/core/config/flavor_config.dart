import 'package:flutter/foundation.dart';

/// Extension on String to convert to Flavor enum.
extension FlavorX on String {
  Flavor toFlavor() => Flavor.values.firstWhere(
    (e) => e.name == toLowerCase(),
    orElse: () => Flavor.production,
  );
}

enum Flavor {
  // set them in alphabetical order with full name
  development,
  production,
  staging;

  /// Returns the name of the flavor in lowercase.
  static Flavor fromString(String? value) {
    return Flavor.values.firstWhere(
      (e) => e.name == value?.toLowerCase(),
      orElse: () => Flavor.production,
    );
  }
}

abstract interface class FlavorConfig {
  const FlavorConfig._(this.baseUrl, this.flavor);

  final String baseUrl;
  final Flavor flavor;

  factory FlavorConfig({String? flavorName}) {
    final flavor = Flavor.fromString(flavorName);
    switch (flavor) {
      case Flavor.development:
        return const _DevCfg();
      case Flavor.production:
        return const _ProdCfg();
      case Flavor.staging:
        return const _StgCfg();
    }
  }

  static BuildMode get buildMode => BuildMode.current;
}

class _DevCfg extends FlavorConfig {
  const _DevCfg()
    : super._('https://api.dev.yourdomain.com', Flavor.development);
}

class _ProdCfg extends FlavorConfig {
  const _ProdCfg()
    : super._('https://api.prod.yourdomain.com', Flavor.production);
}

class _StgCfg extends FlavorConfig {
  const _StgCfg() : super._('https://api.stg.yourdomain.com', Flavor.staging);
}

enum BuildMode {
  debug,
  profile,
  release;

  static BuildMode get current {
    if (kDebugMode) return BuildMode.debug;
    if (kProfileMode) return BuildMode.profile;
    if (kReleaseMode) return BuildMode.release;
    throw UnimplementedError(
      'Unknown build mode'
      ' - kDebugMode: $kDebugMode, '
      'kProfileMode: $kProfileMode, '
      'kReleaseMode: $kReleaseMode',
    );
  }
}
