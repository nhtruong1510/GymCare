//
//  NotifiDetailViewModel.swift
//
//  Created by Truong Nguyen Huu on 19/08/2022.
//

import Foundation

final class NotifiDetailViewModel: BaseViewModel {
    func updateStatusNoti(notiId: Int, completion: @escaping () -> Void) {
        self.repository.updateStatusNoti(notiId: notiId) { data, msg in
            completion()
        }
    }
}
