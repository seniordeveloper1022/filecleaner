//
//  RequestMessage.swift
//  InsafiansPTI
//
//  Created by Ghafar Tanveer on 01/01/2018.
//  Copyright © 2018 Ghafar Tanveer. All rights reserved.
//

import Foundation
import UIKit

class RequestMessage: ServiceRequestMessage {

    var queryItems = [URLQueryItem]()
    var deviceId:String = ""
    var userId:String = ""
    var fcmToken:String = ""
    var type:String = ""
    var email:String = ""
    var rollNo:String = ""
    var name:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var password:String = ""
    var currentPassword:String = ""
    var message:String = ""
    var confirmPassword:String = ""
    var phone:String = ""
    var status:String = ""
    var pageNumber:String = "1"
    var searchText:String = ""
    var eventId:String = ""
    var id:String = ""
    var countryName:String = ""
    var cityName:String = ""
    var stateName:String = ""
    var company:String = ""
    var program:String = ""
    var designation:String = ""
    var department:String = ""
    var advance:String = ""
    var isReset:Bool = false
    var isProfileChanged:Bool = false
    var receiverId:String = ""
    var notificationId:String = ""
    var lat:String = ""
    var long:String = ""
    var radius:String = ""
    var mute:String = ""
    var gender:String = ""
    var year:String = ""
    var landline:String = ""
    var personalEmail:String = ""
    var currentCompany:String = ""
    var currentIndustry:String = ""
    var currentDesignation:String = ""
    var currentDepartment:String = ""
    var roomId:String = ""
    var country:String = ""
    var state:String = ""
    var city:String = ""
    var countryId:String = ""
    var stateId:String = ""
    var cityId:String = ""
    var address:String = ""
    var image:UIImage = UIImage()
    var imageKey:String = ""
    var interestList:String = ""
    var interestName:String = ""
    var experienceList:String = ""
    var compose:String = "no"
    var location:String = ""//[[String:String]] = [[String:String]]()
}


