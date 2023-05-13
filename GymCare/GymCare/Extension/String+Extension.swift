//
//  String+Extension.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 29/12/2022.

import Foundation
import UIKit
import CommonCrypto

extension String {

    func encodingUTF8() -> String {
        let decode = self.removingPercentEncoding
        if let encodeString = decode?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return encodeString
        }
        return self
    }

    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    func isValidPhoneSize() -> Bool {
        if self.count >= 9, self.count <= 11 {
            return true
        }
        return false
    }

    func isValidPasswordSize() -> Bool {
        if self.count >= 6, self.count <= 12 {
            return true
        }
        return false
    }

    var isNumeric: Bool {
        return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }

    func formatMoney(groupingSeparater: String? = ".") -> String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.groupingSeparator = groupingSeparater
        guard let number = fmt.number(from: self) else {
            return ""
        }
        return fmt.string(from: number) ?? ""
    }

    func formatToDate(_ typeFormat: String? = Constants.DATE_FORMAT) -> Date {
        let dateformatter = DateFormatter()
        dateformatter.timeZone = TimeZone(abbreviation: "UTC")
        dateformatter.locale = Locale.current
        dateformatter.dateFormat = typeFormat
        dateformatter.calendar = Calendar(identifier: .gregorian)
        if let date = dateformatter.date(from: self) {
            return date
        }
        return Date()
    }
    
    func convertUrlStrToImage(completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: self) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                completion(image)
            }
        }.resume()
    }

    func getComponentOfMonthYearStyle(position: Int) -> Int? {
        let splits = self.components(separatedBy: "/")
        if splits.count > position {
            let month = splits[position]
            return castToInt(month)
        }
        return nil
    }

    func isValidHtmlString(_ value: String) -> Bool {
        if value.isEmpty {
            return false
        }
        return (value.range(of: "<(\"[^\"]*\"|'[^']*'|[^'\">])*>", options: .regularExpression) != nil)
    }

    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))

        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)

        let digest = stringFromResult(result: result, length: digestLen)

        result.deallocate()

        return digest
    }

    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash).lowercased()
    }
}

extension NSAttributedString {
    func withLineSpacing(_ spacing: CGFloat, lineBreakMode: NSLineBreakMode, alignment: NSTextAlignment) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignment
        attributedString.addAttribute(.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSRange(location: 0, length: string.count))
        return NSAttributedString(attributedString: attributedString)
    }

}

extension String {
    var md5: String {
        return HMAC.hash(inp: self, algo: HMACAlgo.MD5)
    }

    var sha1: String {
        return HMAC.hash(inp: self, algo: HMACAlgo.SHA1)
    }

    var sha224: String {
        return HMAC.hash(inp: self, algo: HMACAlgo.SHA224)
    }

    var sha256: String {
        return HMAC.hash(inp: self, algo: HMACAlgo.SHA256)
    }

    var sha384: String {
        return HMAC.hash(inp: self, algo: HMACAlgo.SHA384)
    }

    var sha512: String {
        return HMAC.hash(inp: self, algo: HMACAlgo.SHA512)
    }
}

public struct HMAC {

    static func hash(inp: String, algo: HMACAlgo) -> String {
        if let stringData = inp.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            return hexStringFromData(input: digest(input: stringData as NSData, algo: algo))
        }
        return ""
    }

    private static func digest(input : NSData, algo: HMACAlgo) -> NSData {
        let digestLength = algo.digestLength()
        var hash = [UInt8](repeating: 0, count: digestLength)
        switch algo {
        case .MD5:
            CC_MD5(input.bytes, UInt32(input.length), &hash)
            break
        case .SHA1:
            CC_SHA1(input.bytes, UInt32(input.length), &hash)
            break
        case .SHA224:
            CC_SHA224(input.bytes, UInt32(input.length), &hash)
            break
        case .SHA256:
            CC_SHA256(input.bytes, UInt32(input.length), &hash)
            break
        case .SHA384:
            CC_SHA384(input.bytes, UInt32(input.length), &hash)
            break
        case .SHA512:
            CC_SHA512(input.bytes, UInt32(input.length), &hash)
            break
        }
        return NSData(bytes: hash, length: digestLength)
    }

    private static func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }

        return hexString
    }
}

enum HMACAlgo {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

    func digestLength() -> Int {
        var result: CInt = 0
        switch self {
        case .MD5:
            result = CC_MD5_DIGEST_LENGTH
        case .SHA1:
            result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:
            result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:
            result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:
            result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:
            result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}
