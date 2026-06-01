import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ligo_app/core/session_manager/session.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';
import 'package:ligo_app/features/auth/domain/cubits/session/session_cubit.dart';
import 'package:ligo_app/features/auth/domain/entities/session_status.dart';
import 'package:mocktail/mocktail.dart';

class MockSessionManager extends Mock implements SessionManager {}

class FakeSession extends Fake implements Session {}

void main() {
  late MockSessionManager sessionManager;
  late SessionCubit cubit;

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
    sessionManager = MockSessionManager();

    when(
      () => sessionManager.sessionStream,
    ).thenAnswer((_) => const Stream<Session?>.empty());

    cubit = SessionCubit(
      sessionManager: sessionManager,
    );
  });

  group('login', () {
    blocTest<SessionCubit, SessionState>(
      'should save session and emit authenticated state',
      build: () {
        when(() => sessionManager.saveSession(any())).thenAnswer((_) async {});

        return cubit;
      },
      act: (cubit) => cubit.login(tSession),
      expect: () => [
        predicate<SessionState>(
          (s) =>
              s.status == SessionStatus.authenticated && s.session == tSession,
        ),
      ],
      verify: (_) {
        verify(() => sessionManager.saveSession(tSession)).called(1);
      },
    );
  });

  group('logout', () {
    blocTest<SessionCubit, SessionState>(
      'should clear session and emit unauthenticated state',
      build: () {
        when(() => sessionManager.clearSession()).thenAnswer((_) async {});

        return cubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        predicate<SessionState>(
          (s) => s.status == SessionStatus.unauthenticated && s.session == null,
        ),
      ],
      verify: (_) {
        verify(() => sessionManager.clearSession()).called(1);
      },
    );
  });

  group('restoreSession', () {
    blocTest<SessionCubit, SessionState>(
      'should emit authenticated when session exists',
      build: () {
        when(
          () => sessionManager.getSession(),
        ).thenAnswer((_) async => tSession);

        return cubit;
      },
      act: (cubit) => cubit.restoreSession(),
      expect: () => [
        predicate<SessionState>(
          (s) =>
              s.status == SessionStatus.authenticated && s.session == tSession,
        ),
      ],
      verify: (_) {
        verify(() => sessionManager.getSession()).called(1);
      },
    );

    blocTest<SessionCubit, SessionState>(
      'should emit unauthenticated when session is null',
      build: () {
        when(() => sessionManager.getSession()).thenAnswer((_) async => null);

        return cubit;
      },
      act: (cubit) => cubit.restoreSession(),
      expect: () => [
        predicate<SessionState>(
          (s) => s.status == SessionStatus.unauthenticated && s.session == null,
        ),
      ],
      verify: (_) {
        verify(() => sessionManager.getSession()).called(1);
      },
    );
  });
}
