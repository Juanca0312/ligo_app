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

  /// Filters movements based on the selected filter item.
  void filterMovements(MovementFilterItem? filter) {
    final filtered = switch (filter) {
      null => state.allMovements,
      MovementFilterItem.income =>
        state.allMovements
            .where((movement) => movement.type == .income)
            .toList(),
      MovementFilterItem.outcome =>
        state.allMovements
            .where((movement) => movement.type == .outcome)
            .toList(),
    };

    emit(
      state.copyWith(
        movements: filtered,
      ),
    );
  }
}
