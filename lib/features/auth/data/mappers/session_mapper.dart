import 'package:ligo_app/core/session_manager/session.dart';
import 'package:ligo_app/features/auth/data/models/session_model.dart';

/// A mapper class to convert between Session models and storage formats.
class SessionMapper {
  /// Creates a [Session] from a [SessionModel] returned
  /// by the remote data source.
  static Session fromModel({required SessionModel model}) {
    return Session(
      token: model.token,
      user: SessionUser(
        id: model.user.id,
        name: model.user.name,
      ),
    );
  }
}
