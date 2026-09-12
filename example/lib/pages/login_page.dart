import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nav_kit_example/session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController(text: 'dev@example.invalid');

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                ref.read(sessionProvider.notifier).signIn(_email.text);
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
