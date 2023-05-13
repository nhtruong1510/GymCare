//
//  HealthVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 25/02/2023.
//

import UIKit
import SwiftUI
import HGCircularSlider
import HealthKit

class HealthVC: BaseViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var targetView: UIView!
    @IBOutlet private weak var runSlider: CircularSlider!
    @IBOutlet private weak var runLabel: UILabel!
    @IBOutlet private weak var sleepSlider: CircularSlider!
    @IBOutlet private weak var sleepLabel: UILabel!
    @IBOutlet private weak var activitySlider: CircularSlider!
    @IBOutlet private weak var activityLabel: UILabel!
    @IBOutlet private weak var run1Label: UILabel!
    @IBOutlet private weak var sleep1Label: UILabel!
    @IBOutlet private weak var sleepMinuteLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var heartLabel: UILabel!
    @IBOutlet private weak var completeLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var prevButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var targetButton: UIButton!

    private let viewModel = HealthViewModel()
    private let userHealthProfile = UserHealthProfile()
    private let userInfo = ServiceSettings.shared.userInfo
    private var target: TargetModel?
    private var completeRun: Int = 0
    private var completeSleep: Int = 0
    private var completeActivity: Int = 0
    private var listTarget: TargetList = TargetList()
    private var index: Int = 7

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getDataTarget()
        authorizeHealthKit()
        configUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadInfoHealth(target: target?.target)
    }
    
    private func configUI() {
        runSlider.minimumValue = 0.0
        runSlider.maximumValue = 1.0
        runSlider.endPointValue = 0.0
        
        sleepSlider.minimumValue = 0.0
        sleepSlider.maximumValue = 1.0
        sleepSlider.endPointValue = 0.0
        
        activitySlider.minimumValue = 0.0
        activitySlider.maximumValue = 1.0
        activitySlider.endPointValue = 0.0
        NotificationCenter.default.addObserver(self, selector: #selector(self.getDataTarget), name: .RELOAD_HEALTH_SCREEN, object: nil)
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(self.getDataTarget), for: .valueChanged)
    }
    
    private func authorizeHealthKit() {
        
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
        }
        
    }
    
    private func updateCompleteTarget() {
        completeLabel.text = "Bạn đã hoàn thành \(completeRun + completeSleep + completeActivity)/3 mục tiêu trong ngày \(castToString(dateLabel.text))"
    }
    
    private func resetCompleteTarget() {
        completeRun = 0
        completeSleep = 0
        completeActivity = 0
    }
    
    private func setTargetView() {
        resetCompleteTarget()
        if index < listTarget.walkNumber.count {
            dateLabel.text = listTarget.walkNumber[index].date
            if dateLabel.text == Date().toString(Constants.DATE_FORMAT) {
                dateLabel.text = "Hôm nay"
            }
            self.runLabel.text = castToString(castToInt(listTarget.walkNumber[index].step))
            self.run1Label.text = castToString(castToInt(listTarget.walkNumber[index].step))
            if castToInt(target?.target?.walkNumber) != 0 {
                self.runSlider.endPointValue = CGFloat(listTarget.walkNumber[index].step/castToDouble(target?.target?.walkNumber))
                self.completeRun = self.runSlider.endPointValue == 1 ? 1 : 0
            }
        }

        if index < listTarget.activity.count {
            self.activityLabel.text = castToString(castToInt(listTarget.activity[index].step))
            if castToInt(target?.target?.distance) != 0 {
                self.activitySlider.endPointValue = CGFloat(castToDouble(listTarget.activity[index].step)/castToDouble(target?.target?.distance))
                self.completeActivity = self.activitySlider.endPointValue == 1 ? 1 : 0
                self.updateCompleteTarget()
            }
        }

        if index < listTarget.sleep.count {
            self.sleepLabel.text = castToString(listTarget.sleep[index].sleep.rounded(toPlaces: 1))
            if castToInt(target?.target?.sleep) != 0 {
                self.sleepSlider.endPointValue = CGFloat(castToDouble(listTarget.sleep[index].sleep)/castToDouble(target?.target?.sleep))
                self.completeSleep = self.sleepSlider.endPointValue == 1 ? 1 : 0
                self.updateCompleteTarget()
            }
            let sleep = self.listTarget.sleep[index].sleep
            let minute = sleep.truncatingRemainder(dividingBy: 1)
            self.sleep1Label.text = castToString(castToInt(sleep))
            self.sleepMinuteLabel.text = castToString(castToInt(minute*60))
            updateCompleteTarget()
        }
        
        if index < listTarget.distance.count {
            self.distanceLabel.text = castToString(listTarget.distance[index].step.rounded(toPlaces: 2))
        }
        
        if index < listTarget.heartRate.count {
            self.heartLabel.text = castToString(castToInt(listTarget.heartRate[index]))
        }
    }
    
    @IBAction func previousDateClick() {
        guard index > 0 else {
            prevButton.setImage(nil, for: .normal)
            return
        }
        nextButton.setImage(.init(systemName: "arrow.right"), for: .normal)
        prevButton.setImage(.init(systemName: "arrow.left"), for: .normal)
        index -= 1
        setTargetView()
    }
    
    @IBAction func nextDateClick() {
        guard index < 7 else {
            nextButton.setImage(nil, for: .normal)
            return
        }
        nextButton.setImage(.init(systemName: "arrow.right"), for: .normal)
        prevButton.setImage(.init(systemName: "arrow.left"), for: .normal)
        index += 1
        setTargetView()
    }

    private func loadInfoHealth(target: Target?) {
        let healthStore = HKHealthStore()
        
        if target != nil || target == nil {
            let startDate = Date().addingTimeInterval(3600 * 7).addingTimeInterval(-3600 * 24 * 7)
            let endDate = Date().addingTimeInterval(3600 * 7)
            
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
            let anchorDate = calendar.date(bySettingHour: 12, minute: 0, second: 0, of: Date().addingTimeInterval(3600 * 7))
            
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
                        if self.listTarget.walkNumber.firstIndex(where: {$0.date == result.startDate.toString(Constants.DATE_FORMAT)}) == nil {
                            self.listTarget.walkNumber.append((step: totalStepForADay,
                                                               date:  castToString(result.startDate.toString(Constants.DATE_FORMAT))))
                            if self.listTarget.walkNumber.count == 8 {
                                DispatchQueue.main.async {
//                                    if self.listTarget.walkNumber[7].date != Date().toString() {
//                                        self.listTarget.walkNumber.append((step: castToDouble(castToString(self.run1Label.text)) ,
//                                                                        date: Date().toString()))
//                                    }
                                    self.run1Label.text = castToString(castToInt(self.listTarget.walkNumber[7].step))
                                    self.setTargetView()
                                }
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
                        if self.listTarget.activity.firstIndex(where: {$0.date == result.startDate.toString(Constants.DATE_FORMAT)}) == nil {
                            self.listTarget.activity.append((step: totalStepForADay,
                                                               date:  castToString(result.startDate.toString(Constants.DATE_FORMAT))))
                            if self.listTarget.activity.count == 8 {
                                DispatchQueue.main.async {
                                    self.setTargetView()
                                }
                            }
                        }
                    }
                )
            }

            healthStore.execute(query1)
            
            let query2 = HKStatisticsCollectionQuery(
                quantityType: HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                quantitySamplePredicate: predicate,
                options: .cumulativeSum,
                anchorDate: anchorDate!,
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
                        if self.listTarget.distance.firstIndex(where: {$0.date == result.startDate.toString(Constants.DATE_FORMAT)}) == nil {
                            self.listTarget.distance.append((step: totalStepForADay,
                                                               date:  castToString(result.startDate.toString(Constants.DATE_FORMAT))))
                            if self.listTarget.distance.count == 8 {
                                DispatchQueue.main.async {
                                    self.setTargetView()
                                }
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
            query3.initialResultsHandler = { query, results, error in
                guard let results = results else {
                    return
                }

                results.enumerateStatistics(
                    from: startDate,
                    to: endDate,
                    with: { (result, stop) in
                        let totalStepForADay = result.sumQuantity()?.doubleValue(for: HKUnit(from: "count/min")) ?? 0
//                        if self.listTarget.heartRate.firstIndex(where: {$0.date == result.startDate.toString(Constants.DATE_FORMAT)}) == nil {
//                            self.listTarget.heartRate.append((step: totalStepForADay,
//                                                               date:  castToString(result.startDate.toString(Constants.DATE_FORMAT))))
//                            if self.listTarget.heartRate.count == 8 {
//                                DispatchQueue.main.async {
//                                    self.setTargetView()
//                                }
//                            }
//                        }
                    }
                )
            }
            healthStore.execute(query3)
        }
        
        let date =  Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: Date(), options: .strictStartDate)
        
//        if let type = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning) {
//            let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
//                var value: Double = 0
//
//                if error != nil {
//                    print("something went wrong")
//                } else if let quantity = statistics?.sumQuantity() {
//                    value = quantity.doubleValue(for: HKUnit.mile())
//                    DispatchQueue.main.async {
//                        self.distanceLabel.text = castToString(value.rounded(toPlaces: 2))
//                    }
//                }
//            }
//            healthStore.execute(query)
//        }
        
//        if let type = HKSampleType.quantityType(forIdentifier: .stepCount) {
//            let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: [.cumulativeSum]) { (query, statistics, error) in
//                var value: Double = 0
//
//                if error != nil {
//                    print("something went wrong")
//                } else if let quantity = statistics?.sumQuantity() {
//                    value = quantity.doubleValue(for: HKUnit.count())
//                    DispatchQueue.main.async {
//                        self.run1Label.text = castToString(castToInt(value))
//                    }
//                }
//            }
//            healthStore.execute(query)
//        }
        
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
                        let minute = (sleepTimeForOneDay/3600).truncatingRemainder(dividingBy: 1)
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            if self.listTarget.sleep.firstIndex(where: {$0.date == startDate.toString(Constants.DATE_FORMAT)}) == nil &&
                                sleepTimeForOneDay/3600 > 2 {
                                self.listTarget.sleep.append((sleep: (sleepTimeForOneDay/3600),
                                                                   date:  castToString(startDate.toString(Constants.DATE_FORMAT))))
                                if self.listTarget.sleep.count == 8 {
                                    self.listTarget.sleep = self.listTarget.sleep.reversed()
                                    DispatchQueue.main.async {
                                        self.setTargetView()
                                    }
                                }
                            }
                            if self.listTarget.sleep.count > 0 {
                                let sleep = self.listTarget.sleep[self.listTarget.sleep.count - 1].sleep
                                let minute = sleep.truncatingRemainder(dividingBy: 1)
                                self.sleep1Label.text = castToString(castToInt(sleep))
                                self.sleepMinuteLabel.text = castToString(castToInt(minute*60))
                            }
                        }
                    }
                }
            }
            healthStore.execute(query)
        }
        
    }
    
    @IBAction private func createTarget() {
        let vc = CreateTargetVC()
        vc.target = target?.target
        vc.onClick = {
            self.getDataTarget()
            self.resetCompleteTarget()
        }
        self.nextScreen(ctrl: vc)
        
    }
    
    @objc private func refresh(_: AnyObject) {
        getDataTarget()
    }
    
    @objc private func getDataTarget() {
        viewModel.callApiGetTrainer(customerId: castToInt(userInfo?.id)) { [weak self] result, error in
            guard let `self` = self else { return }
            if let error = error {
                AlertVC.show(viewController: self, msg: error)
                return
            }
            let titleButton = result?.target == nil ? "Tạo mục tiêu" : "Sửa mục tiêu"
            self.target = result
            self.loadInfoHealth(target: result?.target)
            self.setTargetView()
            self.targetButton.setTitle(titleButton, for: .normal)
            self.targetView.isHidden = result?.target == nil
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
}

// 3
struct HealthVCRepresentation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = HealthVC
    
    // 5
    func makeUIViewController(context: Context) -> HealthVC {
        HealthVC()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: HealthVC, context: Context) {
        
    }
}
