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
 
    private let refreshTokenTimelimit = 2
    private var callRequestCountDownTimes = 1

    private var didTokenCanReFresh: Bool = false {
        didSet {

        }
    }

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
                    //TODO: handToken ->  (success, invail, failure)

                    switch networkResponsResult {
                    case .success( _):

                        self.decodeFromServer(type: D.self, data: data, successReponse: { [weak self] (successResponse) in
                            
                            guard let weakself = self else { return }

                            weakself.showSuccessLog(route: route,
                                                valueResponse: dataResponse.value,
                                                statusCode: response.statusCode)

                            completion(.success(successResponse))

                        }, error: { [weak self] (error) in

                            guard let weakself = self else { return }

                            weakself.showFailureLog(route: route,
                                                valueResponse: dataResponse.value,
                                                statusCode: response.statusCode)

                            completion(.failure(error))
                        })

                    case .failure(let error):

                        if error == .invailToken,
                            self.callRequestCountDownTimes < self.refreshTokenTimelimit {

                            self.callRequestCountDownTimes += 1
                            //如果 401 -> handleToken -> refresh -> (success -> 登入, invail -> 登出, failure -> 回傳)
                            self.handleToken(success: { [weak self] in
                                guard let weakself = self else { return }
                                //login
                                weakself.request(route: WUserApiFunction.oauth_login, completion: completion)

                            }, invaildToken: { [weak self] in
                                guard let weakself = self else { return }
                                
                                // logout
                                weakself.request(route: WUserApiFunction.oauth_logout, completion: completion)

                            }, failure: { (error) in

                                completion(.failure(error))

                            })

                        } else {
                            completion(.failure(error))
                        }
                    }

                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


}


//MARK: Handle Response
extension WebserviceManager: ResponsStatusCodeHelper { }

//MARK: Handle Response log
extension WebserviceManager: WResponseLog { }

//MARK: Handle Token Time
extension WebserviceManager: WTokenHelper { }

//MARK: Decode data of requesting back
extension WebserviceManager: WDecodeServerData { }
