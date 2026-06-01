import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligo_app/core/common/form_item.dart';
import 'package:ligo_app/core/common/request_status.dart';
import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ligo_app/features/auth/domain/validators/auth_validators.dart';

part 'auth_state.dart';

/// Cubit class for managing authentication state and logic.
class AuthCubit extends Cubit<AuthState> {
  /// Creates a new instance of [AuthCubit] with the given [IAuthRepository].
  AuthCubit({
    required IAuthRepository authRepository,
    required LoginFormValidators validators,
  }) : _authRepository = authRepository,
       _validators = validators,
       super(const AuthState());

  final IAuthRepository _authRepository;
  final LoginFormValidators _validators;

  /// Logins the user using the email and password from the current state
  Future<void> login() async {
    if (!state.isFormValid || state.isLoading) return;

    emit(state.copyWith(authRequestStatus: RequestStatus.loading));

    final result = await _authRepository.login(
      email: state.email.value,
      password: state.password.value,
    );

    switch (result) {
      case Success():
        emit(state.copyWith(authRequestStatus: RequestStatus.success));
      case Error():
        emit(
          state.copyWith(
            authRequestStatus: RequestStatus.failure,
            failure: result.failure,
          ),
        );
    }
  }

  /// Updates the email field in the state and validates it
  void updateEmail(String email) {
    final error = _validators.validateEmail(email);

    final updated = state.email.copyWith(
      value: email,
      error: error,
      isDirty: true,
    );

    emit(
      state.copyWith(
        email: updated,
      ),
    );
  }

  /// Updates the password field in the state and validates it
  void updatePassword(String password) {
    final error = _validators.validatePassword(password);

    final updatedPassword = state.password.copyWith(
      value: password,
      error: error,
      isDirty: true,
    );

    emit(
      state.copyWith(
        password: updatedPassword,
      ),
    );
  }
}
