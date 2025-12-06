import 'package:flutter/material.dart';

import 'bootstrap.dart' show Bootstrap, runAppAsync;

import 'dart:async';

void main() {
 return  runZonedGuarded<void>(
    () {
      runAppAsync(() async {
        return const Bootstrap();
      });
    },
    (error, stack) {
      // This is where you would typically log the error to a crash reporting service
      // e.g., FirebaseCrashlytics.recordError(error, stack);
      debugPrint('Caught error in main zone: $error');
      debugPrint('Stack trace: $stack');
    },
  );
}
