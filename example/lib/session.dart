import 'package:lemsa_nav_kit/lemsa_nav_kit.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noticesProvider = Provider<Notices>(
  (ref) => throw UnimplementedError('overridden in main'),
);

final class ExampleSession implements AuthSession {
  const ExampleSession({required this.email});

  final String email;

  @override
  bool get isSignedIn => true;
}

class SessionNotifier extends Notifier<ExampleSession?> {
  @override
  ExampleSession? build() => null;

  void signIn(String email) {
    state = ExampleSession(email: email.trim());
  }

  /// Session only â€” no navigation (AuthGuard redirects).
  void signOut() {
    state = null;
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, ExampleSession?>(
  SessionNotifier.new,
);
