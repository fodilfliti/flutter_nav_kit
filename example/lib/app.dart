import 'package:flutter/material.dart';
import 'package:lemsa_nav_kit/lemsa_nav_kit.dart';
import 'package:flutter_nav_kit_example/router/app_router.dart';
import 'package:flutter_nav_kit_example/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExampleApp extends ConsumerStatefulWidget {
  const ExampleApp({required this.messengerKey, super.key});

  final GlobalKey<ScaffoldMessengerState> messengerKey;

  @override
  ConsumerState<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends ConsumerState<ExampleApp> {
  late final AppRouter _router;
  final GuardReevaluate _reevaluate = GuardReevaluate();

  @override
  void initState() {
    super.initState();
    _router = AppRouter(
      isSignedIn: () => isSignedInSession(ref.read(sessionProvider)),
    );
  }

  @override
  void dispose() {
    _reevaluate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(sessionProvider, (previous, next) {
      if (previous != next) {
        _reevaluate.notify();
      }
    });
    return MaterialApp.router(
      scaffoldMessengerKey: widget.messengerKey,
      routerConfig: _router.config(reevaluateListenable: _reevaluate),
    );
  }
}
