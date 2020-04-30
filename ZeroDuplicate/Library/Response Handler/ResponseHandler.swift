import Foundation
import SwiftyJSON

let KEY_RESULT_TYPE = "success"
let KEY_RESULT_TYPE1 = "status"
let KEY_EXCEPTION = "Exception"
let KEY_MESSAGE = "message"
let KEY_VALIDATION_ERROR = "ValidationErrors"
let KEY_DATA = "Data"

let ERROR_SERVER_NO_DATA = "Server didn't give response"
let ERROR_SERVER_WRONG_DATA = "Server didn't give proper response"


class ResponseHandler {
    
    class func handleResponseStructure(networkResponseMessage: NetworkResponseMessage) ->(ParsedResponseMessage) {
        //var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
        
        let parsedResponse = ParsedResponseMessage()
        
        if let data = networkResponseMessage.data as? Data {
            
            do {
                let jsonDict = try JSON(data: data)
                if let resultType = jsonDict[KEY_RESULT_TYPE1].string{
                    if let msg = jsonDict[KEY_MESSAGE].string{
                        parsedResponse.message = msg
                    }
                    switch resultType.lowercased() {
                        
                    case ServiceResponseType.Success.rawValue:
                        
                        parsedResponse.serviceResponseType = .Success
                        parsedResponse.swiftyJsonData = jsonDict
                        
                    case ServiceResponseType.Failure.rawValue:
                        parsedResponse.serviceResponseType = .Failure
                        parsedResponse.swiftyJsonData = jsonDict
                        
                    case ServiceResponseType.DeActivated.rawValue:
                        parsedResponse.serviceResponseType = .DeActivated
                        
                    case ServiceResponseType.Warning.rawValue:
                        parsedResponse.serviceResponseType = .Warning
                        
                    case ServiceResponseType.Exception.rawValue:
                        parsedResponse.serviceResponseType = .Exception
                        if let exp = jsonDict[KEY_EXCEPTION].dictionary {
                            parsedResponse.exception = exp.description
                        }
                        
                    default:
                        parsedResponse.message = ERROR_SERVER_WRONG_DATA
                    }
                }else{
                    parsedResponse.message = ERROR_SERVER_WRONG_DATA
                }
                
            } catch _ {
                parsedResponse.message = ERROR_SERVER_WRONG_DATA
            }
        }
        else{
            parsedResponse.message = ERROR_SERVER_NO_DATA
        }
        
        return parsedResponse
    }
    
   
    class func handleDefaultResponse(networkResponseMessage: NetworkResponseMessage) ->(ParsedResponseMessage) {
        
        let parsedResponse = ResponseHandler.handleResponseStructure(networkResponseMessage: networkResponseMessage)
        
//        if parsedResponse.serviceResponseType == .Success{
//            if let jsonDict = parsedResponse.data as? [String: AnyObject]{
//                //if  let jsonDate = jsonDict["data"] as? [String:AnyObject]{
//                    var error2 : NSError? = nil
//
//                    let response : DefaultResponse!
//                    do {
//                        response = try DefaultResponse(dictionary: jsonDict)
//                    } catch let error as NSError {
//                        error2 = error
//                        response = nil
//                    }
//
//                    if let err = error2 {
//                        print(err)
//                        parsedResponse.serviceResponseType = .Failure
//                        parsedResponse.message = ERROR_SERVER_WRONG_DATA
//                        parsedResponse.data = nil
//                    }
//                    else{
//                        parsedResponse.data = response
//                    }
//                }
//
//           // }
//
//        }
        return parsedResponse
    }
    
   
    
   
    class func handleAlumniListResponse(networkResponseMessage: NetworkResponseMessage) ->(ParsedResponseMessage) {
        
        let parsedResponse = ResponseHandler.handleResponseStructure(networkResponseMessage: networkResponseMessage)
        
//        if parsedResponse.serviceResponseType == .Success{
//            if let jsonDict = parsedResponse.data as? [String: AnyObject]{
//
//                var error2 : NSError? = nil
//
//                let list : AlumniList!
//                do {
//                    list = try AlumniList(dictionary: jsonDict)
//                } catch let error as NSError {
//                    error2 = error
//                    list = nil
//                }
//
//                if let err = error2 {
//                    print(err)
//                    parsedResponse.serviceResponseType = .Failure
//                    parsedResponse.message = ERROR_SERVER_WRONG_DATA
//                    parsedResponse.data = nil
//                }
//                else{
//                    parsedResponse.data = list
//                }
//
//
//            }
//
//        }
        return parsedResponse
    }
    
   
    class func handlePostResponse(networkResponseMessage: NetworkResponseMessage) ->(ParsedResponseMessage) {
        
        let parsedResponse = ResponseHandler.handleResponseStructure(networkResponseMessage: networkResponseMessage)
        
        if parsedResponse.serviceResponseType == .Success{
            if let jsonDict = parsedResponse.data as? [String:AnyObject]{
                print(jsonDict)
            }
        }else{
            parsedResponse.serviceResponseType = .Failure
            // parsedResponse.message = ERROR_SERVER_WRONG_DATA
            
        }
        
        return parsedResponse
    }
    
    

}

