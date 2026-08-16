import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

/// Uses the device's native screen lock (biometrics, PIN, pattern, or passcode).
class AppLockService {
  AppLockService({
    LocalAuthentication? auth,
    Future<bool> Function(String reason)? authenticateOverride,
    Future<bool> Function()? deviceSupportedOverride,
  })  : _auth = auth ?? LocalAuthentication(),
        _authenticateOverride = authenticateOverride,
        _deviceSupportedOverride = deviceSupportedOverride;

  final LocalAuthentication _auth;
  final Future<bool> Function(String reason)? _authenticateOverride;
  final Future<bool> Function()? _deviceSupportedOverride;

  Future<bool> isDeviceSupported() async {
    if (_deviceSupportedOverride != null) {
      return _deviceSupportedOverride!();
    }
    if (kIsWeb) return false;
    try {
      final supported = await _auth.isDeviceSupported();
      if (!supported) return false;
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
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

  Future<bool> authenticate({required String reason}) async {
    if (_authenticateOverride != null) {
      return _authenticateOverride!(reason);
    }
    if (kIsWeb) return false;
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}
