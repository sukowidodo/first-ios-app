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
    
    @IBAction func onClickOk(_ sender: Any) {
    
        let username = etUsername.text!
        let password = etPassword.text!
        
        let req = Request()
        
        req.httpRequest(endpoint: "/login",
                        parameters: ["username" : username, "password" : password],
                        completion: { result in
            switch result {
            case .success(let message):
                if message.code==200{
                    DispatchQueue.main.async{
                    self.performSegue(withIdentifier: "first_segue", sender: message)
                    }
                }else{
                    DispatchQueue.main.async{
                        let alertController = UIAlertController(title: "Error", message:
                            message.message, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
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

