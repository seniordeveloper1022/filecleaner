import Foundation
import UIKit
import Photos

class Global {
    class var shared : Global {
        
        struct Static {
            static let instance : Global = Global()
        }
        return Static.instance
    }
    var selectedTab:String = ""
    var selectedUrl:String = ""
    var deviceId:String = UIDevice.current.identifierForVendor!.uuidString
    var tabs = Tabs.Browser
   
    
    
    var isLogedIn:Bool = false
    var HomeScreenWallpaperUrl:String = ""
    var API_TOKEN:String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjM2In0.wrATP8e01HgoSocxlb600-SBCcmorbgtnsRdzpT-pnA"
    var FCMToken:String? = ""
    var isOnHome:Bool? = false
    var isFbLogin:Bool? = false
    var disableMenuGesture:Bool? = false
    var isFromMenu:Bool = false
    var isFromNotification:Bool = false
    var galleryImagesList:[UIImage]?
    var allPhotos: PHFetchResult<PHAsset>? = nil
    var similarityThershold: Int = 50
    var searchResults:[Int:[ImageViewModel]] = [Int:[ImageViewModel]]()
    
    
  }

