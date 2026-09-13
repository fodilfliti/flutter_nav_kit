# lemsa_nav_kit

[![pub package](https://img.shields.io/pub/v/lemsa_nav_kit.svg)](https://pub.dev/packages/lemsa_nav_kit)

`PageNavigator` over auto_route, session guards, and a deep-link table.

**Platforms:** Android, iOS, Linux, macOS, Web, Windows  
**Requires:** Flutter `>=3.44.0`

## Install

```yaml
dependencies:
  lemsa_nav_kit: ^1.0.0
  flutter_page_kit: ^1.0.0
  lemsa_core_kit: ^1.0.0
  auto_route: ^11.1.0
  flutter_riverpod: ^3.4.2
```

```dart
import 'package:lemsa_nav_kit/lemsa_nav_kit.dart';
```

## Owns

- `AutoPageNavigator` — `nav.push` / `pop` / `replaceAll` / …
- `AuthGuard` / `GuestGuard` — app-owned session
- `GuardReevaluate` — session change re-runs guards (sign-out does **not** navigate)
- `DeepLinkTable` — URI path → typed route

## Agent skill

```bash
npx skills add fodilfliti/flutter_nav_kit
# or: npx skills add fodilfliti/lemsa-skills
```

## Links

- [GitHub](https://github.com/fodilfliti/flutter_nav_kit)
- [Lemsa skills](https://github.com/fodilfliti/lemsa-skills)
