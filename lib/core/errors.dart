sealed class FinzeeException implements Exception {
  const FinzeeException(this.message);
  final String message;
  @override
  String toString() => '$runtimeType: $message';
}

class ValidationError extends FinzeeException {
  const ValidationError(super.message);
}

class DatabaseError extends FinzeeException {
  const DatabaseError(super.message);
}

class BackupError extends FinzeeException {
  const BackupError(super.message);
}

class ImportError extends FinzeeException {
  const ImportError(super.message);
}

class AuthenticationError extends FinzeeException {
  const AuthenticationError(super.message);
}

class NotificationError extends FinzeeException {
  const NotificationError(super.message);
}

class CalculationError extends FinzeeException {
  const CalculationError(super.message);
}

class MigrationError extends FinzeeException {
  const MigrationError(super.message);
}

class FeatureUnavailableError extends FinzeeException {
  const FeatureUnavailableError(super.message);
}
