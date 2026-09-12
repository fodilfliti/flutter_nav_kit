/// App-owned signed-in snapshot. The kit never names your provider.
///
/// Typical provider: `NotifierProvider<..., AppSession?>` where `null`
/// means signed out. Async sessions unwrap with `valueOrNull` in the
/// guard callback — do not pass `AsyncValue` into [isSignedInSession].
abstract interface class AuthSession {
  bool get isSignedIn;
}

/// `null` or `isSignedIn == false` → signed out.
bool isSignedInSession(AuthSession? session) => session?.isSignedIn ?? false;
