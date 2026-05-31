import 'package:ligo_app/core/errors/failure.dart';

/// Represents the result of an operation that can succeed or fail.
sealed class Result<T> {
  const Result();

  /// Creates a successful result containing a value.
  const factory Result.success(T value) = Success<T>;

  /// Creates a failed result containing a [Failure].
  const factory Result.failure(Failure failure) = Error<T>;
}

/// Successful result wrapper containing the returned value.
final class Success<T> extends Result<T> {
  /// Constructs a [Success] with the given value.
  const Success(this.value);

  /// The successful value.
  final T value;
}

/// Failed result wrapper containing a [Failure].
final class Error<T> extends Result<T> {
  /// Constructs an [Error] with the given [Failure].
  const Error(this.failure);

  /// The failure describing what went wrong.
  final Failure failure;
}
