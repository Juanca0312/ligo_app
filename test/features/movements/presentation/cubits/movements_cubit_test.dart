import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/common/request_status.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/features/movements/domain/entities/movement.dart';
import 'package:ligo_app/features/movements/domain/entities/movement_filter.dart';
import 'package:ligo_app/features/movements/domain/repositories/movement_repository.dart';
import 'package:ligo_app/features/movements/presentation/cubits/movements/movements_cubit.dart';
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

  group('MovementsCubit - filter + search (state driven)', () {
    final movements = [
      Movement(
        id: '1',
        description: 'salary income',
        amount: 10,
        type: .income,
        status: .completed,
      ),
      Movement(
        id: '2',
        description: 'food outcome',
        amount: 20,
        type: .outcome,
        status: .completed,
      ),
      Movement(
        id: '3',
        description: 'bonus income',
        amount: 30,
        type: .income,
        status: .completed,
      ),
    ];

    blocTest<MovementsCubit, MovementsState>(
      'should apply filter income then search query',
      build: () => cubit,
      seed: () => MovementsState(
        requestStatus: RequestStatus.success,
        allMovements: movements,
        movements: movements,
      ),
      act: (cubit) {
        cubit
          ..updateFilter(MovementFilterItem.income)
          ..updateQuery('salary');
      },
      expect: () => [
        predicate<MovementsState>(
          (s) =>
              s.filter == MovementFilterItem.income && s.movements.length == 2,
        ),
        predicate<MovementsState>(
          (s) =>
              s.query == 'salary' &&
              s.movements.length == 1 &&
              s.movements.first.id == '1',
        ),
      ],
    );

    blocTest<MovementsCubit, MovementsState>(
      'should reset filter and restore all movements',
      build: () => cubit,
      seed: () => MovementsState(
        requestStatus: RequestStatus.success,
        allMovements: movements,
        movements: movements,
      ),
      act: (cubit) {
        cubit
          ..updateFilter(MovementFilterItem.income)
          ..updateFilter(null);
      },
      expect: () => [
        predicate<MovementsState>(
          (s) =>
              s.filter == MovementFilterItem.income && s.movements.length == 2,
        ),
        predicate<MovementsState>(
          (s) => s.filter == null && s.movements.length == 3,
        ),
      ],
    );

    blocTest<MovementsCubit, MovementsState>(
      'should apply only search without filter',
      build: () => cubit,
      seed: () => MovementsState(
        requestStatus: RequestStatus.success,
        allMovements: movements,
        movements: movements,
      ),
      act: (cubit) => cubit.updateQuery('bonus'),
      expect: () => [
        predicate<MovementsState>(
          (s) =>
              s.query == 'bonus' &&
              s.movements.length == 1 &&
              s.movements.first.id == '3',
        ),
      ],
    );

    blocTest<MovementsCubit, MovementsState>(
      'should reset search when query is empty',
      build: () => cubit,
      seed: () => MovementsState(
        requestStatus: RequestStatus.success,
        allMovements: movements,
        movements: movements,
        query: 'test',
      ),
      act: (cubit) {
        cubit
          ..updateQuery('test')
          ..updateQuery('');
      },
      expect: () => [
        predicate<MovementsState>(
          (s) => s.query == 'test' && s.movements.isEmpty,
        ),
        predicate<MovementsState>(
          (s) => s.query == '' && s.movements.length == 3,
        ),
      ],
    );
  });
}
