import 'package:ligo_app/features/auth/data/models/user_model.dart';

/// Model representing a user session.
class SessionModel {
  /// Constructs a [SessionModel]
  SessionModel({required this.token, required this.user});

  /// Factory method to create a [SessionModel] from a JSON response.
  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    token: json['token'] as String,
    user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );

  /// The authentication token for the session.
  final String token;

  /// The user information returned from the login API.
  final UserModel user;
}
