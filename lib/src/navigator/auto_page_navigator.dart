import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart';

/// [PageNavigator] over an auto_route [StackRouter].
///
/// Controllers receive this type (or [PageNavigator]) and never import
/// auto_route or call Flutter `Navigator` directly.
final class AutoPageNavigator implements PageNavigator {
  AutoPageNavigator(this._router);

  final StackRouter _router;

  @override
  bool get canPop => _router.canPop();

  @override
  Future<R?> push<R>(Object route) {
    if (route is! PageRouteInfo) {
      throw ArgumentError.value(
        route,
        'route',
        'Expected a generated auto_route PageRouteInfo (*Route)',
      );
    }
    return _router.push<R>(route);
  }

  @override
  void pop<R>([R? result]) {
    if (!_router.canPop()) {
      return;
    }
    unawaited(_router.maybePop<R>(result));
  }

  @override
  void replaceAll(List<Object> routes) {
    final typed = <PageRouteInfo>[];
    for (final route in routes) {
      if (route is! PageRouteInfo) {
        throw ArgumentError.value(
          route,
          'routes',
          'Expected generated PageRouteInfo values',
        );
      }
      typed.add(route);
    }
    unawaited(_router.replaceAll(typed));
  }

  /// [PageNavigator.replaceNamed] maps to auto_route 11
  /// [StackRouter.replacePath].
  @override
  void replaceNamed(String path) {
    unawaited(_router.replacePath(path));
  }
}
