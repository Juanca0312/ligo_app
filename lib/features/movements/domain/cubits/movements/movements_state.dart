part of 'movements_cubit.dart';

/// State class for the [MovementsCubit]
class MovementsState extends Equatable {
  /// Creates a new instance of [MovementsState] with the given parameters.
  const MovementsState({
    this.requestStatus = RequestStatus.initial,
    this.movements = const [],
    this.allMovements = const [],
    this.filter,
    this.query = '',
    this.failure,
  });

  /// Current request status (loading / success / failure)
  final RequestStatus requestStatus;

  /// List of movements to display
  final List<Movement> movements;

  /// Complete list of movements
  final List<Movement> allMovements;

  /// Failure if request fails
  final Failure? failure;

  /// Current applied filter
  final MovementFilterItem? filter;

  /// Current search query
  final String query;

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
    List<Movement>? allMovements,
    Object? filter = _unset,
    String? query,
    Failure? failure,
  }) {
    return MovementsState(
      requestStatus: requestStatus ?? this.requestStatus,
      movements: movements ?? this.movements,
      allMovements: allMovements ?? this.allMovements,
      filter: filter != _unset ? filter as MovementFilterItem? : this.filter,
      query: query ?? this.query,
      failure: failure,
    );
  }

  static const _unset = Object();

  @override
  List<Object?> get props => [
    requestStatus,
    movements,
    allMovements,
    failure,
  ];
}
