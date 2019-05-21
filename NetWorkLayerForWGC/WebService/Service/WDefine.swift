//
//  WDefine.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation

//MARK: Authoriztion Type
public enum AuthorizationType {
    
    case none, basic, oauth
    
}

//MARK: Environment type
enum NetWorkEnvironment {
    
    case develop, testing, release

}

//MARK: app environment
struct AppEnvironment {
    
    static let currentState: NetWorkEnvironment = .release
    
}

