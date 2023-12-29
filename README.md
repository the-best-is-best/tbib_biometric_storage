# biometric_storage

Encrypted file store, **optionally** secured by biometric lock 
for Android, iOS but android 5 not supported biometric but can use encrypt  with random token

Meant as a way to store small data in a hardware encrypted fashion. E.g. to 
store passwords, secret keys, etc. but not massive amounts
of data.

* Android: Uses androidx with KeyStore. but android 5 not supported biometric but can use encrypt with random token

* iOS LocalAuthentication with KeyChain.


## Getting Started

### Installation

#### Android
* Requirements:
  * Android: API Level >= 21 (android/app/build.gradle `minSdkVersion 21`)
  * Make sure to use the latest kotlin version: 
    * `android/build.gradle`: `ext.kotlin_version = '1.7.10'` with gradle:7.3.0
    * classpath 'com.android.tools.build:gradle:7.3.0'

  * MainActivity must extend FlutterFragmentActivity
  * Theme for the main activity must use `Theme.AppCompat` thme.
    (Otherwise there will be crases on Android < 29)
    For example: 
    
    **AndroidManifest.xml**:
    ```xml
    <activity
    android:name=".MainActivity"
    android:launchMode="singleTop"
    android:theme="@style/LaunchTheme">
    ```

    **xml/styles.xml**:
    ```xml
        <style name="LaunchTheme" parent="Theme.AppCompat.NoActionBar">
        <!-- Show a splash screen on the activity. Automatically removed when
             Flutter draws its first frame -->
        <item name="android:windowBackground">@drawable/launch_background</item>

        <item name="android:windowNoTitle">true</item>
        <item name="android:windowActionBar">false</item>
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowContentOverlay">@null</item>
    </style>    
    ```

   

##### Resources

* https://developer.android.com/topic/security/data
* https://developer.android.com/topic/security/best-practices

#### iOS

https://developer.apple.com/documentation/localauthentication/logging_a_user_into_your_app_with_face_id_or_touch_id

* include the NSFaceIDUsageDescription key in your app’s Info.plist file
* Requires at least iOS 9

**Known Issue**: since iOS 15 the simulator seem to no longer support local authentication:
    https://developer.apple.com/forums/thread/685773



### Usage

> You basically only need 4 methods.

1. Check whether biometric authentication is supported by the device

```dart
    final bool isBioSupported = await BiometricStorage().canAuth();
```

2. init AuthBio

```dart
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
```
3. need ask for auth before encrypt or decrypt data 
  // need reason for auth
```dart
  await BiometricStorage().auth("Login to save data");

```

4. Write data
 //   need send key , value
```dart
        await BiometricStorage().write("Login", "data to save");

```

5. Read data
   // need key
  ```dart
    await BiometricStorage().read("Login");

  ```


