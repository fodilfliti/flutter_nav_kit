import 'package:auto_route/auto_route.dart';
import 'package:flutter_nav_kit/flutter_nav_kit.dart';
import 'package:flutter_nav_kit_example/pages/home_page.dart';
import 'package:flutter_nav_kit_example/pages/login_page.dart';
import 'package:flutter_nav_kit_example/pages/note_form_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this.isSignedIn});

  final bool Function() isSignedIn;

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
    AutoRoute(
      page: NoteFormRoute.page,
      path: '/notes/:noteId',
      guards: [AuthGuard(isSignedIn: isSignedIn)],
    ),
  ];
}

const exampleDeepLinks = DeepLinkTable([
  DeepLinkEntry(path: '/login', toRoute: _loginLink),
  DeepLinkEntry(path: '/home', toRoute: _homeLink),
  DeepLinkEntry(path: '/notes/:id', toRoute: _noteLink),
]);

Object _loginLink(Map<String, String> params, Uri uri) => const LoginRoute();

Object _homeLink(Map<String, String> params, Uri uri) => const HomeRoute();

Object _noteLink(Map<String, String> params, Uri uri) {
  return NoteFormRoute(noteId: params['id'] ?? 'new');
}
