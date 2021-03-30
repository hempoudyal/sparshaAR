//
//  API_Router.swift
//  Sparsha
//
//  Created by Hem Poudyal on 3/29/21.
//

import Foundation
import Alamofire

struct API_Request{
    var url: String
    //only url is taken for Marvel Api, since it has just .get method, other HTTP methods can also be set here
    //authorization parameters can also be set here
    var method: HTTPMethod
}

enum API_Router{
    case state
    case power
}

extension API_Router{
    func path() -> API_Request{
        switch self {
        case .power:
            return API_Request(url: WebConstants.kBaseURL + "all/state", method: .put)
        case .state:
            return API_Request(url: WebConstants.kBaseURL + "all/state", method: .put)
        }
    }
        
}
