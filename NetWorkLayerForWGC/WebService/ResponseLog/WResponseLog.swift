//
//  WResponseLog.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation
import Alamofire

//MARK: Log helper
protocol WResponseLog { }

extension WResponseLog {


    func showSuccessLog(route: ApiFunctionType, valueResponse response: Any?, statusCode: Int?) {
        print("\n==================================================")
        print("ApiName: \(route.path.rawValue)")
        print("Request URL: \(route.requestURL)")
        print("StatusCode: \(String(describing: statusCode))")
        print("Headers: \(route.headers)")
        print("Method: \(route.method)")
        print("\nRequest parameters: \(String(describing: route.parameters))\n")
        print("Response: \(String(describing: response))")
        print("==================================================")
    }
    

    func showFailureLog(route: ApiFunctionType, valueResponse response: Any?, statusCode: Int?) {
        print("\n==================================================")
        print("ApiName: \(route.path.rawValue)")
        print("Request URL: \(route.requestURL)")
        print("StatusCode: \(String(describing: statusCode))")
        print("Headers: \(route.headers)")
        print("Method: \(route.method)")
        print("\nRequest parameters: \(String(describing: route.parameters))\n")
        print("Request Error: \(String(describing: response))")
        print("===================================================")
    }

}
