import 'package:finzee/application/app_lock_service.dart';

AppLockService mockAppLock({bool allowAuth = true}) => AppLockService(
      authenticateOverride: (_) async => allowAuth,
      deviceSupportedOverride: () async => true,
    );
