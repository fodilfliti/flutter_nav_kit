/// Pure guard decision — unit-testable without auto_route.
final class GuardVerdict {
  const GuardVerdict.allow() : redirectPath = null;

  const GuardVerdict.redirect(this.redirectPath);

  final String? redirectPath;

  bool get isAllow => redirectPath == null;
}

/// Default signed-out landing.
const defaultSignedOutPath = '/login';

/// Default signed-in landing.
const defaultSignedInPath = '/home';

GuardVerdict decideAuth({
  required bool signedIn,
  String signedOutPath = defaultSignedOutPath,
}) {
  if (signedIn) {
    return const GuardVerdict.allow();
  }
  return GuardVerdict.redirect(signedOutPath);
}

GuardVerdict decideGuest({
  required bool signedIn,
  String signedInPath = defaultSignedInPath,
}) {
  if (signedIn) {
    return GuardVerdict.redirect(signedInPath);
  }
  return const GuardVerdict.allow();
}
