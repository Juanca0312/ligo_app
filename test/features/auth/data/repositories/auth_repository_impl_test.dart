import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/core/network/app_exception.dart';
import 'package:ligo_app/core/session_manager/session.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';
import 'package:ligo_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:ligo_app/features/auth/data/models/session_model.dart';
import 'package:ligo_app/features/auth/data/models/user_model.dart';
import 'package:ligo_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthDataSource {}

class MockSessionManager extends Mock implements SessionManager {}

class FakeSession extends Fake implements Session {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeSession());
  });

  late MockAuthRemoteDataSource remoteDataSource;
  late MockSessionManager sessionManager;
  late AuthRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    sessionManager = MockSessionManager();

    repository = AuthRepositoryImpl(
      remoteDataSource: remoteDataSource,
      sessionManager: sessionManager,
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

    test('should return Success when login is successful', () async {
      // arrange
      when(
        () => remoteDataSource.login(
          email: tEmail,
          password: tPassword,
        ),
      ).thenAnswer((_) async => tSessionModel);

      when(() => sessionManager.saveSession(any())).thenAnswer((_) async {});

      // act
      final result = await repository.login(
        email: tEmail,
        password: tPassword,
      );

      // assert
      expect(result, isA<Success<void>>());

      verify(
        () => remoteDataSource.login(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      verify(() => sessionManager.saveSession(any())).called(1);
    });

    test(
      'should return UnauthorizedFailure when AppException is unauthorized',
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

        final failure = (result as Error<void>).failure;
        expect(failure, isA<UnauthorizedFailure>());

        verifyNever(() => sessionManager.saveSession(any()));
      },
    );

    test('should return UnknownFailure when unexpected error occurs', () async {
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

      final failure = (result as Error<void>).failure;
      expect(failure, isA<UnknownFailure>());

      verifyNever(() => sessionManager.saveSession(any()));
    });
  });
}
