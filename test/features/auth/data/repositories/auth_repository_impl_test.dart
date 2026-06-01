import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/core/network/app_exception.dart';
import 'package:ligo_app/core/session_manager/session.dart';
import 'package:ligo_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:ligo_app/features/auth/data/models/session_model.dart';
import 'package:ligo_app/features/auth/data/models/user_model.dart';
import 'package:ligo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthDataSource {}

void main() {
  late MockAuthRemoteDataSource remoteDataSource;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();

    repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
  });

  group('login', () {
    const tEmail = 'test@test.com';
    const tPassword = '123456';

    final tSessionModel = SessionModel(
      token: 'token_123',
      user: UserModel(
        id: '1',
        name: 'Juan',
      ),
    );

    test('should return Success<Session> when login is successful', () async {
      // arrange
      when(
        () => remoteDataSource.login(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => tSessionModel);

      // act
      final result = await repository.login(
        email: tEmail,
        password: tPassword,
      );

      // assert
      expect(result, isA<Success<Session>>());

      final session = (result as Success<Session>).value;

      expect(session.token, tSessionModel.token);
      expect(session.user.id, tSessionModel.user.id);
      expect(session.user.name, tSessionModel.user.name);

      verify(
        () => remoteDataSource.login(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
    });

    test(
      'should return failure when AppException occurs',
      () async {
        // arrange
        when(
          () => remoteDataSource.login(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(
          const AppException(
            type: AppErrorType.unauthorized,
          ),
        );

        // act
        final result = await repository.login(
          email: tEmail,
          password: tPassword,
        );

        // assert
        expect(result, isA<Error<void>>());

        final failure = (result as Error).failure;
        expect(failure, isA<UnauthorizedFailure>());

        verify(
          () => remoteDataSource.login(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
      },
    );

    test(
      'should return UnknownFailure when unexpected exception occurs',
      () async {
        // arrange
        when(
          () => remoteDataSource.login(
            email: tEmail,
            password: tPassword,
          ),
        ).thenThrow(Exception('crash'));

        // act
        final result = await repository.login(
          email: tEmail,
          password: tPassword,
        );

        // assert
        expect(result, isA<Error<void>>());

        final failure = (result as Error).failure;
        expect(failure, isA<UnknownFailure>());

        verify(
          () => remoteDataSource.login(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
      },
    );
  });
}
