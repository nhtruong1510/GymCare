//
//  PaymentViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 24/02/2023.
//

import Foundation
import SwiftDate

final class PaymentViewModel: BaseViewModel {
    func getSumSession(fromDate: String, toDate: String, day: String) -> Int {
        var days: [Date] = []
        if day.contains("2") {
            days.append(contentsOf: Date.datesForWeekday(.monday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("3") {
            days.append(contentsOf: Date.datesForWeekday(.tuesday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("4") {
            days.append(contentsOf: Date.datesForWeekday(.wednesday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("5") {
            days.append(contentsOf: Date.datesForWeekday(.thursday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("6") {
            days.append(contentsOf: Date.datesForWeekday(.friday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("7") {
            days.append(contentsOf: Date.datesForWeekday(.saturday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        if day.contains("Chủ nhật") {
            days.append(contentsOf: Date.datesForWeekday(.sunday, from: fromDate.formatToDate(), to: toDate.formatToDate()))
        }
        return days.count
    }
    
    func getSumMonth(fromDate: String, toDate: String, day: String) -> Int {
        let fromMonth = formatDateString(dateString: fromDate, Constants.DATE_FORMAT, Constants.MONTH_STRING)
        let toMonth = formatDateString(dateString: toDate, Constants.DATE_FORMAT, Constants.MONTH_STRING)
        return castToInt(toMonth) - castToInt(fromMonth) + 1
    }
    
    func createSchedule(param: ScheduleParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.createSchedule(param: param) { success, msg in
            completion(success, msg)
        }
    }
    
    func check(vnp_Amount: Int, vnp_ExpireDate: String, completion: @escaping (String?, String?) -> Void) {
        self.repository.check(vnp_Amount: vnp_Amount, vnp_ExpireDate: vnp_ExpireDate) { success, msg in
            completion(success, msg)
        }
    }
    
    func callApiGetPayment(customerId: Int, completion: @escaping (PaymentModel?, String?) -> Void) {
        self.repository.getPayment(customerId: customerId) { data, msg in
            completion(data, msg)
        }
    }
    
    func setTokenZLP(amount: String?, completion: @escaping (String?) -> Void) {

        let currentDate = Date()
        let random = Int.random(in: 0...10000000)
       
        let appTransPrefix = GetCurrentDateInFormatYYMMDD()

        let appTransID = "\(appTransPrefix)_\(random)"
      
        let appId = 2554
        let appUser = "demo"
        let appTime = Int(currentDate.timeIntervalSince1970*1000)
        print(appTime)
        let embedData = "{}"
        let item = "[]"
        let description = "Merchant payment for order #" + appTransID

        let AmountInString: String = castToString(amount)
        
        let hmacInput = "\(appId)" + "|" + "\(appTransID)" + "|" + appUser + "|" + "\(AmountInString)" + "|" + "\(appTime)" + "|"
        + embedData + "|" + item
        
        let mac = hmacInput.hmac(algorithm: CryptoAlgorithm.SHA256, key: "sdngKKJmqEMzvh5QQcdD2A9XBSKUNaYn")//2554 sb

        //merchant can change the url to merchant's server endpoint which handle create zalopay order
        let url = URL(string: "https://sb-openapi.zalopay.vn/v2/create")!

        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let postString = "app_id=\(appId)&app_user=\(appUser)&app_time=\(appTime)&amount=\(AmountInString)&app_trans_id=\(appTransID)&embed_data=\(embedData)&item=\(item)&description=\(description)&mac=\(mac)"
        request.httpBody = postString.data(using: .utf8)
        DispatchQueue.main.async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return // check for fundamental networking error
                }

                // Getting values from JSON Response
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                    let returncode =  jsonResponse?.object(forKey: "return_code") as? Int
                    if returncode != 1{
                        DispatchQueue.main.async {
                            print("Create order failed, error:\(String(describing: returncode))")
                        }
                    } else {
                        let zptranstoken = jsonResponse?.object(forKey: "zp_trans_token") as? String
                        DispatchQueue.main.async {
                            completion(zptranstoken)
                            print(zptranstoken)
                        }
                    }
                } catch _ {
                    print ("OOps not good JSON formatted response")
                }
            }
            task.resume()
        }
    }

    func GetCurrentDateInFormatYYMMDD() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyMMdd"
       return dateFormatterPrint.string(from:Date())
    }
}
