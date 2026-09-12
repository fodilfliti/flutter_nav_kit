import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nav_kit/flutter_nav_kit.dart';
import 'package:flutter_nav_kit_example/router/app_router.dart';
import 'package:flutter_nav_kit_example/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final nav = AutoPageNavigator(context.router);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home · ${session?.email ?? ''}'),
        actions: [
          TextButton(
            onPressed: () => ref.read(sessionProvider.notifier).signOut(),
            child: const Text('Sign out'),
          ),
        ],
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            nav.push<void>(NoteFormRoute());
          },
          child: const Text('Add note'),
        ),
      ),
    );
  }
}
