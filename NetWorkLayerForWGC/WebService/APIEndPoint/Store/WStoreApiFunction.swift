//
//  WStoreApiFunction.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation


public enum WStoreApiFunction {

    case oath_store(storeId: String)
}


extension WStoreApiFunction: ApiFunctionType {

    var path: WServerPath {
        switch self {
        case .oath_store:
            return .oath_store
        }
    }

    var parameters: Parameters? {
        switch self {
        case .oath_store(let storeId):
            return ["storeID": storeId]
        }
    }

    var method: HTTPMethod {
        switch self {
        case .oath_store:
            return .get
//        default:
//            return .get
        }
    }

    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var authorization: AuthorizationType {
        switch self {
        case .oath_store:
            return .oauth
//        default:
//            return .basic
        }
    }




}
