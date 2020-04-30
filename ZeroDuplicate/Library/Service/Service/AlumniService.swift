//
//  AlumniService.swift
//  MyLums
//
//  Created by Ghafar Tanveer on 11/10/2018.
//  Copyright © 2018 Ghafar Tanveer. All rights reserved.
//

import Foundation

class AlumniService: BaseService {
    
    func getAlumniList(requestMessage: RequestMessage, complete: @escaping ((_ responseMessage: ServiceResponseMessage)->Void)){
        
        let homeURL = BASE_URL + URL_GET_ALUMNI_LIST
        
        var items = [URLQueryItem]()
        var httpUrl = URLComponents(string: homeURL)
        
        items.append(URLQueryItem(name: "paged", value: requestMessage.pageNumber))
        httpUrl?.queryItems = items
        
        let finalUrl = httpUrl?.path
        print(finalUrl ?? "")
        print(httpUrl?.query ?? "")
        
        let params = ["":""]
        
        let networkRequestMessage = NetworkRequestMessage(requestType: RequestType.GET, contentType: ContentType.HTML, url: finalUrl!, params: params as Dictionary<String, AnyObject>,Url:httpUrl!.url! )
        
        
        BaseNetwork().performGetNetworkTask(requestMessage: networkRequestMessage) {
            (networkResponseMessage) in
            
            switch networkResponseMessage.statusCode {
                
            case .Success:
                
                let parsedResponse = ResponseHandler.handleResponseStructure(networkResponseMessage: networkResponseMessage)
                switch parsedResponse.serviceResponseType{
                    
                case .Success:
                    
                    if let data = parsedResponse.swiftyJsonData  {
                        
                        let serviceResponse = self.getSuccessResponseMessage(parsedResponse.message)
                        
                        let list = AlumniListViewModel(data: data)
                        serviceResponse.data = list
                        complete(serviceResponse)
                    }
                    else{
                        let response = self.getErrorResponseMessage(FAILED_MESSAGE as AnyObject)
                        complete(response)
                    }
                    
                default:
                    let response = self.getDefaultServiceResponse(parsedResponse)
                    complete(response)
                    
                }
            case .Failure:
                let response = self.getErrorResponseMessage(FAILED_MESSAGE as AnyObject)
                complete(response)
            case .Timeout:
                let response = self.getTimeoutErrorResponseMessage("Request Timeout" as AnyObject)
                complete(response)
            }
        }
        
    }
    
    
}
