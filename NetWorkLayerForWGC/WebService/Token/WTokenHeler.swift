//
//  WTokenHeler.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation
import Alamofire

protocol WTokenHelper { }

extension WTokenHelper {

    func handleToken(success: @escaping () -> Void,
                     invaildToken: @escaping () -> Void,
                     failure: @escaping (Error) -> Void) {
        //TODO: call refresh ->
        WebserviceManager.shared.request(route: .refreshToken(refresh_token: "1234")) { (isSuccess, invailTokenResponse, error) in
            switch isSuccess {
            case .success(let resfresh): //TODO: Token object 存下來

                success()

            case .failure:

                if let error = error {
                    failure(error)
                    return
                }

                if invailTokenResponse != nil {
                    invaildToken()
                }
        
            }
        }

    }


}

//MARK: WebserviceManager For token refresh Api
extension WebserviceManager {

    enum ResfreshTokenSuccess {
        case success(Any), failure
    }

    typealias ResfreshTokenCompletion = (ResfreshTokenSuccess, NetWorkResponse?, Error?) -> Void

    func request(route: WTokenApiFunction, completion: @escaping ResfreshTokenCompletion ) {

        sessionManager.request(route.requestURL, method: route.method, parameters: route.parameters, encoding: route.encoding, headers: route.headers).responseJSON { (dataResponse) in

            let result = dataResponse.result

            switch result {

            case .success(let refreshToken): 

                self.showSuccessLog(route: route, valueResponse: dataResponse.value, statusCode: dataResponse.response?.statusCode)

                completion(.success(refreshToken), nil, nil)

               
            case .failure(let error):

                if dataResponse.response?.statusCode == 401 {

                    completion(.failure, .invailToken, error)

                } else {

                    completion(.failure, nil ,error)

                }

                self.showFailureLog(route: route, valueResponse: dataResponse.value, statusCode: dataResponse.response?.statusCode)
            }
        }
    }


}
