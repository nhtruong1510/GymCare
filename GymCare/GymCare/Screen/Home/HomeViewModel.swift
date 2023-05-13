//
//  HomeViewModel.swift
//  SchoolUpTeacher
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
}
