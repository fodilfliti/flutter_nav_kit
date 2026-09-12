---
name: flutter-nav-kit
description: >
  Use flutter_nav_kit for AutoPageNavigator, AuthGuard, GuestGuard,
  GuardReevaluate, and DeepLinkTable over auto_route. Activate for typed
  routes, session guards, deep links, and replacing Navigator.push or
  GoScreen — not for PageData, FormPage, Notices, Dio, or auth SDKs.
license: MIT
metadata:
  author: fodilfliti
  version: "0.0.1"
  homepage: https://pub.dev/packages/flutter_nav_kit
---

# flutter_nav_kit (consumer)

## When to import

```dart
import 'package:flutter_nav_kit/flutter_nav_kit.dart';
```

Use this package for:

- `AutoPageNavigator` as the `PageNavigator` impl
- `AuthGuard` / `GuestGuard` on auto_route
- `GuardReevaluate` so sign-out redirects without `nav`
- `DeepLinkTable` URI → typed route

## PageNavigator

Controllers call `nav.push<R>(AddNoteRoute())`, `nav.pop(saved)`, `nav.replaceAll`, `nav.replaceNamed`. Never `Navigator` or `context.router` inside a mixin.

Pages (the bridge) supply:

```dart
@override
PageNavigator get nav => AutoPageNavigator(context.router);
```

Or `ref.read(navigatorProvider)` when the app overrides it with the router instance.

## Session contract

The kit does **not** own `sessionProvider`. Your session type should look like:

```dart
final class AppSession implements AuthSession {
  const AppSession({required this.userId});
  final String userId;
  @override
  bool get isSignedIn => true; // null in the provider = signed out
}

final sessionProvider =
    NotifierProvider<SessionNotifier, AppSession?>(SessionNotifier.new);
```

If the provider is `AsyncValue<AppSession>`, unwrap in the callback:

```dart
isSignedIn: () =>
    ref.read(sessionProvider).valueOrNull?.isSignedIn ?? false,
```

`null` session → signed out. `AuthSession.isSignedIn == false` → signed out.

## Guards

```dart
AppRouter({required this.isSignedIn});

@override
List<AutoRoute> get routes => [
  AutoRoute(
    page: LoginRoute.page,
    path: '/login',
    initial: true,
    guards: [GuestGuard(isSignedIn: isSignedIn)],
  ),
  AutoRoute(
    page: HomeRoute.page,
    path: '/home',
    guards: [AuthGuard(isSignedIn: isSignedIn)],
  ),
];
```

Pass `router.config(reevaluateListenable: reevaluate)` and `ref.listen(sessionProvider, (_, __) => reevaluate.notify())`.

**Sign-out:** set session to null (and `deleteUserData` from app_kit). Do **not** `nav.replaceNamed('/login')`.

**Sign-in:** set session. GuestGuard sends the user to `/home` on reevaluate.

## Deep links

```dart
final links = DeepLinkTable([
  DeepLinkEntry(path: '/home', toRoute: (_, __) => const HomeRoute()),
  DeepLinkEntry(
    path: '/notes/:id',
    toRoute: (params, _) => NoteFormRoute(noteId: params['id']),
  ),
]);
final route = links.resolve(Uri.parse('https://app.example/notes/42'));
if (route != null) await nav.push(route);
```

## Codegen

```bash
dart run build_runner build --delete-conflicting-outputs
```

`dart run flutter_nav_kit:gen` is not shipped in v1.

## Do not put here

| Concern | Where |
| --- | --- |
| `PageData` / `FormPage` / `Notices` | `flutter_page_kit` |
| Material snackbars / bootstrap | `flutter_app_kit` |
| EmailField | `flutter_input_kit` |
| Dio / Supabase / Firebase auth | `flutter_data_kit_*` / the app |
