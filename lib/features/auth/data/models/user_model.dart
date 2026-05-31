/// Model representing a user in the authentication feature.
class UserModel {
  /// Constructs a [UserModel]
  UserModel({required this.name, required this.id});

  /// Factory method to create a [UserModel] from a JSON response.
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    name: json['name'] as String,
    id: json['id'] as String,
  );

  /// The name of the user.
  final String name;

  /// The unique identifier of the user.
  final String id;
}
