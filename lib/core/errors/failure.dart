/// Base class for all application failures.
sealed class Failure {}

/// Indicates an authentication or authorization error.
final class UnauthorizedFailure extends Failure {}

/// Represents an unexpected or unhandled error.
final class UnknownFailure extends Failure {}
