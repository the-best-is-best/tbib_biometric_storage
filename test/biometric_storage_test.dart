import 'package:flutter_test/flutter_test.dart';
import 'package:biometric_storage/biometric_storage.dart';
import 'package:biometric_storage/biometric_storage_platform_interface.dart';
import 'package:biometric_storage/biometric_storage_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBiometricStoragePlatform
    with MockPlatformInterfaceMixin
    implements BiometricStoragePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BiometricStoragePlatform initialPlatform = BiometricStoragePlatform.instance;

  test('$MethodChannelBiometricStorage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBiometricStorage>());
  });

  test('getPlatformVersion', () async {
    BiometricStorage biometricStoragePlugin = BiometricStorage();
    MockBiometricStoragePlatform fakePlatform = MockBiometricStoragePlatform();
    BiometricStoragePlatform.instance = fakePlatform;

    expect(await biometricStoragePlugin.getPlatformVersion(), '42');
  });
}
