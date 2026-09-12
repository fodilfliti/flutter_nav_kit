# flutter_nav_kit

`PageNavigator` over auto_route, session guards, and a deep-link table. Depends on [`flutter_page_kit`](../flutter_page_kit) and [`lemsa_core_kit`](../lemsa_core_kit).

## Install

Path dependency while unpublished:

```yaml
dependencies:
  flutter_nav_kit:
    path: ../flutter_nav_kit
  flutter_page_kit:
    path: ../flutter_page_kit
  lemsa_core_kit:
    path: ../lemsa_core_kit
  auto_route: ^11.1.0
  flutter_riverpod: ^2.6.1
```

```dart
import 'package:flutter_nav_kit/flutter_nav_kit.dart';
```

## Owns

- `AutoPageNavigator` — controllers call `nav.push` / `pop` / `replaceAll` / `replaceNamed`
- `AuthGuard` / `GuestGuard` — app-owned `isSignedIn` (or `AuthSession`)
- `GuardReevaluate` — session change re-runs guards (sign-out does **not** navigate)
- `DeepLinkTable` — URI path → typed route

## Does not own

`PageData` / `FormPage` / `Notices` (`flutter_page_kit`), bootstrap / Material snackbars (`flutter_app_kit`), Dio/Supabase auth SDKs (session is app-owned).
