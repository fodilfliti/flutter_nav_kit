# Decisions

## D1 — Guards take `isSignedIn`, not a hardcoded provider

**Choice:** `AuthGuard` / `GuestGuard` receive `bool Function() isSignedIn`. Optional `AuthGuard.fromRef(ref, session: appOwnedProvider)` reads an app `ProviderListenable<AuthSession?>`.

**Why:** Session lives in the app (Supabase stream, Firebase, mock). Hardcoding `sessionProvider` would couple the kit to one name and one AsyncValue shape.

**Do not:** Import lab or consumer provider files from `lib/`.

## D2 — Redirect by path, not generated `LoginRoute`

**Choice:** Default redirect paths `/login` and `/home`, overridable. Implementation uses `resolver.next(false)` + `replaceNamed`.

**Why:** Generated route types belong to the app. The kit cannot import `LoginRoute`.

## D3 — `dart run flutter_nav_kit:gen` deferred

**Choice:** v1 documents `dart run build_runner build --delete-conflicting-outputs` with `auto_route_generator`. No kit CLI yet.

**Why:** Wrapping the generator is sugar; the example already needs codegen. Ship navigator + guards first.

## D4 — Riverpod 2.x to match `flutter_page_kit`

**Choice:** `flutter_riverpod: ^2.6.1`, same as unpublished page_kit. Family floor is 3.4.2; bump in lockstep with page_kit.

**Why:** A 3.x nav_kit against a 2.x page_kit fails pub solve.

## D5 — Deep links are path patterns, not a kiwash entity catalog

**Choice:** `DeepLinkTable` matches `/path/:param` and calls an app `toRoute` builder that returns a typed `PageRouteInfo`.

**Why:** Full kiwash parity is out of scope. Two or three known URIs prove the table.

## D6 — `replaceNamed` calls auto_route 11 `replacePath`

**Choice:** Keep `PageNavigator.replaceNamed` (page_kit contract). Implementation uses `StackRouter.replacePath`.

**Why:** auto_route 11 removed `replaceNamed`. Controllers still call the page_kit name.

## D7 — `auto_route_generator` 10.5.x on Dart 3.9

**Choice:** Example uses `auto_route_generator: ^10.5.0`, not 10.6.0.

**Why:** 10.6.0 needs Dart `>=3.12` (`lean_builder`). FVM 3.35.7 is Dart 3.9.2. Runtime `auto_route` stays 11.1.0.
