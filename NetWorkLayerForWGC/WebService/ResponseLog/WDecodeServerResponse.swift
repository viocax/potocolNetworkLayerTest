//
//  WDecodeServerResponse.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation

protocol WDecodeServerResponse { }

extension WDecodeServerResponse {
    
    typealias DecodeServerCompletion = (Decodable?, WFailureResponse?, Error?) -> Void

    private var decoder: JSONDecoder {
        return JSONDecoder()
    }

    func decodeFromServer<D: Decodable>(type: D.Type, data: Data, completion: @escaping DecodeServerCompletion ) {
        if let successResonpe = try? decoder.decode(type.self, from: data) {

            completion(successResonpe, nil, nil)

        } else if let failRespone = try? decoder.decode(WFailureResponse.self, from: data) {

            completion(nil, failRespone, nil)

        } else {
            completion(nil, nil, NetWorkResponse.serverError)
        }
    }
}
