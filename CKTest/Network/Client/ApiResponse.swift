//
//  ApiResponse.swift
//  Motive Business
//
//  Created by Zeshan on 29/12/2020.
//

import UIKit

class ApiResponse: NSObject {

    var success: Bool = false
    var message: String
    var data: AnyObject?
//    var responseCode: Int

    init(success: Bool, message: String?, data: AnyObject?) {
        self.success = success
        self.message = message ?? ""
        self.data = data
//        self.responseCode = responseCode
    }
}
