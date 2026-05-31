/// Generic contract for input validation.
///
/// Returns an error of type [E] if the value is invalid,
/// otherwise returns null.
abstract interface class Validator<T, E> {
  /// Validates the given [value] and returns an error of type [E] if invalid,
  /// or null if the value is valid.
  E? validate(T value);
}
