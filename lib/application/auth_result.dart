/// Outcome of a device authentication attempt.
class AuthResult {
  const AuthResult._({required this.success, this.message});

  final bool success;
  final String? message;

  static const AuthResult ok = AuthResult._(success: true);

  factory AuthResult.cancelled() => const AuthResult._(
        success: false,
        message: 'Authentication cancelled.',
      );

  factory AuthResult.unavailable(String detail) => AuthResult._(
        success: false,
        message: detail,
      );
}
