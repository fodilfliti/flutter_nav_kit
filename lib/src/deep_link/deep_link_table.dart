/// Maps a URI path to a typed route object (usually a generated `*Route`).
final class DeepLinkTable {
  const DeepLinkTable(this.entries);

  final List<DeepLinkEntry> entries;

  /// First matching entry, or null if unknown.
  Object? resolve(Uri uri) {
    final path = uri.path.isEmpty ? '/' : uri.path;
    for (final entry in entries) {
      final params = matchPath(entry.path, path);
      if (params == null) {
        continue;
      }
      return entry.toRoute(params, uri);
    }
    return null;
  }
}

/// `path` uses `:param` segments, e.g. `/notes/:id`.
final class DeepLinkEntry {
  const DeepLinkEntry({
    required this.path,
    required this.toRoute,
  });

  final String path;

  /// Build a `PageRouteInfo` (or any object tests assert on).
  final Object Function(Map<String, String> params, Uri uri) toRoute;
}

/// Returns captured params, or null if [pattern] does not match [path].
Map<String, String>? matchPath(String pattern, String path) {
  final patternParts = _segments(pattern);
  final pathParts = _segments(path);
  if (patternParts.length != pathParts.length) {
    return null;
  }
  final params = <String, String>{};
  for (var i = 0; i < patternParts.length; i++) {
    final expected = patternParts[i];
    final actual = pathParts[i];
    if (expected.startsWith(':')) {
      final name = expected.substring(1);
      if (name.isEmpty) {
        return null;
      }
      params[name] = Uri.decodeComponent(actual);
    } else if (expected != actual) {
      return null;
    }
  }
  return params;
}

List<String> _segments(String path) {
  final trimmed = path.startsWith('/') ? path.substring(1) : path;
  if (trimmed.isEmpty) {
    return const [];
  }
  return trimmed
      .split('/')
      .where((part) => part.isNotEmpty)
      .toList(growable: false);
}
