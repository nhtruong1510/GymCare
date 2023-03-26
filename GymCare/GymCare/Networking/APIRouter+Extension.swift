//
//  APIRouter+Extension.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 27/01/2023.
//

import UIKit
import Moya

extension APIRouter {
    func createForm(dictionary: [String: Any]) -> [Moya.MultipartFormData] {
        var formData = [Moya.MultipartFormData]()
        for (key, value) in dictionary {
            if let value = (value as AnyObject).data(using: String.Encoding.utf8.rawValue) {
                let paramPart = MultipartFormData(provider: .data(value), name: key)
                formData.append(paramPart)
            }
        }
        return formData
    }

    func createMultipartFormData(listImage: [UIImage], fileName: String) -> [Moya.MultipartFormData] {
        var formData = [Moya.MultipartFormData]()
        for (index, file) in listImage.enumerated() {
//            let imageData = ImageCompresor()
//            imageData.image = file
//            imageData.shrinkImage(Constants.MAX_UPLOAD_IMAGE)
//            formData.append(MultipartFormData(provider: .data(imageData.data),
//                                              name: fileName + "[\(index)]",
//                                              fileName: "image\(index).jpg",
//                                              mimeType: "image/jpeg"))
        }
        return formData
    }

    func addAvatar(image: UIImage) -> [Moya.MultipartFormData] {
        var formData = [Moya.MultipartFormData]()
//        let imageData = ImageCompresor()
//        imageData.image = image
//        imageData.shrinkImage(Constants.MAX_UPLOAD_IMAGE)
//        formData.append(MultipartFormData(provider: .data(imageData.data),
//                                          name: "avatar",
//                                          fileName: "image.jpg",
//                                          mimeType: "image/jpeg"))
        return formData
    }

    func getDataChatMessage(id: Int, message: String, image: UIImage?, idName: String? = "topic_id") -> [MultipartFormData] {
        var formData = [Moya.MultipartFormData]()
        let topicIdData = "\(id)".data(using: String.Encoding.utf8) ?? Data()
        formData.append(MultipartFormData(provider: .data(topicIdData),
                                               name: castToString(idName)))
        let messageData = message.data(using: String.Encoding.utf8) ?? Data()
        formData.append(MultipartFormData(provider: .data(messageData),
                                               name: "content"))
        if let file = image {
//            let imageData = ImageCompresor()
//            imageData.image = file
//            imageData.shrinkImage(Constants.MAX_UPLOAD_IMAGE)
//            formData.append(MultipartFormData(provider: .data(imageData.data),
//                                              name: "files"))
        }
        return formData
    }

}
