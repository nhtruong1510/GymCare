//
//  HomeViewModel.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 01/01/2023.
//

import Foundation

class HomeViewModel: BaseViewModel {

    func callApiGetClasses(completion: @escaping (ClassModel?, String?) -> Void) {
        self.repository.getClasses { data, msg in
            completion(data, msg)
        }
    }
}
