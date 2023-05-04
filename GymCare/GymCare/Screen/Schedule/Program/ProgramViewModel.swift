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
            let schedules = listSchedule.filter({$0.scheduleClass?.name == buffer.name})
            let schedule = ScheduleModel()
            schedule.schedules = schedules
            listSchedules.append(schedule)
        }
        return listSchedules
    }
}

