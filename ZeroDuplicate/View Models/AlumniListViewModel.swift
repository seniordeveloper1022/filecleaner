//
//  AlumniListViewModel.swift
//  SwiftCodeStructure
//
//  Created by Ghafar Tanveer on 03/01/2019.
//  Copyright © 2019 Ghafar Tanveer. All rights reserved.
//

import Foundation
import SwiftyJSON

enum AlumniListKeys: String {
    case list = "data"
    case message = "message"
    case count = "count"
}

class AlumniListViewModel {
    
    var alumniList: [AlumniViewModel]
    var message:String
    var count: String
    
    init() {
        self.alumniList = [AlumniViewModel]()
        self.message = ""
        self.count = ""
    }
    
    convenience init(data: JSON) {
        self.init()
        self.message = data[AlumniListKeys.message.rawValue].string ?? ""
        self.count = data[AlumniListKeys.count.rawValue].string ?? ""
        
        if let alumniList = data[AlumniListKeys.list.rawValue].array{
            for eachItem in alumniList{
                self.alumniList.append(AlumniViewModel(alumni: eachItem))
            }
        }
    }
}
