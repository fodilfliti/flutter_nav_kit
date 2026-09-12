// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [NoteFormPage]
class NoteFormRoute extends PageRouteInfo<NoteFormRouteArgs> {
  NoteFormRoute({
    String noteId = 'new',
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         NoteFormRoute.name,
         args: NoteFormRouteArgs(noteId: noteId, key: key),
         rawPathParams: {'noteId': noteId},
         initialChildren: children,
       );

  static const String name = 'NoteFormRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<NoteFormRouteArgs>(
        orElse:
            () => NoteFormRouteArgs(
              noteId: pathParams.getString('noteId', 'new'),
            ),
      );
      return NoteFormPage(noteId: args.noteId, key: args.key);
    },
  );
}

class NoteFormRouteArgs {
  const NoteFormRouteArgs({this.noteId = 'new', this.key});

  final String noteId;

  final Key? key;

  @override
  String toString() {
    return 'NoteFormRouteArgs{noteId: $noteId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NoteFormRouteArgs) return false;
    return noteId == other.noteId && key == other.key;
  }

  @override
  int get hashCode => noteId.hashCode ^ key.hashCode;
}
