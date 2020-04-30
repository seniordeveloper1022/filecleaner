
import SwiftyJSON


public class ParsedResponseMessage{
    var serviceResponseType: ServiceResponseType = .Failure
    var data: AnyObject? = nil
    var swiftyJsonData: JSON? = nil
    var exception: String? = nil
    var validationErrors: [String]? = nil
    var message = ""
    
    init(message: String = "", serviceResponseType:ServiceResponseType = .Failure, data:AnyObject? = nil, exception:String? = nil , validationErrors:[String]? = nil){
        self.serviceResponseType = serviceResponseType
        self.message = message
        self.data = data
        self.exception = exception
        self.validationErrors = validationErrors
    }
}
