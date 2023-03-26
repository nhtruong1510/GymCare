//
//  UIImageView+Extension.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 31/12/2022.
//

import Foundation
import SDWebImage

extension UIImageView {

    func loadImage(urlString: String?, placehoderImage: UIImage = #imageLiteral(resourceName: "no_image")) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: castToString(urlString).encodingUTF8())) { [weak self] (image: UIImage?, _, _, _) in
            self?.image = image != nil ? image : placehoderImage
        }
    }

    func loadImageResize(urlString: String?, targeSize: CGSize? = nil, placehoderImage: UIImage = #imageLiteral(resourceName: "no_image")) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: castToString(urlString).encodingUTF8())) { [weak self] (image: UIImage?, _, _, _) in
            var size = CGSize()
            if targeSize == nil {
                size = CGSize(width: screenWidth, height: screenHeight)
            } else {
                size = targeSize!
            }
            let image = self?.resizeImage(image: image ?? UIImage(), targetSize: size)
            self?.image = image != nil ? image : placehoderImage
        }
    }

    func changeImageTintColor(_ color: UIColor) {
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    func resizeImage(image: UIImage?) {
        guard let image = image else { return }
        let size = image.size
        
        let ratio  = size.width  / size.height
        let heightRatio = screenWidth / ratio

        // Figure out what our orientation is, and use that to form the rectangle
        let newSize = CGSize(width: screenWidth, height: heightRatio)

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = newImage
    }

}

extension UIImage {
    
    var getWidth: CGFloat {
        get {
            let width = self.size.width
            return width
        }
    }
    
    var getHeight: CGFloat {
        get {
            let height = self.size.height
            return height
        }
    }

    class func colorForNavBar(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)

        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
