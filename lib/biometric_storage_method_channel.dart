import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tbib_biometric_storage/auth/tbib_auth.dart';

import 'biometric_storage_platform_interface.dart';

/// An implementation of [BiometricStoragePlatform] that uses method channels.
class MethodChannelBiometricStorage extends BiometricStoragePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('biometric_storage');

  // @override
  // void init(String boxName) {
  //   methodChannel.invokeMethod('init', boxName);
  // }

  @override
  Future<bool> canAuth() async {
    final LocalAuthentication auth = LocalAuthentication();
    // ···
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();

    return canAuthenticate;
  }

  @override
  Future<bool> auth(String reason) async {
    final LocalAuthentication localAuth = LocalAuthentication();
    try {
      final bool didAuthenticate = await localAuth.authenticate(
          localizedReason: reason, authMessages: TBIBAuth.values);
      return didAuthenticate;
      // ···
    } on PlatformException {
      rethrow;
    }
  }

  @override
  Future<String?> read(String key) async {
    return await methodChannel
        .invokeMethod<String?>('read', <String, String>{"key": key});
  }

  @override
  Future<void> write(String key, String value) async {
    return await methodChannel
        .invokeMethod('write', <String, String>{"key": key, "value": value});
  }
}
