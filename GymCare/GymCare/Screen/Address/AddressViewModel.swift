//
//  AddressViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 10/03/2023.
//

import Foundation

final class AddressViewModel: BaseViewModel {

    func callApiGetAddress(classId: Int, completion: @escaping (AddressModel?, String?) -> Void) {
        self.repository.getAddress(classId: classId) { data, msg in
            completion(data, msg)
        }
    }
    
    func getDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double, unit: String) -> Double {
        let radlat1 = Double.pi * lat1 / 180
        let radlat2 = Double.pi * lat2 / 180
        let theta = lon1 - lon2
        let radtheta = Double.pi * theta / 180
        var dist = sin(radlat1) * sin(radlat2) + cos(radlat1) * cos(radlat2) * cos(radtheta)
        dist = acos(dist)
        dist = dist * 180 / Double.pi
        dist = dist * 60 * 1.1515
        if unit == "K" { dist = dist * 1.609344 }
        if unit == "M" { dist = dist * 0.8684 }
        return dist.rounded(toPlaces: 1)
    }
    
    func setAddressDistance(addresses: [Address]) {
        for address in addresses {
            if let lattitude = address.lattitude, let longitude = address.longitude {
                let distance = getDistance(lat1: Constants.LATITUDE, lon1: Constants.LONGTITUDE, lat2: lattitude, lon2: longitude, unit: "K")
                address.distance = distance
            }
        }
    }
}
