import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'auth_result.dart';

/// Uses the device's native screen lock (biometrics, PIN, pattern, or passcode).
class AppLockService {
  AppLockService({
    LocalAuthentication? auth,
    Future<AuthResult> Function(String reason)? authenticateOverride,
    Future<bool> Function()? deviceSupportedOverride,
  })  : _auth = auth ?? LocalAuthentication(),
        _authenticateOverride = authenticateOverride,
        _deviceSupportedOverride = deviceSupportedOverride;

  final LocalAuthentication _auth;
  final Future<AuthResult> Function(String reason)? _authenticateOverride;
  final Future<bool> Function()? _deviceSupportedOverride;

  Future<bool> isDeviceSupported() async {
    if (_deviceSupportedOverride != null) {
      return _deviceSupportedOverride!();
    }
    if (kIsWeb) return false;
    try {
      if (!await _auth.isDeviceSupported()) return false;
      return await _auth.canCheckBiometrics ||
          await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<List<BiometricType>> availableBiometrics() async {
    if (kIsWeb) return const [];
    try {
      return await _auth.getAvailableBiometrics();
    } catch (_) {
      return const [];
    }
  }

  Future<AuthResult> authenticate({required String reason}) async {
    if (_authenticateOverride != null) {
      return _authenticateOverride!(reason);
    }
    if (kIsWeb) {
      return AuthResult.unavailable(
        'Device security is not available in the browser.',
      );
    }
    try {
      final ok = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      return ok ? AuthResult.ok : AuthResult.cancelled();
    } on PlatformException catch (e) {
      return AuthResult.unavailable(_platformMessage(e));
    } catch (_) {
      return AuthResult.unavailable(
        'Could not open device security. Check that a screen lock is set up.',
      );
    }
  }

  String _platformMessage(PlatformException e) {
    switch (e.code) {
      case 'NotAvailable':
        return 'Device security is not available. Set up fingerprint, face, or a screen lock in system settings.';
      case 'NotEnrolled':
        return 'No biometrics enrolled. Add fingerprint or face unlock, or use your device PIN.';
      case 'LockedOut':
        return 'Too many failed attempts. Try again shortly or use your device PIN.';
      case 'PermanentlyLockedOut':
        return 'Biometrics locked out. Unlock your device with PIN or pattern first.';
      case 'PasscodeNotSet':
        return 'No screen lock on this device. Enable one in system settings first.';
      case 'auth_in_progress':
        return 'Authentication already in progress. Wait a moment and try again.';
      default:
        final detail = e.message?.trim();
        if (detail != null && detail.isNotEmpty) return detail;
        return 'Device authentication failed (${e.code}).';
    }
  }
}
