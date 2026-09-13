# Agent instructions â€” Flutter Nav Kit

This is a **Flutter package** (`lemsa_nav_kit`), not an application.

## Load context

1. Read `spec/README.md`, then `package.md` / `invariants.md` / `decisions.md`.
2. Use **code** under `lib/` as implementation truth.
3. Do **not** ingest `README.md` as working memory.

## Working rules

- Keep the public barrel (`lib/lemsa_nav_kit.dart`) the only public API.
- `AutoPageNavigator` implements `PageNavigator` from `flutter_page_kit`.
- Guards read an **app-owned** session (`isSignedIn` / `AuthSession`). Do not import lab or app provider names.
- Sign-out is a session state change only. Guards redirect. Controllers must not `nav` on sign-out.
- Route args are typed `@RoutePage` constructor params, not `Map<String, dynamic>`.
- No dio / supabase / firebase_* / drift in `lib/`.
- Empty catches are analyzer errors.
- After behavior changes: update `spec/` (and `CHANGELOG.md` when user-visible). Update `skills/flutter-nav-kit/` for public API changes.

## Flutter SDK

Pinned in `.fvmrc` to **3.35.7**. Use `fvm flutter` / `fvm dart`. Never run `flutter upgrade` / `flutter channel` on `C:\Users\lemsa\Documents\flutter`. Package constraints: Dart `^3.7.2`, Flutter `>=3.29.0`.

## Out of scope unless asked

Publishing to pub.dev, wrapping `auto_route_generator` as `dart run lemsa_nav_kit:gen`, migrating lab / reference apps.
