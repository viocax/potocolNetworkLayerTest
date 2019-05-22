//
//  WUserApiFunction.swift
//  NetWorkLayerForWGC
//
//  Created by Jie liang Huang on 5/20/19.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation



public enum WUserApiFunction {

    case register(account: String, nationality_code: String)
    case oauth_login
    case oauth_user_info
    case oauth_user_detail
    case oauth_logout
}

extension WUserApiFunction: ApiFunctionType {

    //MARK: AuthorizationType
    var authorization: AuthorizationType {
        switch self {
        case .oauth_login:
            return .oauth
        case .register:
            return .none
        default:
            return .basic
        }
    }

    //MARK: URL path
    var path: WServerPath {
        switch self {
        case .register:
            return .register
        case .oauth_login:
            return .oauth_login
        case .oauth_user_info:
            return .oauth_user_info
        case .oauth_user_detail:
            return .oauth_user_detail
        case .oauth_logout:
            return .oauth_logout
        }
    }

    //MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .oauth_login, .register:
            return .post
        default:
            return .get
        }
    }

    //MARK: Parameters Encoding
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    //MARK: Parameters
    var parameters: Parameters? {
        switch self {
        case let .register(account, nationality_code):
            return ["account": account,
                    "nationality_code": nationality_code]
        default:
                return nil
        }
    }

}


