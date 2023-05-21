//
//  UIView+Extension.swift
//
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set(value) {
            layer.cornerRadius = value
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set(value) {
            layer.borderWidth = value
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set(value) {
            layer.borderColor = value.cgColor
        }
    }

    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }

    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1]
     range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }

    /// The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    /// The blur radius used to create the shadow. Defaults to 3. Animatable.
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    func roundCorners(cornerRadius: CACornerMask, radius: CGFloat) {
        clipsToBounds = true
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerRadius
        }
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat, bound: CGRect?) {
        guard let bound = bound else {return}
        let path = UIBezierPath(roundedRect: bound, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        // setup MASK
        self.layer.mask = nil
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bound
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
        
        // setup Border for Mask
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.lineWidth = 0.5
        borderLayer.strokeColor = UIColor.white.withAlphaComponent(0.3).cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.frame = bound
        self.layer.addSublayer(borderLayer)
    }
    
    func setGradientBackground(colors: [UIColor], gradiantDirection: GradiantDirection = .topToBottom) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map {$0.cgColor}
        gradientLayer.masksToBounds = true
        gradientLayer.frame = self.bounds
        switch gradiantDirection {
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        gradientLayer.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    func addBlackGradientLayerInBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        let startColor = UIColor.black.withAlphaComponent(0).cgColor
        let endColor = UIColor.black.withAlphaComponent(0.7).cgColor
        gradient.colors = [startColor, endColor]
        self.layer.insertSublayer(gradient, at: 0)
    }

}

extension UIButton {
    func titleForState(_ state: UIControl.State = .normal) -> String? {
        if let title = self.title(for: state) {
            return title
        }

        if let attribTitle = self.attributedTitle(for: state) {
            return attribTitle.string
        }

        return nil
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIStackView {
    
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
    
}
