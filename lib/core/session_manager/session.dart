/// A session represents an authenticated user session
class Session {
  /// Creates a new session with the given token and user information.
  Session({required this.token, required this.user});

  /// The authentication token for the session.
  final String token;

  /// The user associated with the session.
  final SessionUser user;
}

/// A class representing a user in the session
class SessionUser {
  /// Creates a new session user
  SessionUser({required this.id, required this.name});

  /// Creates a SessionUser from a JSON map.
  factory SessionUser.fromJson(Map<String, dynamic> json) => SessionUser(
    id: json['id'] as String,
    name: json['name'] as String,
  );

  /// The ID of the user.
  final String id;

  /// The name of the user.
  final String name;

  /// Converts the SessionUser to a JSON map for storage.
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
