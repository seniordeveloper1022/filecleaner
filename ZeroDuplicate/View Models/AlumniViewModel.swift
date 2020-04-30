//
//  AlumniViewModel.swift
//  SwiftCodeStructure
//
//  Created by Ghafar Tanveer on 03/01/2019.
//  Copyright © 2019 Ghafar Tanveer. All rights reserved.
//

import Foundation
import SwiftyJSON

class AlumniViewModel {
    var userId: String
    var email: String
    var rollNumber: String
    var status: String
    var ID: String
    var image: String
    var firstName: String
    var lastName: String
    
    
    init() {
        self.userId = ""
        self.email = ""
        self.rollNumber = ""
        self.status = ""
        self.ID = ""
        self.image = ""
        self.firstName = ""
        self.lastName = ""
        
    }
    convenience init(alumni:JSON) {
        self.init()
       
        self.userId = alumni["user_id"].string ?? ""
        self.email = alumni["email"].string ?? ""
        self.rollNumber = alumni["roll_number"].string ?? ""
        self.status = alumni["status"].string ?? ""
        self.ID = alumni["id"].string ?? ""
        self.image = alumni["image"].string ?? ""
        self.firstName = alumni["first_name"].string ?? ""
        self.lastName = alumni["last_name"].string ?? ""
    }
  
}
