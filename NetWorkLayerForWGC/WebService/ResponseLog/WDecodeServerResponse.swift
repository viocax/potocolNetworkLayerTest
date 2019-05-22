//
//  WDecodeServerResponse.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation

protocol WDecodeServerData { }

extension WDecodeServerData {


    private var decoder: JSONDecoder {
        return JSONDecoder()
    }

    func decodeFromServer<D: Decodable>(type: D.Type, data: Data, successReponse: @escaping (D) -> Void, error: @escaping (NetWorkResponse) -> Void) {

        if let successRes = try? decoder.decode(type.self, from: data) {

            successReponse(successRes)

        } else if let _ = try? decoder.decode(WFailureResponse.self, from: data) {

            error(.failed)

        } else {
            error(.serverError)
        }
    }
}
