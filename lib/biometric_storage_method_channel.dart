import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'biometric_storage_platform_interface.dart';

/// An implementation of [BiometricStoragePlatform] that uses method channels.
class MethodChannelBiometricStorage extends BiometricStoragePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('biometric_storage');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
