import 'package:finzee/application/app_lock_service.dart';
import 'package:finzee/application/auth_result.dart';

AppLockService mockAppLock({bool allowAuth = true}) => AppLockService(
      authenticateOverride: (_) async => allowAuth ? AuthResult.ok : AuthResult.cancelled(),
      deviceSupportedOverride: () async => true,
    );
