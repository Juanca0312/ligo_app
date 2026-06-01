import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/common/request_status.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/core/presentation/cubits/session/session_cubit.dart';
import 'package:ligo_app/core/session_manager/session.dart';
import 'package:ligo_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ligo_app/features/auth/domain/validators/login_form_validator.dart';
import 'package:ligo_app/features/auth/presentation/cubits/auth/auth_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockValidators extends Mock implements LoginFormValidators {}

class MockSessionCubit extends Mock implements SessionCubit {}

class FakeSession extends Fake implements Session {}

void main() {
  late MockAuthRepository repository;
  late MockValidators validators;
  late MockSessionCubit sessionCubit;
  late AuthCubit cubit;

  final tSession = Session(
    token: 'token_123',
    user: SessionUser(
      id: '1',
      name: 'Juan',
    ),
  );

  setUpAll(() {
    registerFallbackValue(FakeSession());
  });

  setUp(() {
    repository = MockAuthRepository();
    validators = MockValidators();
    sessionCubit = MockSessionCubit();

    when(() => sessionCubit.login(any())).thenAnswer((_) async {});

    cubit = AuthCubit(
      authRepository: repository,
      validators: validators,
      sessionCubit: sessionCubit,
    );
  });

  group('AuthCubit - form validation', () {
    blocTest<AuthCubit, AuthState>(
      'should update email and mark it dirty',
      build: () {
        when(() => validators.validateEmail(any())).thenReturn(null);
        return cubit;
      },
      act: (cubit) => cubit.updateEmail('test@mail.com'),
      expect: () => [
        predicate<AuthState>(
          (s) =>
              s.email.value == 'test@mail.com' &&
              s.email.isDirty &&
              s.email.error == null,
        ),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'should update password and mark it dirty',
      build: () {
        when(() => validators.validatePassword(any())).thenReturn(null);
        return cubit;
      },
      act: (cubit) => cubit.updatePassword('123456'),
      expect: () => [
        predicate<AuthState>(
          (s) =>
              s.password.value == '123456' &&
              s.password.isDirty &&
              s.password.error == null,
        ),
      ],
    );
  });

  group('AuthCubit - login', () {
    blocTest<AuthCubit, AuthState>(
      'should emit loading then success and call SessionCubit on success',
      build: () {
        when(
          () => repository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Success(tSession));

        when(() => validators.validateEmail(any())).thenReturn(null);
        when(() => validators.validatePassword(any())).thenReturn(null);

        return cubit;
      },
      act: (cubit) async {
        cubit
          ..updateEmail('test@mail.com')
          ..updatePassword('123456');

        await cubit.login();
      },
      expect: () => [
        predicate<AuthState>((s) => s.email.value == 'test@mail.com'),
        predicate<AuthState>((s) => s.password.value == '123456'),
        predicate<AuthState>(
          (s) => s.authRequestStatus == RequestStatus.loading,
        ),
        predicate<AuthState>(
          (s) => s.authRequestStatus == RequestStatus.success,
        ),
      ],
      verify: (_) {
        verify(
          () => repository.login(
            email: 'test@mail.com',
            password: '123456',
          ),
        ).called(1);

        verify(() => sessionCubit.login(tSession)).called(1);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit loading and failure when login fails',
      build: () {
        when(
          () => repository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => Error(UnauthorizedFailure()),
        );

        when(() => validators.validateEmail(any())).thenReturn(null);
        when(() => validators.validatePassword(any())).thenReturn(null);

        return cubit;
      },
      act: (cubit) async {
        cubit
          ..updateEmail('test@mail.com')
          ..updatePassword('wrong-password');

        await cubit.login();
      },
      expect: () => [
        predicate<AuthState>((s) => s.email.value == 'test@mail.com'),
        predicate<AuthState>((s) => s.password.value == 'wrong-password'),
        predicate<AuthState>(
          (s) => s.authRequestStatus == RequestStatus.loading,
        ),
        predicate<AuthState>(
          (s) =>
              s.authRequestStatus == RequestStatus.failure &&
              s.failure is UnauthorizedFailure,
        ),
      ],
      verify: (_) {
        verifyNever(() => sessionCubit.login(any()));
      },
    );
  });
}
