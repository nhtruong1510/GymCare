//
//  ProgramViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 16/03/2023.
//

import Foundation

class ProgramViewModel: BaseViewModel {

    func callApiGetClass(classId: Int, completion: @escaping (ClassModel?, String?) -> Void) {
        self.repository.getClassInfo(classId: classId) { data, msg in
            completion(data, msg)
        }
    }
    
    func setListSchedule(listSchedule: [Schedule], listClass: [Class]) -> [ScheduleModel] {
        var listSchedules: [ScheduleModel] = []
        var buffer = [Class]()
        for item in listClass where !buffer.contains(where: {$0.name == item.name}) {
            buffer.append(item)
        }
        for buffer in buffer {
            var schedules = listSchedule.filter({$0.scheduleClass?.name == buffer.name})
            schedules = filterExpiredSchedule(schedules: schedules)
            let schedule = ScheduleModel()
            schedule.schedules = schedules
            if castToInt(schedule.schedules?.count) > 0 {
                listSchedules.append(schedule)
            }
        }
        return listSchedules
    }
    
    func filterExpiredSchedule(schedules: [Schedule]) -> [Schedule] {
        var newSchedules: [Schedule] = []
        for schedule in schedules {
            schedule.date = schedule.date?.filter({$0.date?.formatToDate(Constants.DATE_PARAM_FORMAT) ?? Date() > Date()})
        }
        newSchedules = schedules.filter({castToInt($0.date?.count) > 0})
        return newSchedules
    }
}

