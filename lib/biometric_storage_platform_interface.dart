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

  // Future<String?> getPlatformVersion() {
  //   throw UnimplementedError('platformVersion() has not been implemented.');
  // }
  Future<bool> canAuth() {
    throw UnimplementedError('canAuth() has not been implemented.');
  }

  Future<bool> auth(String reason) {
    throw UnimplementedError('auth() has not been implemented.');
  }

  // void init(String boxName) {
  //   throw UnimplementedError('init() has not been implemented.');
  // }

  Future<String?> read(String key) {
    throw UnimplementedError('read() has not been implemented.');
  }

  Future<void> write(String key, String value) {
    throw UnimplementedError('write() has not been implemented.');
  }
}
