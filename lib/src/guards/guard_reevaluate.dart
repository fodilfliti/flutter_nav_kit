import 'package:flutter/foundation.dart';

/// Pass to `router.config(reevaluateListenable: …)` and [notify] when
/// session changes so AuthGuard / GuestGuard run again.
///
/// Sign-out should only clear session and call this — no `nav`.
final class GuardReevaluate extends ChangeNotifier {
  void notify() => notifyListeners();
}
