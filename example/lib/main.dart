import 'package:flutter/material.dart';
import 'package:flutter_app_kit/flutter_app_kit.dart';
import 'package:flutter_nav_kit_example/app.dart';
import 'package:flutter_nav_kit_example/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lemsa_core_kit/lemsa_core_kit.dart';

Future<void> main() async {
  final boot = await bootstrap(
    const AppConfig(
      flavor: AppFlavor.dev,
      loadEnv: false,
      failureText: exampleFailureText,
    ),
  );

  runApp(
    ProviderScope(
      overrides: [
        noticesProvider.overrideWithValue(boot.notices),
      ],
      child: ExampleApp(messengerKey: boot.messengerKey),
    ),
  );
}

String exampleFailureText(AppFailure failure) {
  return switch (failure) {
    NetworkFailure() => 'Network error',
    CancelledFailure() => '',
    _ => 'Something went wrong',
  };
}
