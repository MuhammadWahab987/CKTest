//
//  UserDetailRequest.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation

/// if you have any kind of parameters must use dependancy injection using initializer

class UserDetailRequest: ApiRequest<UserDetailModel> {
    
    var userName = ""
    
    override func apiResource() -> String {
        return "users/"
    }
    
    override func endPoint() -> String {
        return "\(userName)"
    }
    
    override func requestType() -> HTTPMethod {
        return .get
    }
}
