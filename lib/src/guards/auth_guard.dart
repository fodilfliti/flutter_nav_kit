import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_nav_kit/src/guards/guard_verdict.dart';
import 'package:flutter_nav_kit/src/session/auth_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;

/// Blocks unsigned users. Redirect path defaults to `/login`.
///
/// Pass [isSignedIn] from the app (do not hardcode a provider name):
///
/// ```dart
/// AuthGuard(isSignedIn: () => ref.read(sessionProvider) != null)
/// ```
final class AuthGuard extends AutoRouteGuard {
  AuthGuard({
    required this.isSignedIn,
    this.signedOutPath = defaultSignedOutPath,
  });

  /// Reads an app-owned `AuthSession?` provider.
  factory AuthGuard.fromRef(
    Ref ref, {
    required ProviderListenable<AuthSession?> session,
    String signedOutPath = defaultSignedOutPath,
  }) {
    return AuthGuard(
      isSignedIn: () => isSignedInSession(ref.read(session)),
      signedOutPath: signedOutPath,
    );
  }

  final bool Function() isSignedIn;
  final String signedOutPath;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final verdict = decideAuth(
      signedIn: isSignedIn(),
      signedOutPath: signedOutPath,
    );
    if (verdict.isAllow) {
      resolver.next();
      return;
    }
    resolver.next(false);
    unawaited(router.replacePath(verdict.redirectPath!));
  }
}
