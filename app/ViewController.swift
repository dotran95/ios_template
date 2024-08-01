//
//  ViewController.swift
//  app
//
//  Created by dotn on 23/07/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let client: ApiClient = ApiClientImplementation()
        let endpoint = CreatePostRequest(requestBody: CreatePostParams(title: "", body: "dasdsad", userId: 2312))
        Task {
            let res = try await client.execute(endpoint: endpoint, type: VoidResponse.self)
            switch res {
            case .success(let obj):
                print(obj.entity)
            case .failure(let err):
                print(err)
            }
        }
    }


}

