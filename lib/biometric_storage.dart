import 'biometric_storage_platform_interface.dart';

export 'auth/tbib_auth.dart';

class BiometricStorage {
  // Future<String?> getPlatformVersion() {
  //   return BiometricStoragePlatform.instance.getPlatformVersion();
  // }
  // void init(String boxName) {
  //   BiometricStoragePlatform.instance.init(boxName);
  // }
  Future<bool> canAuth() {
    return BiometricStoragePlatform.instance.canAuth();
  }

  Future<bool> auth(String reason) async {
    return await BiometricStoragePlatform.instance.auth(reason);
  }

  Future<String?> read(String key) async {
    return await BiometricStoragePlatform.instance.read(key);
  }

  Future<void> write(String key, String value) async {
    await BiometricStoragePlatform.instance.write(key, value);
  }
}
