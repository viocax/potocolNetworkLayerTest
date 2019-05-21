//
//  ViewController.swift
//  NetWorkLayerForWGC
//
//  Created by Jie liang Huang on 5/20/19.
//  Copyright © 2019 Jie liang Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        register(account: "0978853179", nation: "886") { (result) in
            switch result {
            case .success(let succ):
                print(succ)
            case .failure(let error):
                print(error)
            }
        }

    }


}

struct Test: Decodable {

    var name: String
}

extension ViewController {

    func register(account: String, nation: String, completion: @escaping (Result<WSuccessResponse<Test>, Error>) -> Void) {
        WebserviceManager.shared.request(route: WUserApiFunction.register(account: account, nationality_code: nation), completion: completion)
    }
}
