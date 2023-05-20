//
//  UserDefaults+Extension.swift
//  GymCare
//
//  Created by Nguyễn Hà on 29/12/2022.
//

import Foundation

extension UserDefaults {
    func storeCodableObject<T>(_ object: T, forkey: String) where T: Codable {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            self.set(encoded, forKey: forkey)
        }
    }

    func loadCodableObject<T>(forkey: String) -> T? where T: Codable {
        if let data = self.data(forKey: forkey) {
            let decoder = JSONDecoder()
            return try? decoder.decode(T.self, from: data)
        }
        return nil
    }
}
