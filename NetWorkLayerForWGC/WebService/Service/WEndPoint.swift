//
//  WEndPoint.swift
//  NetWorkLayerForWGC
//
//  Created by Jie liang Huang on 5/20/19.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation
import Alamofire

//MARK: API Fomater
protocol ApiFunctionType {

    var environmentURL: URL { get }

    var requestURL: URL { get }

    var path: WServerPath { get }

    var headers: HTTPHeaders { get }

    var parameters: Parameters? { get }

    var method: HTTPMethod { get }

    var encoding: ParameterEncoding { get }

    var authorization: AuthorizationType { get }
}

//MARK: Default Property
extension ApiFunctionType {

    typealias HTTPHeaders       = Alamofire.HTTPHeaders
    typealias HTTPMethod        = Alamofire.HTTPMethod
    typealias ParameterEncoding = Alamofire.ParameterEncoding
    typealias Parameters        = Alamofire.Parameters
    typealias JSONEncoding      = Alamofire.JSONEncoding
    typealias URLEncoding       = Alamofire.URLEncoding


    var environmentURL: URL {
        switch AppEnvironment.currentState {
        case .release:
            return URL(string: "https://zimi.cf")!
        case .develop, .testing:
            return URL(string: "https://192.168.50.50:8080")!
        }
    }

    var requestURL: URL {
        return environmentURL.appendingPathComponent(path.rawValue)
    }

    var headers: HTTPHeaders {
        var header: HTTPHeaders = HTTPHeaders()
        switch authorization {
        case .none:
            header["Content-Type"] = "application/json"
        case .basic:
            header["Conten-Type"] = "application/x-www-form-urlencoded"
        case .oauth:
            header["Authorization"] = "Bearer"// token
        }
        return header
    }


}

