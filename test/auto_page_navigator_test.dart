import 'package:auto_route/auto_route.dart';
import 'package:flutter_nav_kit/flutter_nav_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('push and pop smoke with a fake stack', () async {
    final router = _RecordingRouter();
    final nav = AutoPageNavigator(router);

    expect(nav.canPop, isTrue);
    await nav.push<void>(const _DummyRoute());
    expect(router.pushed, hasLength(1));

    nav.pop('ok');
    expect(router.popped, 'ok');
  });

  test('push rejects non-PageRouteInfo', () {
    final nav = AutoPageNavigator(_RecordingRouter());
    expect(() => nav.push<void>('nope'), throwsArgumentError);
  });

  test('replaceNamed maps to replacePath', () {
    final router = _RecordingRouter();
    final nav = AutoPageNavigator(router);
    nav.replaceNamed('/home');
    nav.replaceAll(const [_DummyRoute()]);
    expect(router.replacedPath, '/home');
    expect(router.replacedAll, hasLength(1));
  });
}

class _DummyRoute extends PageRouteInfo<void> {
  const _DummyRoute() : super(_DummyRoute.name);

  static const String name = 'DummyRoute';
}

class _RecordingRouter extends Fake implements StackRouter {
  final pushed = <PageRouteInfo<dynamic>>[];
  Object? popped;
  String? replacedPath;
  List<PageRouteInfo<dynamic>>? replacedAll;

  @override
  bool canPop({
    bool ignoreChildRoutes = false,
    bool ignoreParentRoutes = false,
    bool ignorePagelessRoutes = false,
  }) => true;

  @override
  Future<T?> push<T extends Object?>(
    PageRouteInfo<dynamic> route, {
    OnNavigationFailure? onFailure,
  }) async {
    pushed.add(route);
    return null;
  }

  @override
  Future<bool> maybePop<T extends Object?>([T? result]) async {
    popped = result;
    return true;
  }

  @override
  Future<T?> replacePath<T extends Object?>(
    String path, {
    bool includePrefixMatches = false,
    OnNavigationFailure? onFailure,
  }) async {
    replacedPath = path;
    return null;
  }

  @override
  Future<void> replaceAll(
    List<PageRouteInfo<dynamic>> routes, {
    OnNavigationFailure? onFailure,
    bool updateExistingRoutes = true,
  }) async {
    replacedAll = List<PageRouteInfo<dynamic>>.from(routes);
  }
}
