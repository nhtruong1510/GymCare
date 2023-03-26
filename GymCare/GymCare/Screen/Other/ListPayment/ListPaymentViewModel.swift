//
//  ListPaymentViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 26/03/2023.
//

import Foundation

final class ListPaymentViewModel: BaseViewModel {

    func callApiGetPayment(customerId: Int, completion: @escaping (PaymentModel?, String?) -> Void) {
        self.repository.getPayment(customerId: customerId) { data, msg in
            completion(data, msg)
        }
    }
}
