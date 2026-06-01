import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/common/request_status.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/features/movements/domain/cubits/movements/movements_cubit.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_filter.dart';
import 'package:ligo_app/features/movements/domain/repositories/movement_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockMovementsRepository extends Mock implements MovementsRepository {}

void main() {
  late MockMovementsRepository repository;
  late MovementsCubit cubit;

  setUp(() {
    repository = MockMovementsRepository();

    cubit = MovementsCubit(
      movementsRepository: repository,
    );
  });

  group('MovementsCubit - loadMovements', () {
    blocTest<MovementsCubit, MovementsState>(
      'should emit loading then success when loadMovements succeeds',
      build: () {
        when(
          () => repository.getMovements(),
        ).thenAnswer((_) async => const Success(<Movement>[]));

        return cubit;
      },
      act: (cubit) => cubit.loadMovements(),
      expect: () => [
        predicate<MovementsState>(
          (s) => s.requestStatus == RequestStatus.loading,
        ),
        predicate<MovementsState>(
          (s) =>
              s.requestStatus == RequestStatus.success && s.movements.isEmpty,
        ),
      ],
    );

    blocTest<MovementsCubit, MovementsState>(
      'should emit loading then failure when repository fails',
      build: () {
        when(
          () => repository.getMovements(),
        ).thenAnswer((_) async => Error(UnknownFailure()));

        return cubit;
      },
      act: (cubit) => cubit.loadMovements(),
      expect: () => [
        predicate<MovementsState>(
          (s) => s.requestStatus == RequestStatus.loading,
        ),
        predicate<MovementsState>(
          (s) =>
              s.requestStatus == RequestStatus.failure &&
              s.failure is UnknownFailure,
        ),
      ],
    );

    blocTest<MovementsCubit, MovementsState>(
      'should not emit states when already loading',
      build: () {
        when(() => repository.getMovements()).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 50));
          return const Success(<Movement>[]);
        });

        return cubit;
      },
      act: (cubit) async {
        unawaited(cubit.loadMovements());
        unawaited(cubit.loadMovements());
      },
      expect: () => [
        predicate<MovementsState>(
          (s) => s.requestStatus == RequestStatus.loading,
        ),
      ],
    );

    blocTest<MovementsCubit, MovementsState>(
      'should filter out unknown movements when loadMovements succeeds',
      build: () {
        when(() => repository.getMovements()).thenAnswer(
          (_) async => Success(<Movement>[
            Movement(
              id: '1',
              description: 'valid',
              amount: 10,
              type: .income,
              status: .completed,
            ),
            Movement(
              id: '2',
              description: 'invalid',
              amount: 20,
              type: .unknown,
              status: .completed,
            ),
          ]),
        );

        return cubit;
      },
      act: (cubit) => cubit.loadMovements(),
      expect: () => [
        predicate<MovementsState>(
          (s) => s.requestStatus == RequestStatus.loading,
        ),
        predicate<MovementsState>(
          (s) =>
              s.requestStatus == RequestStatus.success &&
              s.movements.length == 1 &&
              s.movements.first.id == '1',
        ),
      ],
    );
  });

  group('MovementsCubit - filterMovements', () {
    final movements = [
      Movement(
        id: '1',
        description: 'income',
        amount: 10,
        type: .income,
        status: .completed,
      ),
      Movement(
        id: '2',
        description: 'outcome',
        amount: 20,
        type: .outcome,
        status: .completed,
      ),
    ];

    blocTest<MovementsCubit, MovementsState>(
      'should return all movements when filter is null',
      build: () => cubit,
      seed: () => MovementsState(
        requestStatus: RequestStatus.success,
        movements: movements,
        allMovements: movements,
      ),
      act: (cubit) {
        cubit
          ..filterMovements(.income)
          ..filterMovements(null);
      },
      expect: () => [
        predicate<MovementsState>(
          (s) => s.movements.length == 1,
        ),
        predicate<MovementsState>(
          (s) => s.movements.length == 2,
        ),
      ],
    );

    blocTest<MovementsCubit, MovementsState>(
      'should filter only income movements',
      build: () => cubit,
      seed: () => MovementsState(
        requestStatus: RequestStatus.success,
        movements: movements,
        allMovements: movements,
      ),
      act: (cubit) => cubit.filterMovements(MovementFilterItem.income),
      expect: () => [
        predicate<MovementsState>(
          (s) => s.movements.length == 1 && s.movements.first.type == .income,
        ),
      ],
    );

    blocTest<MovementsCubit, MovementsState>(
      'should filter only outcome movements',
      build: () => cubit,
      seed: () => MovementsState(
        requestStatus: RequestStatus.success,
        movements: movements,
        allMovements: movements,
      ),
      act: (cubit) => cubit.filterMovements(MovementFilterItem.outcome),
      expect: () => [
        predicate<MovementsState>(
          (s) => s.movements.length == 1 && s.movements.first.type == .outcome,
        ),
      ],
    );
  });
}
