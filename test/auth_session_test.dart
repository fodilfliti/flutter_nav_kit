import 'package:lemsa_nav_kit/lemsa_nav_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('null session is signed out', () {
    expect(isSignedInSession(null), isFalse);
  });

  test('isSignedIn false is signed out', () {
    expect(isSignedInSession(const _Session(isSignedIn: false)), isFalse);
  });

  test('isSignedIn true is signed in', () {
    expect(isSignedInSession(const _Session(isSignedIn: true)), isTrue);
  });
}

final class _Session implements AuthSession {
  const _Session({required this.isSignedIn});

  @override
  final bool isSignedIn;
}
