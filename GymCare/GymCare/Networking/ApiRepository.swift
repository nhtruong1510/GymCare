//
//  ProfileRepository.swift
//  GymCare
//
//

import Foundation
import UIKit

protocol IApiRepository {
//    func callApiLogin(email: String, pass: String, completion: @escaping (LoginResponse?, String?) -> Void)
    func callApiForgotPass(email: String, completion: @escaping (Bool, String?) -> Void)
    func resetPass(token: String, pass: String, confirmPass: String, completion: @escaping (Bool, String?) -> Void)
}

class ApiRepository: IApiRepository {
    func callApiRegister(phone: String, name: String, pass: String, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.register(phone, name, pass)) { result in
            switch result {
            case let .success(res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status
                {
                    completion(status, response.message)
                }
            case let .failure(err):
                completion(false, err.localizedDescription)
            }
        }
    }

    func callApiEditProfile(param: UserModel, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.editProfile(param)) { result in
            switch result {
            case let .success(res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status
                {
                    completion(status, response.message)
                }
            case let .failure(err):
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func getUserDetail(id: Int, completion: @escaping (UserModel?, String?) -> Void) {
        NetworkManager().moyaProvider.request(.getUser(id)) { result in
            switch result {
            case let .success(res):
                if let response = try? JSONDecoder().decode(ResponseModel<UserModel>.self, from: res.data),
                   let status = response.status
                {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case let .failure(err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func callApiForgotPass(email: String, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.resetPass(email)) { result in
            switch result {
            case .success(let res):
                struct IdResponse: Codable {
                    var id: String
                }
                if let response = try? JSONDecoder().decode(ResponseModel<IdResponse>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.errorDescription)
            }
        }
    }
    
    func resetPass(token: String, pass: String, confirmPass: String, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.updatePass(pass, confirmPass, token)) { result in
            switch result {
            case .success(let res):
                struct IdResponse: Codable {
                    var id: String
                }
                if let response = try? JSONDecoder().decode(ResponseModel<IdResponse>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.errorDescription)
            }
        }
    }
    
    func changePass(oldPass: String, pass: String, confirmPass: String, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.changePass(pass, confirmPass, oldPass)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                    let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.errorDescription)
            }
        }
    }

    func callApiLogin(email: String, pass: String, completion: @escaping (UserModel?, String?) -> Void) {
        NetworkManager().moyaProvider.request(.login(email, pass)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<UserModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let error):
                completion(nil, error.errorDescription)
            }
        }
    }

    func getTopics(showLoading: Bool, customerId: Int, completion: @escaping (TopicModel?, String?) -> Void) {
        NetworkManager(showLoading: showLoading).moyaProvider.request(.getTopics(customerId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<TopicModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }

    func getTopicDetail(showLoading: Bool, id: Int, completion: @escaping (TopicDetailModel?, String?) -> Void) {
        NetworkManager(showLoading: showLoading).moyaProvider.request(.getTopicDetail(id)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<TopicDetailModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }

    func chatMessage(id: Int, content: String, ins_datetime: String, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.chatMessage(castToString(id), content, ins_datetime)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func getClasses(showLoading: Bool, completion: @escaping (ClassModel?, String?) -> Void) {
        NetworkManager(showLoading: showLoading).moyaProvider.request(.getClass) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<ClassModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getClassInfo(classId: Int, completion: @escaping (ClassModel?, String?) -> Void) {
        NetworkManager().moyaProvider.request(.getClassInfo(classId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<ClassModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getAddress(classId: Int, completion: @escaping (AddressModel?, String?) -> Void) {
        NetworkManager().moyaProvider.request(.getAddress(classId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<AddressModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getTrainer(trainerId: Int, completion: @escaping (Trainer?, String?) -> Void) {
        NetworkManager().moyaProvider.request(.getTrainer(trainerId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<Trainer>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }

    func getReloadChatDetail(id: Int, time: String, completion: @escaping (TopicDetailModel?, String?) -> Void) {
        NetworkManager(showLoading: false).moyaProvider.request(.getReloadChatDetail(id, time)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<TopicDetailModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func createSchedule(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.createSchedule(param)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func updateSchedule(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.updateSchedule(param)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func cancelSchedule(timeId: Int, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.cancelSchedule(timeId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func getSchedule(showLoading: Bool, customerId: Int, completion: @escaping (ScheduleModel?, String?) -> Void) {
        NetworkManager(showLoading: showLoading).moyaProvider.request(.getSchedule(customerId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<ScheduleModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getNotification(customerId: Int, completion: @escaping (NotificationModel?, String?) -> Void) {
        NetworkManager().moyaProvider.request(.getNotification(customerId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<NotificationModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func createNoti(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.createNoti(param)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func updateStatusNoti(notiId: Int, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager(showLoading: false).moyaProvider.request(.updateStatusNoti(notiId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func getPayment(customerId: Int, completion: @escaping (PaymentModel?, String?) -> Void) {
        NetworkManager().moyaProvider.request(.payment(customerId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<PaymentModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getTarget(customerId: Int, completion: @escaping (TargetModel?, String?) -> Void) {
        NetworkManager(showLoading: false).moyaProvider.request(.getTarget(customerId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<TargetModel>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func createTarget(param: TargetParamObject, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.createTarget(param)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func updateTarget(param: TargetParamObject, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager().moyaProvider.request(.updateTarget(param)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
            }
        }
    }
    
    func getNews(showLoading: Bool, completion: @escaping ([NewsModel]?, String?) -> Void) {
        NetworkManager(showLoading: showLoading).moyaProvider.request(.news) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<[NewsModel]>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func check(vnp_Amount: Int, vnp_ExpireDate: String, completion: @escaping (String?, String?) -> Void) {
        NetworkManager().moyaProvider.request(.check(vnp_Amount, vnp_ExpireDate)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponsePaymentModel<String>.self, from: res.data) {
                    completion(response.message, response.data)
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func getHealth(showLoading: Bool, completion: @escaping ([TargetHealth]?, String?) -> Void) {
        NetworkManager(showLoading: showLoading).moyaProvider.request(.getHealth) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<[TargetHealth]>.self, from: res.data),
                   let status = response.status {
                    if status {
                        completion(response.data, nil)
                    } else {
                        completion(nil, response.message)
                    }
                }
            case .failure(let err):
                completion(nil, err.localizedDescription)
            }
        }
    }
    
    func createOrUpdateHealth(param: TargetParamObject, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager(showLoading: false).moyaProvider.request(.createOrUpdateHealth(param)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
            }
        }
    }
}
