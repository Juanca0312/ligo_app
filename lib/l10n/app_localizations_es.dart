// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get helloWorld => 'Hola Mundo!';

  @override
  String get email => 'Correo';

  @override
  String get password => 'Contraseña';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get genericError =>
      'Ocurrió un error inesperado. Inténtalo nuevamente.';

  @override
  String get unauthorizedError =>
      'No se pudo verificar tu identidad. Intenta nuevamente.';

  @override
  String get fieldRequired => 'Este campo es obligatorio.';

  @override
  String get invalidEmail => 'Ingresa un correo electrónico válido.';

  @override
  String get invalidPassword =>
      'La contraseña debe tener al menos 6 caracteres.';

  @override
  String get loginSuccess => 'Bienvenido!';

  @override
  String get movements => 'Movimientos';

  @override
  String get pending => 'En proceso';

  @override
  String get completed => 'Completado';

  @override
  String get failed => 'Fallido';

  @override
  String get unknown => 'Desconocido';

  @override
  String get income => 'Ingresos';

  @override
  String get outcome => 'Salidas';

  @override
  String get filterByStatusType => 'Filtra por tipo';

  @override
  String get sessionExpired => 'Tu sesión ha expirado.';

  @override
  String get movementsEmpty => 'No tienes movimientos registrados.';

  @override
  String get retry => 'Reintentar';

  @override
  String get searchMovements => 'Busca movimiento';

  @override
  String get id => 'ID de movimiento';

  @override
  String get amount => 'Monto';

  @override
  String get type => 'Tipo';

  @override
  String get status => 'Estado';
}
