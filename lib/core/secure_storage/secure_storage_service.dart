/// Contract for the secure storage service, which is responsible for
/// securely storing sensitive data
abstract interface class SecureStorageService {
  /// Writes a value to secure storage with the given key.
  Future<void> write({
    required String key,
    required String value,
  });

  /// Reads a value from secure storage for the given key. Returns null if the
  Future<String?> read(String key);

  /// Deletes a value from secure storage for the given key.
  Future<void> delete(String key);
}
