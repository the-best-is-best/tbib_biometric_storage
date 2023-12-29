import Security

class CryptoManager{
  func saveData(service:String="tbib_bio_storage",account:String,data:String){
          let query: [String: AnyObject] = [kSecClass as String:kSecClassGenericPassword,   kSecAttrService as String: service as AnyObject,   kSecAttrAccount as String:account as AnyObject,   kSecValueData as String: (data.data(using: .utf8)!) as AnyObject ]
          // saving data to Keychain
          let status = SecItemAdd(query as CFDictionary, nil)
          guard status != errSecDuplicateItem else{

              let attributes: [String: Any] = [kSecValueData as String: (data.data(using: .utf8))!]

              let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
              if status == errSecSuccess {
                  print("Save Successfull")
              }else{
                  print("Error")
              }
              return
          }
          // check the status
          if status == errSecSuccess {
              print("Save Successfull")
          }else{
              print("Error")
          }
      }


      func retrieveData(service:String="tbib_bio_storage",account:String) -> String?{
          // function to get the value
          let query: [String: AnyObject] = [kSecClass as String:kSecClassGenericPassword,   kSecAttrService as String: service as AnyObject,   kSecAttrAccount as String:account as AnyObject,   kSecReturnData as String: kCFBooleanTrue,   kSecMatchLimit as String: kSecMatchLimitOne ]
          var result : AnyObject?
          // copy something that matches our query
          let status = SecItemCopyMatching(query as CFDictionary, &result)
          let data = result as? Data
          if(data == nil){
              return nil
          }
          print("read status", status)
          return String(decoding: data!, as: UTF8.self)

      }
      func removeData(service: String="Study_Body", account: String) {
          let query: [String: AnyObject] = [
              kSecClass as String: kSecClassGenericPassword,
              kSecAttrService as String: service as AnyObject,
              kSecAttrAccount as String: account as AnyObject
          ]

          let status = SecItemDelete(query as CFDictionary)

          if status == errSecSuccess {
              print("Data removed successfully")
          } else {
              print("Error removing data")
          }
      }

      func checkDataExist(service:String="Study_Body",account:String)-> Bool{
          let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                      kSecAttrService as String: service,
                                      kSecAttrAccount as String: account,
                                      kSecReturnData as String: true,
                                      kSecMatchLimit as String: kSecMatchLimitOne]

          var result: AnyObject?
          let status = SecItemCopyMatching(query as CFDictionary, &result)

          if status == errSecSuccess {
              return true
          }
          return false

      }
}