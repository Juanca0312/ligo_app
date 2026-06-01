part of 'movements_cubit.dart';

/// State class for the [MovementsCubit]
class MovementsState extends Equatable {
  /// Creates a new instance of [MovementsState] with the given parameters.
  const MovementsState({
    this.requestStatus = RequestStatus.initial,
    this.movements = const [],
    this.failure,
  });

  /// Current request status (loading / success / failure)
  final RequestStatus requestStatus;

  /// List of movements to display
  final List<Movement> movements;

  /// Failure if request fails
  final Failure? failure;

  /// Whether the request is loading.
  bool get isLoading => requestStatus == RequestStatus.loading;

  /// Whether the request succeeded.
  bool get isSuccess => requestStatus == RequestStatus.success;

  /// Whether the request failed.
  bool get isFailure => requestStatus == RequestStatus.failure;

  /// Whether the request succeeded but returned an empty list.
  bool get isEmpty => movements.isEmpty && isSuccess;

  /// Creates a copy of the current [MovementsState] with optional new values.
  MovementsState copyWith({
    RequestStatus? requestStatus,
    List<Movement>? movements,
    Failure? failure,
  }) {
    return MovementsState(
      requestStatus: requestStatus ?? this.requestStatus,
      movements: movements ?? this.movements,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
    requestStatus,
    movements,
    failure,
  ];
}
