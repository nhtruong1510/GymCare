//
//  ImagePickerView.swift
//  SchoolUp
//
//  Created by Nguyen Ha on 02/02/2023.
//

import Foundation
import UIKit
import TLPhotoPicker
import Photos

class ImagePickerManager: NSObject, UINavigationControllerDelegate {

    var pickerCameraVC = UIImagePickerController()
    var pickerPhotoVC = TLPhotosPickerViewController()
    var chooseVideo: Bool = false
    var singleSelectedMode: Bool = false
    var alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    var viewController = UIViewController()
    var pickImageCallBack: (([TLPHAsset]) -> ())?
    var selectedAssets = [TLPHAsset]()

    override init() {
        super.init()
        alert.addAction(UIAlertAction(title: "Chụp ảnh", style: .default , handler:{ _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Lấy từ thư viện", style: .default , handler:{ _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler:{ _ in
            
        }))
    }

    func pickImage(_ viewController: UIViewController, chooseVideo: Bool = true, singleSelectedMode: Bool = false, _ callback: @escaping (([TLPHAsset]) -> ())) {
        pickImageCallBack = callback
        self.viewController = viewController
        self.chooseVideo = chooseVideo
        self.singleSelectedMode = singleSelectedMode
        alert.popoverPresentationController?.sourceView = self.viewController.view
        viewController.present(alert, animated: true, completion: nil)
    }

    private func openGallery() {
        alert.dismiss(animated: true)
        pickerPhotoVC.delegate = self
        var configure = TLPhotosPickerConfigure()
        configure.usedCameraButton = false
        configure.allowedVideo = chooseVideo
        configure.allowedVideoRecording = false
        configure.singleSelectedMode = singleSelectedMode
        pickerPhotoVC.configure = configure
        pickerPhotoVC.selectedAssets = selectedAssets
        self.viewController.present(pickerPhotoVC, animated: true, completion: nil)
    }

    private func openCamera() {
        pickerCameraVC.delegate = self
        pickerCameraVC.sourceType = .camera
        self.viewController.present(pickerCameraVC, animated: true)
    }

}

extension ImagePickerManager: TLPhotosPickerViewControllerDelegate {

    func shouldDismissPhotoPicker(withTLPHAssets: [TLPHAsset]) -> Bool {
        self.selectedAssets = withTLPHAssets
        return true
    }

    func dismissComplete() {
        pickImageCallBack?(selectedAssets)
    }

}

extension ImagePickerManager: UIImagePickerControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
    }

}
