//
//  WebserviceManager.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation
import Alamofire

class WebserviceManager {

    private static let timeoutInterval = 60.0

    static let shared = WebserviceManager()

    private init() { }

    let sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeoutInterval)
        let manager = Session.init(configuration: configuration)
        return manager
    }()

    
    final func request<D: Decodable>(route: ApiFunctionType, completion: @escaping (Result<D, Error>) -> Void) {

        sessionManager.request(route.requestURL, method: route.method, parameters: route.parameters, encoding: route.encoding, headers: route.headers).responseJSON { (dataResponse) in
            
            let result = dataResponse.result

            switch result {
            case .success:
                guard let data = dataResponse.data else {
                    completion(.failure(NetWorkResponse.noData))

                    self.showFailureLog(route: route,
                                        valueResponse: dataResponse.value,
                                        statusCode: dataResponse.response?.statusCode)

                    return
                }

                if let response = dataResponse.response {
                    let networkResponsResult = self.handleNetworkResponse(response)

                    self.handleErrorNetWorkResponse(with: networkResponsResult,
                                                    completion: {_ in

                        let decoder = JSONDecoder()
                        if let succesResponse = try? decoder.decode(D.self
                            , from: data) {
                            completion(.success(succesResponse))

                            self.showSuccessLog(route: route,
                                                valueResponse: dataResponse.value,
                                                statusCode: response.statusCode)


                        } else if let _ = try? decoder.decode(WFailureResponse.self, from: data) {
                            completion(.failure(NetWorkResponse.failed))

                            self.showFailureLog(route: route,
                                                valueResponse: dataResponse.value,
                                                statusCode: response.statusCode)

                        } else {
                            completion(.failure(NetWorkResponse.serverError))
                            
                            self.showFailureLog(route: route,
                                                valueResponse: dataResponse.value,
                                                statusCode: response.statusCode)
                        }


                    })
                    
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func handleErrorNetWorkResponse(with response: Result<String, NetWorkResponse>, completion: @escaping (Result<String, Error>) -> Void) {
        switch response {
        case .success(let success):

            completion(.success(success))

        case .failure(.invailToken):

            handleToken(success: { //成功後登入
                // login
            }, invaildToken: { //token 過期登出
                // log out
            }) { (error) in //其他錯誤
                completion(.failure(error))
            }
            
        default:
            
            break
        }
        
    }
}


//MARK: Handle Response
extension WebserviceManager: ResponsStatusCodeHelper { }

//MARK: Handle Response log
extension WebserviceManager: WResponseLog { }

//MARK: Handle Token Time
extension WebserviceManager: WTokenHelper { }
