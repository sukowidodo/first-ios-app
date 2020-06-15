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
        req.loginPost(with: "/auth/login", parameters: ["username" : username, "password" : password]) { (data, response, err) in
            if data?.code == 200 {
                DispatchQueue.main.async{
                    self.performSegue(withIdentifier: "first_segue", sender: data)
                }
            } else {
                DispatchQueue.main.async{
                    let alertController = UIAlertController(title: "Error", message:
                        data?.message, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        print("suko")
    }
}

