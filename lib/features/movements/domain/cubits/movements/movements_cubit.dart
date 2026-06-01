import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligo_app/core/common/request_status.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
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
        emit(
          state.copyWith(
            requestStatus: RequestStatus.success,
            movements: result.value,
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
}
