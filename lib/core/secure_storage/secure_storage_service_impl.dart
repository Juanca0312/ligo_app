import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ligo_app/core/secure_storage/secure_storage_service.dart';

/// Implementation of the secure storage service using the
/// flutter_secure_storage package.
final class SecureStorageServiceImpl implements ISecureStorageService {
  /// Creates an instance of [SecureStorageServiceImpl]
  SecureStorageServiceImpl(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<void> write({required String key, required String value}) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  @override
  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }
}
