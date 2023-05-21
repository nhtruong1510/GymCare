//
//  BookingViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 23/02/2023.
//

import Foundation
import SwiftDate

final class BookingViewModel: BaseViewModel {

    func setListRegion(data: [AnyObject]?) -> [RegionObject] {
        var listRegion: [RegionObject] = []
        if let data = data {
            for datum in data {
                if let day = datum as? DateElement {
                    listRegion.append(RegionObject(id: day.id, name: day.day))
                    continue
                }
                if let time = datum as? Time {
                    listRegion.append(RegionObject(id: time.id, name: time.time))
                    continue
                }
                if let day = datum as? DateElement {
                    listRegion.append(RegionObject(id: day.id, name: day.day))
                    continue
                }
            }
        }
        return listRegion
    }
    
    func callApiGetTrainer(trainerId: Int, completion: @escaping (Trainer?, String?) -> Void) {
        self.repository.getTrainer(trainerId: trainerId) { data, msg in
            completion(data, msg)
        }
    }
    
    func updateSchedule(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.updateSchedule(param: param) { success, msg in
            completion(success, msg)
        }
    }

    func createNoti(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.createNoti(param: param) { success, msg in
            completion(success, msg)
        }
    }

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
    
    func getSumMonth(fromDate: String, toDate: String) -> Int {
        let calendar = Calendar.current
        let fromMonth = fromDate.formatToDate()
        let toMonth = toDate.formatToDate()
        let components = calendar.dateComponents([.month], from: fromMonth, to: toMonth)

        return components.year ?? 0
    }
    
    func getToDate(fromDateStr: String, numberOfMonth: Int) -> String? {
        let fromDate = fromDateStr.formatToDate()
        let toDate = fromDate.dateByAdding(numberOfMonth, .month)
        return toDate.date.toString()
    }
}
