import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'biometric_storage_method_channel.dart';

abstract class BiometricStoragePlatform extends PlatformInterface {
  /// Constructs a BiometricStoragePlatform.
  BiometricStoragePlatform() : super(token: _token);

  static final Object _token = Object();

  static BiometricStoragePlatform _instance = MethodChannelBiometricStorage();

  /// The default instance of [BiometricStoragePlatform] to use.
  ///
  /// Defaults to [MethodChannelBiometricStorage].
  static BiometricStoragePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BiometricStoragePlatform] when
  /// they register themselves.
  static set instance(BiometricStoragePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
