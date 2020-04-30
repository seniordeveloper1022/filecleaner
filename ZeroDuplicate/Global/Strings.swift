
import Foundation
import UIKit

let TERMS_AND_CONDITION = "I agree to the Temrs & Conditions of User Agreement & Privacy Policy"

class Strings {
    public static let APP_NAME = "APP_NAME"
    public static let APP_SUBTITLE = "APP_SUBTITLE"
    public static let SELECT_SCAN_MODE = "SELECT_SCAN_MODE"
    public static let SELECT_SCAN_DETAIL = "SELECT_SCAN_DETAIL"
    public static let BTN_SCAN_SIMILAR = "BTN_SCAN_SIMILAR"
    public static let BTN_SCAN_EXACT = "BTN_SCAN_EXACT"
    public static let BTN_START_SCAN = "BTN_START_SCAN"
    public static let BTN_STOP_SCAN = "BTN_STOP_SCAN"
    public static let BTN_RESTART_SCAN = "BTN_RESTART_SCAN"

}

struct Menu {
    static let MENULIST = [["title":"Events","image":"IconEvents"],["title":"Alumni Directory","image":"IconSearch"],["title":"Profile","image":"IconUserProfile"],["title":"Discount Partners","image":"IconDiscounts"],["title":"Invite","image":"IconInvite"],["title":"My Messages","image":"IconMessages"],["title":"Help & Support","image":"IconSupport"],["title":"Settings","image":"IconSettings"],["title":"Logout","image":"IconLogout"]]
}
struct AppInfo {
    static let Images = [["iphone":"Landing1","iphonex":"Landing1x"],["iphone":"Landing2","iphonex":"Landing2x"]
        ,["iphone":"Landing3","iphonex":"Landing3x"]
        ,["iphone":"Landing4","iphonex":"Landing4x"]
        ,["iphone":"Landing5","iphonex":"Landing5x"]]
}

struct ControllerIdentifier {
    static let SettingViewController = "SettingViewController"
    static let SettingNavigationViewController = "SettingNavigationViewController"
    static let ResultPreviewViewController = "ResultPreviewViewController"
    static let ResultNavigationController = "ResultNavigationController"
    static let ResultViewController = "ResultViewController"
    static let ResultGroupsViewController = "ResultGroupsViewController"
    static let RevealNavigationController = "revealNavigation"
    static let SWRevealViewController = "SWRevealViewController"
    static let MainContainerViewController = "MainContainerViewController"
    static let HomeViewController = "HomeViewController"
    static let HomeNavigationController = "HomeNavigationController"
    static let ScannerViewController = "ScannerViewController"
//    in.co.shuklarahul.ZeroDuplicate
}
struct StoryboardName {
    static let Main = "Main"
   
}
struct  NIBName {
   
}

struct  CellIdentifier {
    static let ResultTableViewCell = "ResultTableViewCell"
    static let SideMenuProfileTableViewCell = "SideMenuProfileTableViewCell"
    static let AlumniCollectionViewCell = "AlumniCollectionViewCell"
   
   
}
struct NavigationTitles {
    static let Restaurant = "Restaurants"
    static let Signup = "Signup"
    static let Login = "Login"
    static let Home = "Home"
    static let Profile = "Profile"
    static let ChangePassword = "Change Password"
    static let ForgotPassword = "Forgot password"
    static let PeopleInfo = "People Info"
    static let GolfDetail = "Golf Detail"
}

struct NotificationName {
    static let Conversation = "getConversation"
    static let Notification = "getNotification"
    static let GetNotification = "getNotification"
    static let GetThreadList = "getThreadList"
}
struct PlaceHolders {
    static let Profile = "IconProfile"
    static let HomeImage = "MainImage"
    static let Lums = "IconLums"
}
struct DiscoutBadges {
    static let Silver = "BadgeSilver"
    static let Gold = "BadgeGold"
    static let Platinum = "BadgePlatanium"
}


struct WebUrls {
    static let HonorableCEC = "https://www.ecp.gov.pk/frmCLICKGenericPage.aspx?PageID=22"
}


struct AppFonts {
    static func RobotoBoldFontWithSize(size : CGFloat) -> UIFont {
        
        if let font = UIFont(name: "Roboto-Bold", size: size) {
            return font
        }
        else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    static func RobotoRegularFontWithSize(size : CGFloat) -> UIFont {
        
        if let font = UIFont(name: "Roboto-Regular", size: size) {
            return font
        }
        else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    static func RobotoLightFontWithSize(size : CGFloat) -> UIFont {
        
        if let font = UIFont(name: "Roboto-Light", size: size) {
            return font
        }
        else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    static func RobotoMediumFontWithSize(size : CGFloat) -> UIFont {
        
        if let font = UIFont(name: "Roboto-Medium", size: size) {
            return font
        }
        else {
            return UIFont.systemFont(ofSize: size)
        }
    }
}

struct CameraService {
    static let title = "Camera Service Off"
    static let message = "Turn on Camera in Settings > Privacy to allow myLUMS to determine your Camera"
}

struct LocationService {
    static let ServiceOff = "Location Service Off"
    static let AllowLocationMessage = "Turn on Location in Settings > Privacy to allow myLUMS to determine your Location"
    static let Settings = "Settings"
}

struct ValidationMessages {
    static let EmailAndPasswordRequired = "Please enter your email and password to login."
    static let EmailFormate = "Please enter your registered email to continue."
    static let SIGNUP_MESSAGE = "You have successfully signed up with myLUMS. A verification email has been sent to manalwaseen7@gmail.com. Click on validation link in the email to start using the myLUMS"
}
