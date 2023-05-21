//
//  UsersListingViewRequest.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation

/// if you have any kind of parameters must use dependancy injection using initializer

class UsersListingRequest: ApiRequest<UsersListingModel> {
    
    var offset = 0
    
    override func apiResource() -> String {
        return "users"
    }
    
    override func endPoint() -> String {
        return "?since=\(offset)"
    }
    
    override func requestType() -> HTTPMethod {
        return .get
    }
}
