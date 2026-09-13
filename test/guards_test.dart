import 'package:auto_route/auto_route.dart';
import 'package:lemsa_nav_kit/lemsa_nav_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AuthGuard redirects when session signed out', () {
    final resolver = _FakeResolver();
    final router = _FakeRouter();
    final guard = AuthGuard(isSignedIn: () => false);

    guard.onNavigation(resolver, router);

    expect(resolver.continued, isFalse);
    expect(router.replacedPath, ['/login']);
  });

  test('AuthGuard allows when signed in', () {
    final resolver = _FakeResolver();
    final router = _FakeRouter();
    final guard = AuthGuard(isSignedIn: () => true);

    guard.onNavigation(resolver, router);

    expect(resolver.continued, isTrue);
    expect(router.replacedPath, isEmpty);
  });

  test('GuestGuard redirects signed-in user to /home', () {
    final resolver = _FakeResolver();
    final router = _FakeRouter();
    final guard = GuestGuard(isSignedIn: () => true);

    guard.onNavigation(resolver, router);

    expect(resolver.continued, isFalse);
    expect(router.replacedPath, ['/home']);
  });

  test('GuestGuard allows signed-out user', () {
    final resolver = _FakeResolver();
    final router = _FakeRouter();
    final guard = GuestGuard(isSignedIn: () => false);

    guard.onNavigation(resolver, router);

    expect(resolver.continued, isTrue);
    expect(router.replacedPath, isEmpty);
  });
}

class _FakeResolver extends Fake implements NavigationResolver {
  bool? continued;

  @override
  void next([bool continueNavigation = true]) {
    continued = continueNavigation;
  }
}

class _FakeRouter extends Fake implements StackRouter {
  final replacedPath = <String>[];

  @override
  Future<T?> replacePath<T extends Object?>(
    String path, {
    bool includePrefixMatches = false,
    OnNavigationFailure? onFailure,
  }) async {
    replacedPath.add(path);
    return null;
  }
}
