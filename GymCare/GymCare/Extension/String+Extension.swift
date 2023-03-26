//
//  String+Extension.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 29/12/2022.

import Foundation
import UIKit

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
