//
//  constants.swift
//  CKTest
//
//  Created by Muhammad Wahab on 21/05/2023.
//

import Foundation




class Constant: NSObject {
    
    // MARK: - Network & Third party
    static var baseUrl = "https://api.github.com/"
}


enum VTMessageType: Int {
    case error = 0
    case success
    case info
}

enum MessageType: Int {
    case image = 2
    case text = 1
}
