import Foundation

public enum ServiceResponseType:String {
    
    case Success = "successful"
    case Complete = "1" //200
    case Failure = "error"
    case Empty = "3"
    case Warning = "4"
    case Information = "5"
    case ValidationError = "6"
    case Exception = "7"
    case CodeWord = "8"
    case Redirect = "9"
    case Function = "10"
    case Code = "11"
    case Duplicate = "12"
    case AccessRights = "13"
    case DeActivated = "14"
    case ServerError = "15"
    case NoInternetConnection = "16"
    case Timeout = "101"
    case UnAuthorizeAccess = "102"
    case LoginCredentialsFailed = "17"

}


public class ServiceResponseMessage {
    
    public var serviceResponseType : ServiceResponseType = ServiceResponseType.Failure
    public var message = ""
    public var data : AnyObject?
    public var validationErrors: [String]? = nil
    
    required public init () {
        data = nil
    }
}
