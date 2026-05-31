import 'package:ligo_app/core/common/result.dart';
import 'package:ligo_app/core/errors/failure.dart';
import 'package:ligo_app/core/errors/failure_mapper.dart';
import 'package:ligo_app/core/network/app_exception.dart';
import 'package:ligo_app/core/session_manager/session_manager.dart';
import 'package:ligo_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:ligo_app/features/auth/data/mappers/session_mapper.dart';
import 'package:ligo_app/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of the [IAuthRepository] interface, responsible for handling
/// user authentication operations by interacting with the remote data source
/// and managing the user session.
final class AuthRepositoryImpl implements IAuthRepository {
  /// Creates a new instance of [AuthRepositoryImpl]
  AuthRepositoryImpl({
    required IAuthRemoteDataSource remoteDataSource,
    required ISessionManager sessionManager,
  }) : _remoteDataSource = remoteDataSource,
       _sessionManager = sessionManager;

  final IAuthRemoteDataSource _remoteDataSource;
  final ISessionManager _sessionManager;

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final sessionModel = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      final session = SessionMapper.fromModel(model: sessionModel);

      await _sessionManager.saveSession(session);

      return const Result.success(null);
    } on AppException catch (e) {
      return Result.failure(FailureMapper.from(e));
    } on Exception {
      return Result.failure(
        UnknownFailure(),
      );
    }
  }
}
