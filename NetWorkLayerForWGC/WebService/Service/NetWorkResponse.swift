//
//  NetWorkResponse.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation

//MARK: Response
enum WApiResponseStatus: String, Codable {
    
    case SUCCESS
    case FAIL
    
}

//MARK: Success Response
struct WSuccessResponse<T: Decodable>: Decodable {
    
    let status: WApiResponseStatus
    let result: T
    let errorMsg: String
    
}

//MARK: Failure Response
struct WFailureResponse: Decodable {
    
    let errorCode: Int
    let errorMsg: String
    let status: String
    
}

//MARK: NetWork Response
enum NetWorkResponse: String, Error {
    
    case authenticationError = "You need to be authentication first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case serverError = "system Error"
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response"
    case invailToken = ""
    
}


//MARK: Handle NetWork Status code 
protocol ResponsStatusCodeHelper { }

extension ResponsStatusCodeHelper {

    func handleNetworkResponse(_ response: HTTPURLResponse) -> Swift.Result<String, NetWorkResponse> {
        
        switch response.statusCode {
        case 200...299:
            return .success("status code success")
        case 400:
            return .failure(.badRequest)
        case 401:
            return .failure(.invailToken)
        case 402...499:
            return .failure(.authenticationError)
        case 500:
            return .failure(.serverError)
        case 600:
            return .failure(.outdated)
        default:
            return .failure(.failed)
        }
    }

}
