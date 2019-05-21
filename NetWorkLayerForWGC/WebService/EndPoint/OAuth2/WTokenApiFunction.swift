//
//  WTokenApiFunction.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation


public enum WTokenApiFunction {

    case refreshToken(grant_type: String, refresh_token: String)

}

extension WTokenApiFunction: ApiFunctionType {

    var path: WServerPath {
        switch self {
        case .refreshToken:
            return .oauth_token
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .refreshToken(let grant_type, let refresh_token):
            return ["grant_type": grant_type,
                    "refresh_token": refresh_token]
//        default:
//            return nil
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var authorization: AuthorizationType {
        return .oauth
    }
    

    
}
