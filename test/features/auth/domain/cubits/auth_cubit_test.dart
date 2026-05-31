import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/common/request_status.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/features/auth/domain/cubits/auth/auth_cubit.dart';
import 'package:ligo_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ligo_app/features/auth/domain/validators/login_form_validator.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockValidators extends Mock implements LoginFormValidators {}

void main() {
  late MockAuthRepository repository;
  late MockValidators validators;
  late AuthCubit cubit;

  setUp(() {
    repository = MockAuthRepository();
    validators = MockValidators();

    cubit = AuthCubit(
      authRepository: repository,
      validators: validators,
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
          (s) => s.email.value == 'test@mail.com' && s.email.isDirty,
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
          (s) => s.password.value == '123456' && s.password.isDirty,
        ),
      ],
    );
  });

  group('AuthCubit - login', () {
    blocTest<AuthCubit, AuthState>(
      'should emit loading then success when login succeeds',
      build: () {
        when(
          () => repository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => const Success(null));

        when(() => validators.validateEmail(any())).thenReturn(null);
        when(() => validators.validatePassword(any())).thenReturn(null);

        return cubit;
      },
      act: (cubit) {
        cubit
          ..updateEmail('test@mail.com')
          ..updatePassword('123456');

        return cubit.login();
      },
      expect: () => [
        predicate<AuthState>(
          (s) => s.email.value == 'test@mail.com' && s.email.isDirty,
        ),
        predicate<AuthState>(
          (s) => s.password.value == '123456' && s.password.isDirty,
        ),
        predicate<AuthState>(
          (s) => s.authRequestStatus == RequestStatus.loading,
        ),
        predicate<AuthState>(
          (s) => s.authRequestStatus == RequestStatus.success,
        ),
      ],
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
      act: (cubit) {
        cubit
          ..updateEmail('test@mail.com')
          ..updatePassword('wrong-password');

        return cubit.login();
      },
      expect: () => [
        predicate<AuthState>(
          (s) => s.email.value == 'test@mail.com' && s.email.isDirty,
        ),
        predicate<AuthState>(
          (s) => s.password.value == 'wrong-password' && s.password.isDirty,
        ),
        predicate<AuthState>(
          (s) => s.authRequestStatus == RequestStatus.loading,
        ),
        predicate<AuthState>(
          (s) => s.authRequestStatus == RequestStatus.failure,
        ),
      ],
    );
  });
}
