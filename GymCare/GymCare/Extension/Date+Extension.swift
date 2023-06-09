//
//  Date+Extension.swift
//
//

import Foundation

extension Date {

    func toString(_ dateFormatStr: String? = nil) -> String? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = dateFormatStr ?? Constants.DATE_FORMAT
        return dateFormat.string(from: self)
    }

    func getCurrentTime() -> String? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        return dateFormat.string(from: Date())
    }

}
