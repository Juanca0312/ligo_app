import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ligo_app/core/session_manager/session.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';
import 'package:ligo_app/features/auth/domain/entities/session_status.dart';

part 'session_state.dart';

/// Cubit class for managing user session state and logic.
class SessionCubit extends Cubit<SessionState> {
  /// Creates a new instance of [SessionCubit] with the given [SessionManager].
  SessionCubit({
    required SessionManager sessionManager,
  }) : _sessionManager = sessionManager,
       super(const SessionState()) {
    _listenToSession();
  }

  StreamSubscription<Session?>? _subscription;

  void _listenToSession() {
    _subscription = _sessionManager.sessionStream.listen((session) {
      if (session == null) {
        emit(
          const SessionState(
            status: SessionStatus.unauthenticated,
          ),
        );
      } else {
        emit(
          SessionState(
            status: SessionStatus.authenticated,
            sessionUser: session.user,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    unawaited(_subscription?.cancel());
    return super.close();
  }

  final SessionManager _sessionManager;

  /// Logs in the user by saving the session and emitting the authenticated.
  Future<void> login(Session session) async {
    await _sessionManager.saveSession(session);

    emit(SessionState(status: .authenticated, sessionUser: session.user));
  }

  /// Logs out the user by clearing the session and emitting the unauthenticated
  /// state.
  Future<void> logout() async {
    await _sessionManager.clearSession();
    emit(const SessionState(status: .unauthenticated));
  }

  /// Restores the user session if available, otherwise emits
  /// the unauthenticated state.
  Future<void> restoreSession() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final session = await _sessionManager.getSession();

    if (session == null) {
      emit(const SessionState(status: .unauthenticated));
      return;
    }

    emit(SessionState(status: .authenticated, sessionUser: session.user));
  }
}
