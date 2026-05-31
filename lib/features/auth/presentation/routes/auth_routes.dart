/// This file contains the routes for the authentication feature.
enum AuthRoutes {
  /// The login route.
  login('/login', 'login')
  ;

  const AuthRoutes(this.path, this.name);

  /// The path of the route.
  final String path;

  /// The name of the route.
  final String name;
}
