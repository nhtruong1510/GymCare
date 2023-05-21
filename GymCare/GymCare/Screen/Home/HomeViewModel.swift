//
//  HomeViewModel.swift
//  GymCare
//
//  Created by Nguyễn Hà on 01/01/2023.
//

import Foundation

class HomeViewModel: BaseViewModel {

    func callApiGetClasses(completion: @escaping (ClassModel?, String?) -> Void) {
        self.repository.getClasses(showLoading: true) { data, msg in
            completion(data, msg)
        }
    }
    
    func callApiGetNews(completion: @escaping ([NewsModel]?, String?) -> Void) {
        self.repository.getNews(showLoading: true) { data, msg in
            completion(data, msg)
        }
    }
    
    func executePushRemote(_ viewController: BaseViewController) {
        if let id = ServiceSettings.shared.pushInfoId {
            let vc = NotificationVC()
            vc.id = castToInt(id)
            viewController.nextScreen(ctrl: vc)
            ServiceSettings.shared.pushInfoId = nil
        }
    }
}
