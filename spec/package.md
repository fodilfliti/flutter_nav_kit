# flutter_nav_kit

`PageNavigator` over auto_route, session guards, and a pragmatic deep-link table.

## Layers

| Layer | Path | Role |
| --- | --- | --- |
| Barrel | `lib/flutter_nav_kit.dart` | Only public export |
| Navigator | `lib/src/navigator/` | `AutoPageNavigator` |
| Session | `lib/src/session/` | `AuthSession`, `isSignedInSession` |
| Guards | `lib/src/guards/` | `AuthGuard`, `GuestGuard`, `GuardVerdict`, `GuardReevaluate` |
| Deep links | `lib/src/deep_link/` | `DeepLinkTable` / `DeepLinkEntry` |

## Public API

- `AutoPageNavigator`
- `AuthSession`, `isSignedInSession`
- `AuthGuard`, `GuestGuard`, `GuardVerdict`, `decideAuth`, `decideGuest`
- `GuardReevaluate`
- `DeepLinkTable`, `DeepLinkEntry`

## Depends on

`lemsa_core_kit`, `flutter_page_kit` (`PageNavigator`), `auto_route`, `flutter_riverpod` (optional `fromRef` factories).

## Must not depend on

`dio`, `supabase_flutter`, `firebase_*`, `drift`, `slang`. Do not redefine `PageNavigator`, `PageData`, or `Notices`.
