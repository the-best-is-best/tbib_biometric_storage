import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/types/auth_messages_ios.dart';

class TBIBAuth {
  static AndroidAuthMessages? _android;
  static IOSAuthMessages? _ios;

  void init({AndroidAuthMessages? android, IOSAuthMessages? ios}) {
    _android = android;
    _ios = ios;
  }

  static Iterable<AuthMessages> get values => [
        _android ?? const AndroidAuthMessages(),
        _ios ?? const IOSAuthMessages()
      ];
}
