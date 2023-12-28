
import 'biometric_storage_platform_interface.dart';

class BiometricStorage {
  Future<String?> getPlatformVersion() {
    return BiometricStoragePlatform.instance.getPlatformVersion();
  }
}
