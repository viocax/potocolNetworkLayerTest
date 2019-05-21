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

        
    
    }


}


extension WebserviceManager {

    func request(route: WTokenApiFunction, completion: @escaping (Result<Any, Error>) -> Void) {

        sessionManager.request(route.requestURL, method: route.method, parameters: route.parameters, encoding: route.encoding, headers: route.headers).responseJSON { (dataResponse) in

            let result = dataResponse.result

            switch result {
            case .success(let success):
                completion(.success(success))

            case .failure(let error):
                completion(.failure(error))

            }
        }
    }


}
