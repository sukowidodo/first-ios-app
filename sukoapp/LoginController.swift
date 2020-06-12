//
//  ViewController.swift
//  sukoapp
//
//  Created by macbook on 4/29/20.
//  Copyright © 2020 SmartCyberSolution. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var etUsername: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    
    @IBAction func onClick(_ sender: Any) {
        
        let username = etUsername.text!
        let password = etPassword.text!
        
        let req = Request()
        req.httpRequest(endpoint: "/login",
                        parameters: ["username" : username, "password" : password],
                        completion: { result in
            switch result {
                case .success(let message):
                    print(result)
                    break
                case .failed(let err):
                    print(err)
                    break
                default:
                    break
            }
        })
    }
    
    override func viewDidLoad() {
        print("suko")
    }
}

