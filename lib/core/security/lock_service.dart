import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

import '../errors.dart';
import '../../domain/entities.dart';

class LockService {
  LockService({
    FlutterSecureStorage? storage,
    LocalAuthentication? auth,
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _auth = auth ?? LocalAuthentication();

  final FlutterSecureStorage _storage;
  final LocalAuthentication _auth;

  static const _pinKey = 'finzee_pin_hash';
  static const _lockKey = 'finzee_lock_enabled';
  static const _bioKey = 'finzee_bio_enabled';
  static const _timeoutKey = 'finzee_autolock';

  Future<AppLockSettings> settings() async {
    final enabled = await _storage.read(key: _lockKey);
    final bio = await _storage.read(key: _bioKey);
    final timeout = await _storage.read(key: _timeoutKey);
    return AppLockSettings(
      enabled: enabled == '1',
      useBiometric: bio == '1',
      autoLockSeconds: int.tryParse(timeout ?? '') ?? 60,
    );
  }

  Future<void> setPin(String pin) async {
    if (pin.length < 4) {
      throw const AuthenticationError('PIN must be at least 4 digits.');
    }
    final hash = sha256.convert(utf8.encode(pin)).toString();
    await _storage.write(key: _pinKey, value: hash);
    await _storage.write(key: _lockKey, value: '1');
  }

  Future<void> disable() async {
    await _storage.delete(key: _pinKey);
    await _storage.write(key: _lockKey, value: '0');
  }

  Future<void> setBiometric(bool on) async {
    await _storage.write(key: _bioKey, value: on ? '1' : '0');
  }

  Future<void> setTimeout(int seconds) async {
    await _storage.write(key: _timeoutKey, value: '$seconds');
  }

  Future<bool> unlockWithPin(String pin) async {
    final stored = await _storage.read(key: _pinKey);
    if (stored == null) {
      throw const AuthenticationError('No PIN configured.');
    }
    final hash = sha256.convert(utf8.encode(pin)).toString();
    if (hash != stored) {
      throw const AuthenticationError('Incorrect PIN.');
    }
    return true;
  }

  Future<bool> unlockWithBiometric() async {
    try {
      return await _auth.authenticate(
        localizedReason: 'Unlock FinZee',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (_) {
      throw const AuthenticationError('Biometric unlock failed.');
    }
  }
}
