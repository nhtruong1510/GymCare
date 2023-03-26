//
//  Common.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 27/12/2022.
//

import Foundation
import UIKit

public func castToInt(_ data: Any?) -> Int {
    if let data = data {
        if let strValue = data as? String, let intValue = Int(strValue) {
            return intValue
        }
    }
    return 0
}

public func castToDouble(_ data: Any?) -> Double {
    if let data = data as? Double {
        return data
    }
    return 0
}

public func castToInt(_ data: String?) -> Int {
    if let data = data, let value = Int(data) {
        return value
    }
    return 0
}

public func castToInt(_ data: Int?) -> Int {
    if let data = data {
        return data
    }
    return 0
}

public func castToString(_ data: Any?) -> String {
    if let data = data {
        return "\(data)"
    }
    return ""
}

public func castToBool(_ data: Bool?) -> Bool {
    if let value = data {
        return value
    }
    return false
}

public func formatDateTypeApi(date: Date, _ typeFormat: String? = "dd/MM/yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = typeFormat
    dateFormatter.amSymbol = Constants.amSymbol
    dateFormatter.pmSymbol = Constants.pmSymbol
    let dateStr = dateFormatter.string(from: date)
    return dateStr
}

public func formatDate(date: String, _ typeFormat: String? = "dd/MM/yyyy") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = typeFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.amSymbol = Constants.amSymbol
    dateFormatter.pmSymbol = Constants.pmSymbol
    let dateStr = dateFormatter.date(from: date)
    return dateStr
}

public func formatDateString(dateString: String, _ typeFormat: String? = "dd/MM/yyyy", _ typeReturn: String? = "dd/MM/yyyy") -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = typeFormat
    dateFormatter.amSymbol = Constants.amSymbol
    dateFormatter.pmSymbol = Constants.pmSymbol
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = typeReturn
        return dateFormatter.string(from: date)
    }
    return nil
}

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}
