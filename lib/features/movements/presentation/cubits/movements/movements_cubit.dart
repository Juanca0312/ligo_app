import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligo_app/core/common/request_status.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_filter.dart';
import 'package:ligo_app/features/movements/domain/repositories/movement_repository.dart';

part 'movements_state.dart';

/// Cubit class for managing movements state and logic.
class MovementsCubit extends Cubit<MovementsState> {
  /// Creates a new instance of [MovementsCubit].
  MovementsCubit({
    required MovementsRepository movementsRepository,
  }) : _movementsRepository = movementsRepository,
       super(const MovementsState());

  final MovementsRepository _movementsRepository;

  /// Fetches movements from repository
  Future<void> loadMovements() async {
    if (state.isLoading) return;

    emit(
      state.copyWith(
        requestStatus: RequestStatus.loading,
      ),
    );

    final result = await _movementsRepository.getMovements();

    switch (result) {
      case Success():
        // filter list to remove any unknown elements
        final filteredMovements = result.value
            .where(
              (movement) =>
                  movement.type != .unknown && movement.status != .unknown,
            )
            .toList();
        emit(
          state.copyWith(
            requestStatus: RequestStatus.success,
            movements: filteredMovements,
            allMovements: filteredMovements,
          ),
        );

      case Error():
        emit(
          state.copyWith(
            requestStatus: RequestStatus.failure,
            failure: result.failure,
          ),
        );
    }
  }

  /// Retrieves a movement by its ID from the current state.
  Movement getById(String id) => state.allMovements.firstWhere(
    (m) => m.id == id,
  );

  /// Filters movements based on the selected filter item.
  void updateFilter(MovementFilterItem? filter) {
    emit(
      state.copyWith(
        filter: filter,
        movements: _applyFilters(
          source: state.allMovements,
          filter: filter,
          query: state.query,
        ),
      ),
    );
  }

  /// Searches movements based on the provided query string.
  void updateQuery(String query) {
    final normalized = query.trim();

    emit(
      state.copyWith(
        query: normalized,
        movements: _applyFilters(
          source: state.allMovements,
          filter: state.filter,
          query: normalized,
        ),
      ),
    );
  }

  List<Movement> _applyFilters({
    required List<Movement> source,
    required MovementFilterItem? filter,
    required String query,
  }) {
    var list = source;

    switch (filter) {
      case MovementFilterItem.income:
        list = list.where((m) => m.type == .income).toList();

      case MovementFilterItem.outcome:
        list = list.where((m) => m.type == .outcome).toList();

      case null:
        break;
    }

    if (query.trim().isNotEmpty) {
      final q = query.toLowerCase();

      list = list
          .where(
            (m) => m.description.toLowerCase().contains(q),
          )
          .toList();
    }

    return list;
  }
}
