//
//  HealthViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 04/04/2023.
//

import Foundation
import HealthKit

final class HealthViewModel: BaseViewModel {
    
    private let param: TargetParamObject = TargetParamObject()
    private let weekParam: [TargetParamObject] = []

    private var listTarget: TargetList = TargetList()

    func callApiGetTrainer(customerId: Int, completion: @escaping (TargetModel?, String?) -> Void) {
        self.repository.getTarget(customerId: customerId) { data, msg in
            completion(data, msg)
        }
    }
    
    func createOrUpdateHealth(param: TargetParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.createOrUpdateHealth(param: param) { success, msg in
            completion(success, msg)
        }
    }
    
    func callApiGetHealth(completion: @escaping ([TargetHealth]?, String?) -> Void) {
        self.repository.getHealth(showLoading: true) { data, msg in
            completion(data, msg)
        }
    }
    
    func setListData() -> [TargetList] {
        var listTarget: [TargetList] = []
        for _ in 0...7 {
            listTarget.append(TargetList())
        }
        return listTarget
    }
    
    func loadInfoHealth() {
        let healthStore = HKHealthStore()
        
        let date =  Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)
        
        if let type = HKSampleType.quantityType(forIdentifier: .stepCount) {
            let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate,
                                          options: [.cumulativeSum]) { (query, statistics, error) in
                var value: Double = 0

                if error != nil {
                    print("something went wrong")
                } else if let quantity = statistics?.sumQuantity() {
                    value = quantity.doubleValue(for: HKUnit.count())
                    DispatchQueue.main.async {
                        self.param.walk_number = castToInt(value)
                        self.checkParamHealth()
                    }
                }
            }
            healthStore.execute(query)
        }
        
        if let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) {
            let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate,
                                          options: [.cumulativeSum]) { (query, statistics, error) in
                var value: Double = 0

                if error != nil {
                    print("something went wrong")
                } else if let quantity = statistics?.sumQuantity() {
                    value = quantity.doubleValue(for: HKUnit.mile())
                    DispatchQueue.main.async {
                        self.param.distanceHealth = value
                        self.checkParamHealth()
                    }
                }
            }
            healthStore.execute(query)
        }
        
        if let type = HKSampleType.quantityType(forIdentifier: .appleExerciseTime) {
            let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
                var value: Double = 0

                if error != nil {
                    print("something went wrong")
                } else if let quantity = statistics?.sumQuantity() {
                    value = quantity.doubleValue(for: HKUnit.minute())
                    DispatchQueue.main.async {
                        self.param.excercise = castToInt(value)
                        self.checkParamHealth()
                    }
                }
            }
            healthStore.execute(query)
        }
        
        if let type = HKQuantityType.quantityType(forIdentifier: .heartRate) {
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            let query = HKSampleQuery(sampleType: type, predicate: nil, limit: 8, sortDescriptors: [sortDescriptor]) { (query, results, error) -> Void in
                var value: Double = 0

                if let error = error {
                    print(error)
                } else {
                    for (_, sample) in results!.enumerated() {
                        if let quantity = sample as? HKQuantitySample {
                            value = quantity.quantity.doubleValue(for: HKUnit(from: "count/min"))
                            self.param.heartRate = castToInt(value)
                            self.checkParamHealth()
                        }
                    }
                }
            }
            healthStore.execute(query)
        }
        
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            let start = Date().addingTimeInterval(-3600 * 24)
            let end = Date()
            
            let predicate = HKQuery.predicateForSamples(
                withStart: start,
                end: end,
                options: [.strictStartDate, .strictEndDate]
            )
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 100000, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    print("something went wrong")
                    return
                }
                guard let result = tmpResult else { return }
                for item in result {
                    if let sample = item as? HKCategorySample {
                        let startDate = sample.startDate
                        let endDate = sample.endDate
                        let sleepTimeForOneDay = sample.endDate.timeIntervalSince(sample.startDate)
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            if sleepTimeForOneDay/3600 > 2 {
                                self.param.sleepHealth = sleepTimeForOneDay/3600
                                self.checkParamHealth()
                            }
                        }
                    }
                }
            }
            healthStore.execute(query)
        }
    }
    
    private func checkParamHealth() {
        guard let step = param.walk_number, let sleep = param.sleepHealth,
                let distance = param.distanceHealth, let heartRate = param.heartRate else { return }
        param.excercise = castToInt(param.excercise)
//        createOrUpdateHealth(param: param) { _, _ in }
    }
    
    private func setParamWeekHealth(completion: @escaping() -> Void) {
        guard listTarget.walkNumber.count >= 6, listTarget.distance.count >= 6,
              listTarget.heartRate.count >= 6, listTarget.sleep.count >= 6 else { return }
        for index in 0...5 {
            let param = TargetParamObject()
            if index < listTarget.walkNumber.count {
                param.walk_number = castToInt(listTarget.walkNumber[index].step)
                param.date = listTarget.walkNumber[index].date
            }

            if index < listTarget.activity.count {
                param.excercise = castToInt(listTarget.activity[index].step)
            }

            if index < listTarget.sleep.count {
                param.sleepHealth = listTarget.sleep[index].sleep

            }
            
            if index < listTarget.distance.count {
                param.distanceHealth = listTarget.distance[index].step
            }
            
            if index < listTarget.heartRate.count {
                param.heartRate = castToInt(listTarget.heartRate[index])
            }
            createOrUpdateHealth(param: param) {_, _ in
                if index == 5 {
                    completion()
                }
            }
        }
    }
    
    func getDataHealthOfWeek(completion: @escaping() -> Void) {
        let healthStore = HKHealthStore()
        
        let startDate = Date().addingTimeInterval(-3600 * 24 * 6)
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: [.strictStartDate, .strictEndDate]
        )
        
        // interval is 1 day
        var interval = DateComponents()
        interval.day = 1
        
        // start from midnight
        let calendar = Calendar.current
        let anchorDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        
        let query = HKStatisticsCollectionQuery(
            quantityType: HKSampleType.quantityType(forIdentifier: .stepCount)!,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum,
            anchorDate: anchorDate!,
            intervalComponents: interval
        )
        
        query.initialResultsHandler = { query, results, error in
            guard let results = results else {
                return
            }
            
            results.enumerateStatistics(
                from: startDate,
                to: endDate,
                with: { (result, stop) in
                    let totalStepForADay = result.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
                    if self.listTarget.walkNumber.firstIndex(where: {$0.date == result.startDate.toString(Constants.DATE_PARAM_FORMAT)}) == nil {
                        self.listTarget.walkNumber.append((step: totalStepForADay,
                                                           date:  castToString(result.startDate.toString(Constants.DATE_PARAM_FORMAT))))
                        if self.listTarget.walkNumber.count == 6 {
                            self.setParamWeekHealth(completion: completion)

                        }
                    }
                }
            )
        }
        
        healthStore.execute(query)
        
        let query1 = HKStatisticsCollectionQuery(
            quantityType: HKSampleType.quantityType(forIdentifier: .appleExerciseTime)!,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum,
            anchorDate: anchorDate!,
            intervalComponents: interval
        )
        
        query1.initialResultsHandler = { query, results, error in
            guard let results = results else {
                return
            }

            results.enumerateStatistics(
                from: startDate,
                to: endDate,
                with: { (result, stop) in
                    let totalStepForADay = result.sumQuantity()?.doubleValue(for: HKUnit.minute()) ?? 0
                    if self.listTarget.activity.firstIndex(where: {$0.date == result.startDate.toString(Constants.DATE_PARAM_FORMAT)}) == nil {
                        self.listTarget.activity.append((step: totalStepForADay,
                                                           date:  castToString(result.startDate.toString(Constants.DATE_PARAM_FORMAT))))
                        if self.listTarget.activity.count == 6 {
                            self.setParamWeekHealth(completion: completion)

                        }
                    }
                }
            )
        }

        healthStore.execute(query1)
        
        let anchorDate1 = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: Date())

        let query2 = HKStatisticsCollectionQuery(
            quantityType: HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum,
            anchorDate: anchorDate1!,
            intervalComponents: interval
        )
        
        query2.initialResultsHandler = { query, results, error in
            guard let results = results else {
                return
            }

            results.enumerateStatistics(
                from: startDate,
                to: endDate,
                with: { (result, stop) in
                    let totalStepForADay = result.sumQuantity()?.doubleValue(for: HKUnit.mile()) ?? 0
//                    if let index = self.listTarget.distance.firstIndex(where: {$0.date == result.startDate.toString(Constants.DATE_PARAM_FORMAT)}) {
//                        self.listTarget.distance[index].step += totalStepForADay
//                    } else {
//                        self.listTarget.distance.append((step: totalStepForADay,
//                                                           date:  castToString(result.startDate.toString(Constants.DATE_PARAM_FORMAT))))
//                    }
//                    if self.listTarget.distance.count == 6 {
//                        self.setParamWeekHealth(completion: completion)
//
//                    }
                    if self.listTarget.distance.firstIndex(where: {$0.date == result.startDate.toString(Constants.DATE_PARAM_FORMAT)}) == nil {
                        self.listTarget.distance.append((step: totalStepForADay,
                                                           date:  castToString(result.startDate.toString(Constants.DATE_PARAM_FORMAT))))
                        if self.listTarget.distance.count == 6 {
                            self.setParamWeekHealth(completion: completion)

                        }
                    }
                }
            )
        }

        healthStore.execute(query2)
        
        let query3 = HKStatisticsCollectionQuery(
            quantityType: HKSampleType.quantityType(forIdentifier: .heartRate)!,
            quantitySamplePredicate: predicate,
            options: .discreteAverage,
            anchorDate: anchorDate!,
            intervalComponents: interval
        )
        
        if let type = HKQuantityType.quantityType(forIdentifier: .heartRate) {
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            let query = HKSampleQuery(sampleType: type, predicate: nil, limit: 8, sortDescriptors: [sortDescriptor]) { (query, results, error) -> Void in
                var value: Double = 0

                if let error = error {
                    print(error)
                } else {
                    for (_, sample) in results!.enumerated() {
                        if let quantity = sample as? HKQuantitySample {
                            value = quantity.quantity.doubleValue(for: HKUnit(from: "count/min"))
                            self.listTarget.heartRate.append(value)
                        }
                    }
                }
            }
            healthStore.execute(query)
        }
        
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            let start = Date().addingTimeInterval(-3600 * 24 * 8)
            let end = Date().addingTimeInterval(-3600 * 24)
            
            let predicate = HKQuery.predicateForSamples(
                withStart: start,
                end: end,
                options: [.strictStartDate, .strictEndDate]
            )
            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 100000, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
                
                if error != nil {
                    print("something went wrong")
                    return
                }
                guard let result = tmpResult else { return }
                for item in result {
                    if let sample = item as? HKCategorySample {
                        let startDate = sample.startDate.addingTimeInterval(3600*7)
                        let endDate = sample.endDate
                        let sleepTimeForOneDay = sample.endDate.timeIntervalSince(sample.startDate)
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            if let index = self.listTarget.sleep.firstIndex(where: {$0.date == startDate.toString(Constants.DATE_PARAM_FORMAT)}) {
//                                if sleepTimeForOneDay/3600 > 1 {
                                    let sleep = self.listTarget.sleep[index].sleep + sleepTimeForOneDay/3600
                                    self.listTarget.sleep[index].sleep = sleep
//                                }
                            } else {
                                self.listTarget.sleep.append((sleep: (sleepTimeForOneDay/3600),
                                                                   date:  castToString(startDate.toString(Constants.DATE_PARAM_FORMAT))))
                            }
                            if self.listTarget.sleep.count == 6 {
                                self.listTarget.sleep.sort(by: {
                                    $0.date.formatToDate(Constants.DATE_PARAM_FORMAT) <
                                        $1.date.formatToDate(Constants.DATE_PARAM_FORMAT)})
                                self.setParamWeekHealth(completion: completion)

                            }
//                            if self.listTarget.sleep.firstIndex(where: {$0.date == startDate.toString(Constants.DATE_PARAM_FORMAT)}) == nil &&
//                                sleepTimeForOneDay/3600 > 2 {
//                                self.listTarget.sleep.append((sleep: (sleepTimeForOneDay/3600),
//                                                                   date:  castToString(startDate.toString(Constants.DATE_PARAM_FORMAT))))
//                                if self.listTarget.sleep.count == 6 {
//                                    self.listTarget.sleep = self.listTarget.sleep.reversed()
//                                    self.setParamWeekHealth(completion: completion)
//
//                                }
//                            }
                        }
                    }
                }
            }
            healthStore.execute(query)
        }
    }
}


