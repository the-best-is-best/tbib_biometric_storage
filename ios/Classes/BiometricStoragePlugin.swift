import Flutter
import UIKit

public class BiometricStoragePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "biometric_storage", binaryMessenger: registrar.messenger())
        let instance = BiometricStoragePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        switch call.method {
        case "write":
            if let args = call.arguments as? Dictionary<String, String> {
                CryptoManager().saveData(account: args["key"]!, data: args["value"]!)
            }
            
            return
        case "read":
            if let args = call.arguments as? Dictionary<String, String>{
                
                result( CryptoManager().retrieveData(account: args["key"]!))
                
            }
            return
        default:
            result(FlutterMethodNotImplemented)
        }
        
    }
}
