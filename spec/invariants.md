# Invariants

- Public export **only** via `lib/lemsa_nav_kit.dart`.
- Controllers call `PageNavigator` only â€” never raw `Navigator`, `context.router`, or GetAppContext.
- Sign-out performs **no** navigation. Session changes; `GuardReevaluate` re-runs `AuthGuard`.
- Guards never import an app or lab `sessionProvider`. The app passes `isSignedIn` or `AuthSession`.
- Route args are typed classes (`@RoutePage` constructor params), not `Map<String, dynamic>`.
- `push` accepts auto_route `PageRouteInfo` (generated `*Route`). Other types throw.
- Empty `catch` is banned (`empty_catches: error`).
- No PageData, Notices impl, Dio, or auth SDKs in this package.
