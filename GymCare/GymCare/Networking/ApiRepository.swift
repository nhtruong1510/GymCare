//
//  ProfileRepository.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 29/12/2022.
//

import Foundation
import UIKit

protocol IApiRepository {
//    func callApiLogin(email: String, pass: String, completion: @escaping (LoginResponse?, String?) -> Void)
    func callApiForgotPass(email: String, completion: @escaping (Bool, String?) -> Void)
    func resetPass(token: String, pass: String, confirmPass: String, completion: @escaping (Bool, String?) -> Void)
}

class ApiRepository: IApiRepository {
    func callApiForgotPass(email: String, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager.request(.resetPass(email)) { result in
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
        NetworkManager.request(.updatePass(pass, confirmPass, token)) { result in
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
        NetworkManager.request(.changePass(pass, confirmPass, oldPass)) { result in
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
        NetworkManager.request(.login(email, pass)) { result in
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

    func getTopics(page: Int, completion: @escaping (TopicModel?, String?) -> Void) {
        NetworkManager.request(.getTopics(page)) { result in
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

    func getTopicDetail(id: Int, completion: @escaping (TopicDetailModel?, String?) -> Void) {
        NetworkManager.request(.getTopicDetail(id)) { result in
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

    func chatMessage(id: Int, content: String, image: UIImage?, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager.request(.chatMessage(id, content, image)) { result in
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
    
    func logout(completion: @escaping (Bool, String?) -> Void) {
        NetworkManager.request(.logout) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<String>.self, from: res.data),
                   let status = response.status {
                    completion(status, response.message)
                }
            case .failure(let err):
                completion(false, err.localizedDescription)
                break
            }
        }
    }

    func getChatDetail(id: Int, page: Int, completion: @escaping (TopicDetailModel?, String?) -> Void) {
        NetworkManager.request(.getChatDetail(id, page)) { result in
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
    
    func getClasses(completion: @escaping (ClassModel?, String?) -> Void) {
        NetworkManager.request(.getClass) { result in
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
        NetworkManager.request(.getClassInfo(classId)) { result in
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
        NetworkManager.request(.getAddress(classId)) { result in
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
    
    func getTrainer(trainerId: Int, completion: @escaping (TrainerModel?, String?) -> Void) {
        NetworkManager.request(.getTrainer(trainerId)) { result in
            switch result {
            case .success(let res):
                if let response = try? JSONDecoder().decode(ResponseModel<TrainerModel>.self, from: res.data),
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
        NetworkManager.request(.getReloadChatDetail(id, time)) { result in
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
    
    func sendChatMessage(id: Int, content: String, image: UIImage?, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager.request(.sendChatMessage(id, content, image)) { result in
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
    
    func createSchedule(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        NetworkManager.request(.createSchedule(param)) { result in
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
        NetworkManager.request(.updateSchedule(param)) { result in
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
        NetworkManager.request(.cancelSchedule(timeId)) { result in
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
    
    func getSchedule(customerId: Int, completion: @escaping (ScheduleModel?, String?) -> Void) {
        NetworkManager.request(.getSchedule(customerId)) { result in
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
        NetworkManager.request(.getNotification(customerId)) { result in
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
        NetworkManager.request(.createNoti(param)) { result in
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
        NetworkManager.request(.updateStatusNoti(notiId)) { result in
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
        NetworkManager.request(.payment(customerId)) { result in
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
}
