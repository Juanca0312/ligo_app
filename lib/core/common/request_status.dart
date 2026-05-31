/// Defines the possible states of a request
enum RequestStatus {
  /// The request has not been made yet
  initial,

  /// The request is currently being made
  loading,

  /// The request completed successfully
  success,

  /// The request failed with an error
  failure,
}
