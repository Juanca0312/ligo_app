/// This file contains the routes for the movements feature.
enum MovementsRoutes {
  /// The movements route.
  movements('/movements', 'movements')
  ;

  const MovementsRoutes(this.path, this.name);

  /// The path of the route.
  final String path;

  /// The name of the route.
  final String name;
}
