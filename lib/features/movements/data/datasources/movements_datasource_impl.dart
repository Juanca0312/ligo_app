import 'package:ligo_app/core/helpers/safe_parser_helper.dart';
import 'package:ligo_app/core/network/http_client.dart';
import 'package:ligo_app/features/movements/data/datasources/movements_datasouce.dart';
import 'package:ligo_app/features/movements/data/models/movement_model.dart';
import 'package:ligo_app/features/movements/data/movements_endpoints.dart';

/// Implementation of the [MovementsDataSource] interface for
/// fetching movements data.
final class MovementDatasourceImpl implements MovementsDataSource {
  /// Constructs a [MovementDatasourceImpl]
  MovementDatasourceImpl({required LigoHttpClient httpClient})
    : _httpClient = httpClient;

  final LigoHttpClient _httpClient;

  @override
  Future<List<MovementModel>> getMovements() async {
    final response = await _httpClient.get<List<dynamic>>(
      MovementsEndpoints.getMovements,
    );

    return SafeParser.fromJsonList(response.data, MovementModel.fromJson);
  }
}
