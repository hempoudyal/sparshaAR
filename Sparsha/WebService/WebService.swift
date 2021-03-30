//
//  WebService.swift
//  Sparsha
//
//  Created by Hem Poudyal on 3/29/21.
//

import Foundation
import Alamofire

struct WebConstants {
    static let kBaseURL = "https://api.lifx.com/v1/lights/"
    static let authToken = "c2ba2d9817903d2f91fef63d36fba03246f14e561a249c04975bb738bbd1523d"
}

class WebService : NSObject{
    //you don't need to make instance with class func : called a Type Method
    //or it can also be done by singleton pattern creating a static global variable
    class func webRequest(_ apiRouter: API_Router,
                          parameters: [String: Any]? = nil,
                          successBlock:@escaping ((_ response:Data) -> Void),
                          failureBlock:@escaping ((_ message:String) -> Void)){
        
        let router = API_Router.path(apiRouter)()
        let token = "Bearer " + WebConstants.authToken
        let headers: HTTPHeaders = [
            "Authorization":token
        ]
    
        AF.request(URL.init(string: router.url)!,
                   method: router.method,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON {
                    (response) in
            
            print(response.result)
        }
    }
}

