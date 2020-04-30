import Foundation
import UIKit
struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X_All = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 812 || ScreenSize.SCREEN_MAX_LENGTH == 896))
    static let IS_IPHONE_X = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 812))
    static let IS_IPHONE_X_MAX = (UIDevice.current.userInterfaceIdiom == .phone && (ScreenSize.SCREEN_MAX_LENGTH == 896))
}

var TOP_BAR_HEIGHT:CGFloat = 74
var PROFILE_VIEW_HEIGHT:CGFloat = 270
let ANIMATION_TIME = 0.6


let PROGRAM_LIST = ["BSc","MBA","EMBA","PhD"]


let GOOGLE_API_KEY = "AIzaSyBTfypSbx_zNMhWSBXMTA2BJBMQO7_9_T8"

let STRING_SUCCESS = ""
let STRING_UNEXPECTED_ERROR = ""
let TIMEOUT_MESSAGE = "Request Time out"
let ERROR_NO_NETWORK = "Connection lost. Please check your internet connection and try again. "//"Internet connection is currently unavailable."
let FILL_ALL_FIELDS_MESSAGE = "Please fill all empty fields to continue."//"Please fill all fields"
let FILL_ALL_FIELDS_EXPERIENCE_MESSAGE = "Please fill all fields in working experience"
let PLEASE_SELECT_FILTER_MESSAGE = "Please fill atleast one field to proceed"
let PLEASE_SELECT_RECIPIENT = "Please select recipient"
let VALID_DATES = "From date must be greater than to date"

let APP_SHARE_TEXT  = "has invited you to download myLUMS application.Please download the app from following links:\nGoogle Play store: https://play.google.com/store/apps/details?id=com.creativedots.mylums\niOS App Store: https://itunes.apple.com/pk/app/mylums/id1444768354?mt=8"

let LOGOUT_TITLE = "Logout Successful"
let LOGOUT_MESSAGE = "You have signed out successfully from the myLUMS."
let LOGIN_TITLE = "Login Successful"
let SUCCESS = "Success"
let LOGIN_MESSAGE = "You have signed in successfully to the myLUMS."

let UPDATE_EXPERIENCE = "Please update your experience first."
let FAILED_MESSAGE = "Failed Please Try Again!"
let ENTER_EMAIL_MESSAGE = "Please enter email"
let ENTER_MESSAGE = "Please enter message"
let MEMBER_REGISTERED_MESSAGE = "Member Registerd Successfully"
let VALID_PHONE_MESSAGE = "Please enter valid phone number"
let VALID_EMAIL_MESSAGE = "The email does not match the required format. Please try again with a different email."//"Please enter valid email"
let VALID_EMAIL_AND_ROLL_NO_MESSAGE = "Please verify email and roll no"
let VALID_CNIC_MESSAGE = "Please enter valid CNIC"
let VALID_PASSWORD_MESSAGE = "Password and confirm password must be same"
let VALID_PINCODE_MESSAGE = "Pincode and confirm pincode must be same"
let VALID_LOCATION_MESSAGE = "Please select both Locations"
let VALID_TERMS_AND_CONDITION_MESSAGE = "Please accept our terms and conditions to continue."//"Please check terms and conditions"
let PROFILE_UPDATED_MESSAGE = "Profile Updated Successfuly"
let MESSAGE = "Message"
let EMAIL_VERIFICATION_MESSAGE = "Your email address does not match with our database. Kindly try again or click help below"
let EMAIL_AND_ROLL_VERIFICATION_MESSAGE = "Your email address and roll number does not match with our database. Kindly try again or click help below"
let ROLL_NO_VERIFICATION_MESSAGE = "Your roll number does not match with our database. Kindly try again or click help below"


let FB_NOT_INSTALLED_MESSAGE = "Could not found a installed app 'Facebook' to proceed with sharing."
let TWITTER_NOT_INSTALLED_MESSAGE = "Could not found a installed app 'Twitter' to proceed with sharing."
let INSTA_NOT_INSTALLED_MESSAGE = "Please install the instagram application"
let WHATSAPP_NOT_INSTALLED_MESSAGE = "Could not found a installed app 'Whatsapp' to proceed with sharing."

let EMAIL_REGULAR_EXPRESSION = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

let COPIED_TO_CLIP_BOARD = "Copied to Clip Board"
let SAY_HI_EVENT_MESSAGE = "I just noticed that you are the same LUMS event that I am at currently\n\n May I come and meet you?"
let ALUMNI_NOT_FOUND_MESSAGE = "Search not found try Advance search"

// Google Admob

let App_ID = "ca-app-pub-4964284666734851~6096651948"
let Add_Unit_ID = "ca-app-pub-4964284666734851/6757683840"


let PRIVACY_POLICY_URL = "https://mylums.pk/app/privacy-policy"
let TERMS_AND_CONDITION_URL = "https://mylums.pk/app/terms-and-conditions"

let IS_FIRST_TIME = "fistTimeLogin"
let KEEP_SAVE_MENU_KEY = "saveMenu"
let USER_LOGIN_DATA = "UserLoginData"
let LOGIN_KEY = "login"
let TOKEN_KEY = "token"
let CONNECTED_WITH_LINKEDIN = "connected"
let QRCODE_CACHE = "qrcodeCache"
let FCM_TYPE = "200"


let APPLICATION_THEME_COLOR = UIColor(red: 255/255, green: 136/255, blue: 0/255, alpha: 1.0)
let DARK_BLUE_COLOR = UIColor(red: 29/255, green: 66/255, blue: 129/255, alpha: 1.0)
let DARK_RED_COLOR = UIColor(red: 187/255, green: 15/255, blue: 32/255, alpha: 1.0)
let GRAY_COLOR = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
let LIGHT_BLUE_COLOR = UIColor(red: 78/255, green: 97/255, blue: 228/255, alpha: 1.0)
let LIGHT_GRAY_COLOR = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)

let PRINT_API_RESPONSE = false


//picture-urls::(original)
let UEL_GET_LINKEDIN_PROFILE = "https://api.linkedin.com/v1/people/~:(id,first-name,last-name,maiden-name,email-address,industry,phone-numbers,date-of-birth,location,main-address,num-connections,picture-url,picture-urls::(original),skills,positions:(title),educations:(school-name,field-of-study,start-date,end-date,degree,activities))?format=json"

let BASE_URL = "https://mylums.pk/app/"//"http://lums.creative-dots.com/"

let URL_VERIFY_EMAIL                = "preload/verifyemail"
let URL_AUTH_TOKEN                  = "auth/token"
let URL_FCM_TOEKN_REGISTRATION      = "device/registration"
let URL_SIGN_UP                     = "signup"
let URL_LOGIN                       = "login"
let URL_LOGOUT                      = "logout"
let URL_GET_PROFILE                 = "users/profile"
let URL_HELP                        = "help/desk"
let URL_FORGOT_PASSWORD             = "forgotpassword"
let URL_GET_ALUMNI_LIST             = "alumni/all"
let URL_SEARCH_ALUMNI               = "alumni/search"
let URL_GET_ALUMNI_PROFILE          = "alumni/profile"
let URL_UPDTAE_PROFILE              = "users/profile/update"
let URL_GET_HELP_DATA               = "help/menu"
let URL_GET_EVENT_GALLERY           = "events/gallery"
let URL_GET_UPCOMING_EVENT_LIST     = "events/upcoming"
let URL_GET_PAST_EVENT_LIST         = "events/past"
let URL_GET_EVENT_DETAIL            = "events/detail/"
let URL_GET_COUNTRY_LIST            = "location/countries"
let URL_GET_STATE_LIST              = "location/states/"
let URL_GET_CITY_LIST               = "location/cities/"
let URL_GET_INDUSTRY_LIST           = "customs/interest_industry"
let URL_GET_MESSAGES_LIST           = "messages/all"
let URL_GET_ALL_CHAT                = "messages/messageboard/"
let URL_SEND_HI_MESSAGE             = "messages/sayhimessage/"
let URL_SEND_TINDER_MESSAGE         = "messages/tindermessage/"
let URL_SEND_MESSAGE                = "messages/messagesent/"
let URL_GET_ALL_NOTIFICATION        = "notification/all"
let URL_READ_NOTIFICATION           = "notification/read/"
let URL_GET_PARTNER_LIST            = "partners/all"
let URL_GET_PARTNER_DETAIL          = "partners/detail/"
let URL_GET_PARTNER_NEAR_BY         = "partners/nearby"
let URL_GET_OFFER_NEAR_BY           = "partners/nearoffers/"
let URL_SET_EVENT_STATUS            = "events/attending/"//"partners/near_offers/"
let URL_THREAD_READ                 = "messages/read/"
let URL_THREAD_ARCHIVE              = "messages/archive/"
let URL_EVENT_CHECKEDIN             = "events/checkin/"
let URL_CHANGE_SETTINGS             = "setting/update"
let URL_UPDATE_TINDER_STATUS        = "messages/tinder/"
let URL_INVITE_NEW_USER             = "alumni/invite/"
let URL_GET_PRELOAD_INFO            = "alumni/preload/"
let URL_RESEND_EMAIL                = "resend"


let kFacebookURL = "fb://"
let kTwitterURL = "twitter://"
let kInstagramURL = "instagram://app"




