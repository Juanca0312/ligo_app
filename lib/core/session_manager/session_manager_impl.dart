import 'dart:async';
import 'dart:convert';

import 'package:ligo_app/core/secure_storage/secure_storage_keys.dart';
import 'package:ligo_app/core/secure_storage/secure_storage_service.dart';
import 'package:ligo_app/core/session_manager/session.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';

/// Implementation of the SessionManager interface that uses secure storage
final class SessionManagerImpl implements SessionManager {
  /// Creates an instance of [SessionManagerImpl]
  SessionManagerImpl(this._storage);

  final SecureStorageService _storage;
  final _controller = StreamController<Session?>.broadcast();

  @override
  Future<void> saveSession(Session session) async {
    await Future.wait([
      _storage.write(key: SecureStorageKeys.token, value: session.token),
      _storage.write(
        key: SecureStorageKeys.user,
        value: jsonEncode(session.user.toJson()),
      ),
    ]);

    _controller.add(session);
  }

  @override
  Future<Session?> getSession() async {
    final (token, userJson) = await (
      _storage.read(SecureStorageKeys.token),
      _storage.read(SecureStorageKeys.user),
    ).wait;

    if (token == null || userJson == null) {
      return null;
    }

    final userMap = jsonDecode(userJson) as Map<String, dynamic>;
    final user = SessionUser.fromJson(userMap);

    return Session(
      token: token,
      user: user,
    );
  }

  @override
  Future<String?> getToken() async {
    return _storage.read(SecureStorageKeys.token);
  }

  @override
  Future<void> clearSession() async {
    await Future.wait([
      _storage.delete(SecureStorageKeys.token),
      _storage.delete(SecureStorageKeys.user),
    ]);

    _controller.add(null);
  }

  @override
  Stream<Session?> get sessionStream => _controller.stream;
}
