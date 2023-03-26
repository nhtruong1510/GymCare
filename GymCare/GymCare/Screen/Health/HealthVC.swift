//
//  HealthVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 25/02/2023.
//

import UIKit
import SwiftUI
import HGCircularSlider

class HealthVC: BaseViewController {

    @IBOutlet private weak var runSlider: CircularSlider!
    @IBOutlet private weak var runLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }

    private func configUI() {
//        runSlider.startThumbImage = UIImage(named: "Bedtime")
//        runSlider.endThumbImage = UIImage(named: "Wake")

//        let dayInSeconds = 24 * 60 * 60
//        runSlider.maximumValue = CGFloat(dayInSeconds)
        runSlider.minimumValue = 0.0
        runSlider.maximumValue = 1.0
        runSlider.endPointValue = 0.2
//        runSlider.startPointValue = 0 * 60 * 60
//        runSlider.endPointValue = 8 * 60 * 60
    }

    @IBAction private func createTarget() {
        let vc = CreateTargetVC()
        self.nextScreen(ctrl: vc)
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
