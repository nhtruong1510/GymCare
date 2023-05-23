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
        self.repository.getHealth(showLoading: false) { data, msg in
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
        createOrUpdateHealth(param: param) { _, _ in }
    }
}
