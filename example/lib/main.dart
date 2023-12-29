import 'package:biometric_storage/auth/android_auth_messages.dart';
import 'package:biometric_storage/auth/ios_auth_messages.dart';
import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/material.dart';

void main() {
  TBIBAuth().init(
      android: const AndroidAuthMessages(
        cancelButton: "Cancel",
        goToSettingsButton: "Settings",
        goToSettingsDescription: "Please set up your Touch IDs .",
        biometricHint: "Touch sensors",
        biometricNotRecognized: "Fingerprint not recognizeds.",
        deviceCredentialsRequiredTitle: "Fingerprint requireds",
        deviceCredentialsSetupDescription:
            "Please set up your Touch ID or Face IDs.",
      ),
      ios: const IOSAuthMessages(
          cancelButton: "Cancel",
          goToSettingsButton: "Settings",
          goToSettingsDescription: "Please set up your Touch ID.",
          lockOut: "Please reenable your Touch ID"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _biometricStoragePlugin = BiometricStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  var auth =
                      await _biometricStoragePlugin.auth("Login to save data");
                  if (auth) {
                    await _biometricStoragePlugin.write(
                        "login", "user id 100s");
                  }
                },
                child: const Text("Save data demo")),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  var auth =
                      await _biometricStoragePlugin.auth("Login to get data");
                  if (auth) {
                    var retrive = await _biometricStoragePlugin.read("login");
                    print("data retrive is $retrive");
                  }
                },
                child: const Text("Get data demo"))
          ],
        )),
      ),
    );
  }
}
