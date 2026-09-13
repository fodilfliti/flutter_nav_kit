import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:lemsa_nav_kit/src/guards/guard_verdict.dart';
import 'package:lemsa_nav_kit/src/session/auth_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;

/// Login-only. Signed-in users redirect to `/home` by default.
final class GuestGuard extends AutoRouteGuard {
  GuestGuard({
    required this.isSignedIn,
    this.signedInPath = defaultSignedInPath,
  });

  factory GuestGuard.fromRef(
    Ref ref, {
    required ProviderListenable<AuthSession?> session,
    String signedInPath = defaultSignedInPath,
  }) {
    return GuestGuard(
      isSignedIn: () => isSignedInSession(ref.read(session)),
      signedInPath: signedInPath,
    );
  }

  final bool Function() isSignedIn;
  final String signedInPath;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final verdict = decideGuest(
      signedIn: isSignedIn(),
      signedInPath: signedInPath,
    );
    if (verdict.isAllow) {
      resolver.next();
      return;
    }
    resolver.next(false);
    unawaited(router.replacePath(verdict.redirectPath!));
  }
}
