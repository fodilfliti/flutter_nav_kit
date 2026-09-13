import 'package:lemsa_nav_kit/lemsa_nav_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('decideAuth', () {
    test('allows when signed in', () {
      final verdict = decideAuth(signedIn: true);
      expect(verdict.isAllow, isTrue);
      expect(verdict.redirectPath, isNull);
    });

    test('redirects to /login when signed out', () {
      final verdict = decideAuth(signedIn: false);
      expect(verdict.isAllow, isFalse);
      expect(verdict.redirectPath, '/login');
    });
  });

  group('decideGuest', () {
    test('allows guests', () {
      expect(decideGuest(signedIn: false).isAllow, isTrue);
    });

    test('redirects signed-in users to /home', () {
      final verdict = decideGuest(signedIn: true);
      expect(verdict.redirectPath, '/home');
    });
  });
}
