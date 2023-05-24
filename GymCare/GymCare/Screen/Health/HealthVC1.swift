//
//  HealthVC1.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 17/05/2023.
//

import UIKit
import SwiftUI
import HGCircularSlider
import HealthKit

class HealthVC1: BaseViewController {
    
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
    private var listHealth: [TargetHealth] = []
    private var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        getDataTarget()
        authorizeHealthKit()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        loadInfoHealth(target: target?.target)
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
        viewModel.getDataHealthOfWeek() {
            self.getDataHealth()
        }
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
        let health = listHealth[index]
        dateLabel.text = formatDateString(dateString: castToString(health.date),
                                          Constants.DATE_PARAM_FORMAT,
                                          Constants.DATE_FORMAT)
        if dateLabel.text == Date().toString(Constants.DATE_FORMAT) {
            dateLabel.text = "Hôm nay"
        }
        self.runLabel.text = castToString(castToInt(health.step))
        self.run1Label.text = castToString(castToInt(health.step))
        if castToInt(target?.target?.walkNumber) != 0 {
            self.runSlider.endPointValue = CGFloat(castToDouble(health.step)/castToDouble(target?.target?.walkNumber))
            self.completeRun = self.runSlider.endPointValue == 1 ? 1 : 0
        }

        self.activityLabel.text = castToString(castToInt(health.excercise))
        if castToInt(target?.target?.distance) != 0 {
            self.activitySlider.endPointValue = CGFloat(castToDouble(health.excercise)/castToDouble(target?.target?.distance))
            self.completeActivity = self.activitySlider.endPointValue == 1 ? 1 : 0
        }

        self.sleepLabel.text = castToString(health.sleep?.rounded(toPlaces: 1))
        if castToInt(target?.target?.sleep) != 0 {
            self.sleepSlider.endPointValue = CGFloat(castToDouble(health.sleep)/castToDouble(target?.target?.sleep))
            self.completeSleep = self.sleepSlider.endPointValue == 1 ? 1 : 0
        }
        let sleep = health.sleep
        let minute = sleep?.truncatingRemainder(dividingBy: 1)
        self.sleep1Label.text = castToString(castToInt(sleep))
        self.sleepMinuteLabel.text = castToString(castToInt(castToDouble(minute)*60))
        updateCompleteTarget()
        
        self.distanceLabel.text = castToString(health.distance?.rounded(toPlaces: 2))
        
        self.heartLabel.text = castToString(health.heartRate)
        let lastHealth = listHealth[listHealth.count - 1]
        guard let step = lastHealth.step, let sleep = lastHealth.sleep,
                let distance = lastHealth.distance, let heartRate = lastHealth.heartRate,
              lastHealth.date == Date().toString(Constants.DATE_PARAM_FORMAT),
                index == listHealth.count - 1 else { return }
        let param = TargetParamObject(distanceHealth: distance, walk_number: step, sleepHealth: sleep,
                                      heartRate: heartRate, excercise: castToInt(lastHealth.excercise), date: Date().toString(Constants.DATE_PARAM_FORMAT))
        viewModel.createOrUpdateHealth(param: param) { _, _ in }
    }
    
    @IBAction func previousDateClick() {
        guard index > 0 else {
            prevButton.setImage(nil, for: .normal)
            return
        }
        nextButton.setImage(.init(systemName: "arrow.right"), for: .normal)
        prevButton.setImage(.init(systemName: "arrow.left"), for: .normal)
        index -= 1
        if index == 0 {
            prevButton.setImage(nil, for: .normal)
        }
        DispatchQueue.main.async {
            self.setTargetView()
        }
    }
    
    @IBAction func nextDateClick() {
        guard index < listHealth.count - 1 else {
            nextButton.setImage(nil, for: .normal)
            return
        }
        nextButton.setImage(.init(systemName: "arrow.right"), for: .normal)
        prevButton.setImage(.init(systemName: "arrow.left"), for: .normal)
        index += 1
        if index == listHealth.count - 1 {
            nextButton.setImage(nil, for: .normal)
        }
        DispatchQueue.main.async {
            self.setTargetView()
        }
    }

    private func loadInfoHealth() {
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
                        self.listHealth[self.listHealth.count - 1].step = castToInt(value)
                        self.setTargetView()
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
                        self.listHealth[self.listHealth.count - 1].distance = value
                        self.setTargetView()
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
                        self.listHealth[self.listHealth.count - 1].excercise = castToInt(value)
                        self.setTargetView()
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
                            self.listHealth[self.listHealth.count - 1].heartRate = castToInt(value)
                            DispatchQueue.main.async {
                                self.setTargetView()
                            }
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
                                self.listHealth[self.listHealth.count - 1].sleep = sleepTimeForOneDay/3600
                                self.setTargetView()
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
//            self.setTargetView()
            self.targetButton.setTitle(titleButton, for: .normal)
            self.targetView.isHidden = result?.target == nil
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    private func getDataHealth() {
        viewModel.callApiGetHealth() { [weak self] result, error in
            guard let `self` = self else { return }
            if let error = error {
                AlertVC.show(viewController: self, msg: error)
                return
            }
            if let result = result {
                self.listHealth = result
                self.listHealth.sort(by: {
                    $0.date?.formatToDate(Constants.DATE_PARAM_FORMAT) ?? Date() <
                        $1.date?.formatToDate(Constants.DATE_PARAM_FORMAT) ?? Date()})
                if self.listHealth.count > 0 {
                    if self.listHealth[self.listHealth.count - 1].date != Date().toString(Constants.DATE_PARAM_FORMAT) {
                        let health = TargetHealth()
                        health.date = Date().toString(Constants.DATE_PARAM_FORMAT)
                        self.listHealth.append(health)
                    }
                    self.index = self.listHealth.count - 1
                    self.setTargetView() 
                }
                if self.listHealth.count == 0 {
                    let health = TargetHealth()
                    health.date = Date().toString(Constants.DATE_PARAM_FORMAT)
                    self.listHealth.append(health)
                    self.prevButton.setImage(nil, for: .normal)
                }
                self.loadInfoHealth()

            }
        }
    }
}

// 3
struct HealthVC1Representation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = HealthVC1
    
    // 5
    func makeUIViewController(context: Context) -> HealthVC1 {
        HealthVC1()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: HealthVC1, context: Context) {
        
    }
}

