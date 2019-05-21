//
//  WServerPath.swift
//  NetWorkLayerForWGC
//
//  Created by apple on 2019/5/21.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import Foundation

public enum WServerPath: String {

    case register                                    = "/user/api/register"
    case oauth_login                                 = "/user/api/oauth/login"
    case oauth_user_info                             = "/user/api/oauth/user/info"
    case oauth_user_detail                           = "/user/api/oauth/user/detail"
    case oath_store                                  = "/store/api/oauth/operation/store/getWalletBalance"

    case oauth_token                                 = "/user/api/oauth/token"   

}
