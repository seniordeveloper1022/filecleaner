
//
//  NetworkResponseMessage.swift
//  CodeStructure
//
//  Created by Ghafar Tanveer on 01/04/2017.
//  Copyright © 2017 Ghafar Tanveer. All rights reserved.
//

import Foundation

enum StatusCode{
    case Success
    case Failure
    case Timeout
    
}

class NetworkResponseMessage{
    
    var statusCode: StatusCode
    var message: String
    var data: AnyObject?
    
    required init () {
        
        statusCode = StatusCode.Failure
        message = "Unknown error"
        
    }
    
    init ( statusCode: StatusCode,
           message : String,
           data: AnyObject? = nil) {
        
        self.statusCode = statusCode
        self.message = message
        self.data = data
    }

}
