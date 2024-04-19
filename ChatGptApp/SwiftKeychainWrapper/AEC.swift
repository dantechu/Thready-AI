//  String+Addition.swift
import CryptoSwift
import Foundation
extension String {
func aesEncrypt(key: String) throws -> String {
        
        var result = ""
        
        do {
            let key: [UInt8] = Array(key.utf8) as [UInt8]
            let aes = try! AES(key: key, blockMode: ECB() , padding:.pkcs5) // AES128 .ECB pkcs7
            let encrypted = try aes.encrypt(Array(self.utf8))
            result = encrypted.toBase64()
        } catch {
            
        }
        
        return result
    }

func aesDecrypt(key: String) throws -> String {
    
    var result = ""
    
    do {
        let encrypted = self
        let key: [UInt8] = Array(key.utf8) as [UInt8]
        let aes = try! AES(key: key, blockMode: ECB(), padding: .pkcs5) // AES128 .ECB pkcs7
        let decrypted = try aes.decrypt(Array(base64: encrypted))
        result = String(data: Data(decrypted), encoding: .utf8) ?? ""
    } catch {
        
    }
    
    return result
}

}
