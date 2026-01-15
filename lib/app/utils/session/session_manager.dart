import 'package:get_storage/get_storage.dart';
import 'package:test_project/app/utils/session/session_key.dart';

abstract class SessionManager {
  Future<void> write(String key, dynamic value);

  dynamic read(String key);

  Future<void> clearAll();
  bool isLoggedIn();
}

class SessionManagerImpl implements SessionManager {
  final _session = GetStorage(SessionKey.session);

  @override
  Future<void> clearAll() async {
    return await _session.erase();
  }

  @override
  dynamic read(String key) {
    return _session.read(key);
  }

  @override
  Future<void> write(String key, dynamic value) async {
    return await _session.write(key, value);
  }

  @override
  bool isLoggedIn() {
    final userId = read(SessionKey.currentUserId);

    if (userId == null) return false;

    if (userId is int) return userId > 0;
    if (userId is String) return userId.isNotEmpty;

    return false; // Default fail
  }
}
