import 'package:lemsa_nav_kit/lemsa_nav_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const table = DeepLinkTable([
    DeepLinkEntry(path: '/login', toRoute: _login),
    DeepLinkEntry(path: '/home', toRoute: _home),
    DeepLinkEntry(path: '/notes/:id', toRoute: _note),
  ]);

  test('resolves known URIs', () {
    expect(table.resolve(Uri.parse('https://app.example/login')), 'login');
    expect(table.resolve(Uri.parse('https://app.example/home')), 'home');
    expect(
      table.resolve(Uri.parse('https://app.example/notes/42?tab=edit')),
      'note:42:edit',
    );
  });

  test('unknown URI returns null', () {
    expect(table.resolve(Uri.parse('https://app.example/nope')), isNull);
  });
}

Object _login(Map<String, String> params, Uri uri) => 'login';

Object _home(Map<String, String> params, Uri uri) => 'home';

Object _note(Map<String, String> params, Uri uri) {
  return 'note:${params['id']}:${uri.queryParameters['tab']}';
}
