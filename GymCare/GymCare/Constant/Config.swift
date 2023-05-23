//
//  Config.swift
//  GymCare
//
//

import Foundation

class Config {

    static let shared = Config()
    
    var BASE_API_URL: String {
        return baseUrl
    }
    
    var versionJson: String {
        return version
    }
    
    var versionJsonOnly: String {
        return versionOny
    }

    var POLICY_URL: String {
        return policyUrl
    }

    private var baseUrl: String = ""
    private var version: String = ""
    private var versionOny: String = ""
    private var policyUrl: String = ""

    init() {
        baseUrl = "http://172.20.10.2"
        version = "/v1/controller/"
        versionOny = "/v1.0.3/"
    }

}
