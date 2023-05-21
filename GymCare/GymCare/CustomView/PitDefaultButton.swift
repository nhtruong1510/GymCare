//
//  DefaultButton.swift
//  GymCare
//
//

import UIKit

class PitDefaultButton: UIButton {

    @IBInspectable
    var typeThin: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configUI()
    }
    
    private func configUI() {
        self.layer.cornerRadius = self.frame.height / 2
        if typeThin {
            self.titleLabel?.font = UIFont.Light(size: 14)
            self.setTitleColor(UIColor.main_color, for: .normal)
            self.backgroundColor = .clear
        } else {
            self.titleLabel?.font = UIFont.Bold(size: 18)
            self.setTitleColor(.white, for: .normal)
            self.layer.shadowOpacity = 0
            self.backgroundColor = UIColor.main_color
        }
    }

    private func updateLayerProperties() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 3.0
        self.layer.masksToBounds = false
    }
}
