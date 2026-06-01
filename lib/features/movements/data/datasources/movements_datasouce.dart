import 'package:ligo_app/features/movements/data/models/movement_model.dart';

/// Data source interface for fetching movements data.
abstract interface class MovementsDataSource {
  /// Fetches a list of movements from the data source.
  Future<List<MovementModel>> getMovements();
}
