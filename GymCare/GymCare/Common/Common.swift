//
//  Common.swift
//  GymCare
//
//  Created by Nguyễn Hà on 27/12/2022.
//

import Foundation
import UIKit

public func castToInt(_ data: Any?) -> Int {
    if let data = data {
        if let strValue = data as? String, let intValue = Int(strValue) {
            return intValue
        }
    }
    return 0
}

public func castToInt(_ data: Double?) -> Int {
    if let data = data {
        return Int(data)
    }
    return 0
}

public func castToDouble(_ data: Any?) -> Double {
    if let data = data as? Double {
        return data
    }
    return 0
}

public func castToDouble(_ data: Double?) -> Double {
    if let data = data {
        return data
    }
    return 0
}

public func castToDouble(_ data: Int?) -> Double {
    if let data = data {
        return Double(data)
    }
    return 0
}

public func castToFloat(_ data: Float?) -> Float {
    if let data = data {
        return data
    }
    return 0
}

public func castToFloat(_ data: Int?) -> Float {
    if let data = data {
        return Float(data)
    }
    return 0
}

public func castToInt(_ data: String?) -> Int {
    if let data = data, let value = Int(data) {
        return value
    }
    return 0
}

public func castToInt(_ data: Int?) -> Int {
    if let data = data {
        return data
    }
    return 0
}

public func castToString(_ data: Any?) -> String {
    if let data = data {
        return "\(data)"
    }
    return ""
}

public func castToBool(_ data: Bool?) -> Bool {
    if let value = data {
        return value
    }
    return false
}

public func formatDateTypeApi(date: Date, _ typeFormat: String? = "dd/MM/yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = typeFormat
    dateFormatter.amSymbol = Constants.amSymbol
    dateFormatter.pmSymbol = Constants.pmSymbol
    let dateStr = dateFormatter.string(from: date)
    return dateStr
}

public func formatDate(date: String, _ typeFormat: String? = "dd/MM/yyyy") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = typeFormat
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.amSymbol = Constants.amSymbol
    dateFormatter.pmSymbol = Constants.pmSymbol
    let dateStr = dateFormatter.date(from: date)
    return dateStr
}

public func formatDateString(dateString: String, _ typeFormat: String? = "dd/MM/yyyy", _ typeReturn: String? = "dd/MM/yyyy") -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = typeFormat
    dateFormatter.amSymbol = Constants.amSymbol
    dateFormatter.pmSymbol = Constants.pmSymbol
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = typeReturn
        return dateFormatter.string(from: date)
    }
    return nil
}

// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

func getWiFiAddress() -> String? {
    var address: String?
    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next }

            guard let interface = ptr?.pointee else { return "" }
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // wifi = ["en0"]
                // wired = ["en2", "en3", "en4"]
                // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                let name: String = String(cString: (interface.ifa_name))
                if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
    }
    return address ?? ""
}


//enum CustomStoryboard: String {
//    case PaymentViewController = "PaymentViewController"
//    case tabBarVC = "TabBarVC"
//
//    func loadStoryboard() -> UIStoryboard {
//        return UIStoryboard(name: rawValue, bundle: nil)
//    }
//
//    private func getStoryboard(originVC: UIViewController?) -> UIStoryboard {
//        if let oVC = originVC, let originStoryboard = oVC.storyboard, originStoryboard.name == self.rawValue {
//            return originStoryboard
//        }
//        return loadStoryboard()
//    }
//
//    static func loadPaymentVC(_ fromViewController: UIViewController? = nil) -> PaymentVC {
//        let storyboard = PaymentViewController.getStoryboard(originVC: fromViewController)
//        if let result = storyboard.instantiateViewController(withIdentifier: "PaymentVC") as? PaymentVC {
//            return result
//        }
//        fatalError("DEVELOP ERROR: Fail to load \"PaymentVC\" from storyboard \"PaymentVC\"")
//    }
//}

extension UIStoryboard {
    var name: String? {
        if responds(to: NSSelectorFromString("storyboardFileName")) {
            return (value(forKey: "storyboardFileName") as? NSString)?.deletingPathExtension
        }
        return nil
    }
}
