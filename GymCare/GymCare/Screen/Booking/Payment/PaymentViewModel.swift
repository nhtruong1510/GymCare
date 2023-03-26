//
//  PaymentViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 24/02/2023.
//

import Foundation
import SwiftDate

final class PaymentViewModel: BaseViewModel {
    func getSumSession(fromDate: String, toDate: String, day: String) -> Int {
        var days: [Date] = []
        if day.contains("2") {
            days.append(contentsOf: Date.datesForWeekday(.monday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("3") {
            days.append(contentsOf: Date.datesForWeekday(.tuesday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("4") {
            days.append(contentsOf: Date.datesForWeekday(.wednesday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("5") {
            days.append(contentsOf: Date.datesForWeekday(.thursday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("6") {
            days.append(contentsOf: Date.datesForWeekday(.friday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("7") {
            days.append(contentsOf: Date.datesForWeekday(.saturday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("Chủ nhật") {
            days.append(contentsOf: Date.datesForWeekday(.sunday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        return days.count
    }
    
    func getSumMonth(fromDate: String, toDate: String, day: String) -> Int {
        let fromMonth = formatDateString(dateString: fromDate, Constants.DATE_FORMAT, Constants.MONTH_STRING)
        let toMonth = formatDateString(dateString: toDate, Constants.DATE_FORMAT, Constants.MONTH_STRING)
        return castToInt(toMonth) - castToInt(fromMonth) + 1
    }
    
    func createSchedule(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.createSchedule(param: param) { success, msg in
            completion(success, msg)
        }
    }
}
