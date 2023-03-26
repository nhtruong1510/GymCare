//
//  NotificationViewModel.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 16/03/2023.
//

import Foundation

final class NotificationViewModel: BaseViewModel {

    func callApiGetSchedule(customerId: Int, completion: @escaping (NotificationModel?, String?) -> Void) {
        self.repository.getNotification(customerId: customerId) { data, msg in
            completion(data, msg)
        }
    }
    
    func callApiUpdateStatus(notiId: Int, completion: @escaping () -> Void) {
        self.repository.updateStatusNoti(notiId: notiId) { data, msg in
            completion()
        }
    }
}
