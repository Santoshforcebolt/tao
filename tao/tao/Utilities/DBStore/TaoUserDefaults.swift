//
//  TaoUserDefaults.swift
//  tao
//
//  Created by Betto Akkara on 02/03/22.
//

import Foundation


extension UserDefaults {
    static var shared: UserDefaults {
        let combined = UserDefaults.standard
        return combined
    }
}

struct TaoUserDefaults {
    static let standard = TaoUserDefaults.init()
    fileprivate let secretKey = "x8fV9bGgqqmQwgCoyXFQj+(o.nUNQhVP7NS"
    fileprivate let secretValue = "x9fV9bGgqqmQwgCoyXFQj+(o.nUNQhVP7NS"

    func synchronize() -> Bool {
        let saved = UserDefaults.shared.synchronize()
        return saved
    }

    func removePersistentDomain(forName domainName: String) {
        UserDefaults.shared.removePersistentDomain(forName: domainName)
        _ = synchronize()
    }

    func checkKeyAvailable(key data : String = "" , onCompletion : @escaping (Bool)->()){

        let keys = UserDefaults.standard.dictionaryRepresentation().keys

        let encryptedKey = self.getSecretKey(value: data)
        guard ((encryptedKey?.base64) != nil) else {
            return
        }
        let encKey: String = encryptedKey!.base64

        if keys.contains(encKey){
            onCompletion(true)
        }else{
            onCompletion(false)
        }

    }

    func integer(forKey defaultName: String) -> Int {
        let value = self.getSecretObject(forKey: defaultName) as? Int ?? 0
        return value
    }

    func float(forKey defaultName: String) -> Float {
        let value = self.getSecretObject(forKey: defaultName) as? Float ?? 0.0
        return value
    }

    func double(forKey defaultName: String) -> Double {

        let value = self.getSecretObject(forKey: defaultName) as? Double ?? 0.0
        return value
    }

    func bool(forKey defaultName: String) -> Bool {

        let value = self.getSecretObject(forKey: defaultName) as? Bool ?? false
        return value
    }

    func url(forKey defaultName: String) -> URL? {
        let value = self.getSecretObject(forKey: defaultName) as? String ?? nil
        if let value = value {
            return URL(string: value)!
        }
        return nil

    }

    func object(forKey defaultName: String) -> Any? {
        let value = self.getSecretObject(forKey: defaultName)

        if let value = value as? Data {
            let unarchievedObject = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value)
            return unarchievedObject ?? nil
        }
        return nil
    }

    func set(_ value: Int, forKey defaultName: String) {
        self.saveSecretObject(value: NSNumber.init(value: value), defaultKey: defaultName)
    }

    func set(_ value: Float, forKey defaultName: String) {
        self.saveSecretObject(value: NSNumber.init(value: value), defaultKey: defaultName)
    }

    func set(_ value: Double, forKey defaultName: String) {
        self.saveSecretObject(value: NSNumber.init(value: value), defaultKey: defaultName)
    }

    func set(_ value: Bool, forKey defaultName: String) {
        self.saveSecretObject(value: NSNumber.init(value: value), defaultKey: defaultName)
    }

    func set(_ url: URL, forKey defaultName: String) {
        self.saveSecretObject(value: url.absoluteString, defaultKey: defaultName)
    }

    func set(_ value: Any, forKey defaultName: String) {
        do {
            if #available(iOS 11.0, *) {
                let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
                self.saveSecretObject(value: data, defaultKey: defaultName)
            } else {
                self.saveSecretObject(value: NSKeyedArchiver.archivedData(withRootObject: value), defaultKey: defaultName)
            }

        } catch {
            Logger.d("Couldn't be saved")
        }
    }


    fileprivate func getSecretValue(value: Any) -> CocoaSecurityResult? {

        var data: Data!
        if #available(iOS 11.0, *) {
            let coder = NSKeyedArchiver(requiringSecureCoding: true)
            coder.encode(value, forKey: secretValue)
            data = coder.encodedData
        } else {
            data = NSKeyedArchiver.archivedData(withRootObject: value)
        }

        guard let keyData: CocoaSecurityResult = CocoaSecurity.sha384(secretValue) else {
            return nil
        }

        let aesKeyTotalRange = NSMakeRange(0, keyData.data.count)
        let aesKeyRange = NSMakeRange(0, 32)
        let aesIvRange = NSMakeRange(32, 16)

        if (NSEqualRanges(NSIntersectionRange(aesKeyTotalRange, aesKeyRange), aesKeyRange)) &&  (NSEqualRanges(NSIntersectionRange(aesKeyTotalRange, aesIvRange), aesIvRange)){
            //safe

            let aesKey: NSData = keyData.data.subdata(in: Range(aesKeyRange)!) as NSData
            let aesIv: NSData = keyData.data.subdata(in: Range(aesIvRange)!) as NSData

            // Encrypt data
            let result: CocoaSecurityResult = CocoaSecurity.aesEncrypt(with: data, key: aesKey as Data, iv: aesIv as Data)
            return result
        }
        return nil
    }

    fileprivate func getSecretKey(value: Any) -> CocoaSecurityResult? {

        var data: Data!

        if #available(iOS 11.0, *) {
            let coder = NSKeyedArchiver(requiringSecureCoding: true)
            coder.encode(value, forKey: secretKey)
            data = coder.encodedData
        } else {
            data = NSKeyedArchiver.archivedData(withRootObject: value)
        }

        guard let keyData: CocoaSecurityResult = CocoaSecurity.sha384(secretKey) else {
            return nil
        }

        let aesKeyTotalRange = NSMakeRange(0, keyData.data.count)
        let aesKeyRange = NSMakeRange(0, 32)
        let aesIvRange = NSMakeRange(32, 16)


        if (NSEqualRanges(NSIntersectionRange(aesKeyTotalRange, aesKeyRange), aesKeyRange)) &&  (NSEqualRanges(NSIntersectionRange(aesKeyTotalRange, aesIvRange), aesIvRange)){
            //safe

            let aesKey: NSData = keyData.data.subdata(in: Range(aesKeyRange)!) as NSData
            let aesIv: NSData = keyData.data.subdata(in: Range(aesIvRange)!) as NSData

            // Encrypt data
            let result: CocoaSecurityResult = CocoaSecurity.aesEncrypt(with: data, key: aesKey as Data, iv: aesIv as Data)
            return result
        }

        return nil
    }

    fileprivate func saveSecretObject(value: Any, defaultKey: String) {
        let encryptedValue = self.getSecretValue(value: value)
        let encryptedKey = self.getSecretKey(value: defaultKey)

        guard ((encryptedValue?.data) != nil), ((encryptedKey?.base64) != nil) else {
            return
        }

        let key: String = encryptedKey!.base64
        UserDefaults.shared.setValue(encryptedValue!.data, forKey: key)

        _ = synchronize()
    }

    fileprivate func getSecretObject(forKey key: String) -> Any? {

        let encryptedKey = self.getSecretKey(value: key)

        guard ((encryptedKey?.base64) != nil) else {
            return nil
        }

        let decryptedKey: String = encryptedKey!.base64

        let data = UserDefaults.shared.object(forKey: decryptedKey) as? Data
        guard (data != nil) else {
            return nil
        }


        guard let keyData: CocoaSecurityResult = CocoaSecurity.sha384(secretValue) else {
            return nil
        }


        let aesKeyTotalRange = NSMakeRange(0, keyData.data.count)
        let aesKeyRange = NSMakeRange(0, 32)
        let aesIvRange = NSMakeRange(32, 16)


        if (NSEqualRanges(NSIntersectionRange(aesKeyTotalRange, aesKeyRange), aesKeyRange)) &&  (NSEqualRanges(NSIntersectionRange(aesKeyTotalRange, aesIvRange), aesIvRange)){
            //safe
            let aesKey: Data = keyData.data.subdata(in: Range(aesKeyRange)!) as Data
            let aesIv: Data = keyData.data.subdata(in: Range(aesIvRange)!) as Data

            let result: CocoaSecurityResult = CocoaSecurity.aesDecrypt(with: data, key: aesKey, iv: aesIv)

            if #available(iOS 11.0, *) {
                let decoder = try? NSKeyedUnarchiver.init(forReadingFrom: result.data)
                let returnObject = decoder?.decodeObject(forKey: secretValue)
                decoder?.finishDecoding()
                return returnObject
            } else {
                let returnObject = NSKeyedUnarchiver.unarchiveObject(with: result.data)
                return returnObject
            }

        }

        return nil
    }

    func removeObject(forKey defaultName: String) {

        let encryptedKey = self.getSecretKey(value: defaultName)

        guard ((encryptedKey?.base64) != nil) else {
            return
        }

        let decryptedKey: String = encryptedKey!.base64
        UserDefaults.shared.removeObject(forKey: decryptedKey)
        _ = synchronize()
    }
}

