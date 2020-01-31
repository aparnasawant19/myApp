//
//  LoginViewController.swift
//  client
//
//  Created by admin on 21/01/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import  Alamofire

class LoginViewController: BaseViewController{

    @IBOutlet weak var editEmail: UITextField!
    @IBOutlet weak var editPasword: UITextField!
    
    var email1:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin() {
        if editEmail.text!.count == 0 {
                       showError(message: "Email is mandatory")
                   } else if editPasword.text!.count == 0 {
                       showError(message: "Password is mandatory")
                   } else {
                       print(editEmail.text!)
            email1 = editEmail.text!
            print(email1)
                       let body = [
                           "email": editEmail.text!,
                           "password": editPasword.text!
                       ]
                       
                       let url = "http://192.168.1.22:4000/user/login"
//                         let url = "http://192.168.43.76:4000/user/login"
                       AF.request(url, method: .post, parameters: body,encoding: JSONEncoding())
                           .responseJSON(completionHandler: { response in
                                   let result = response.value as! [String: Any]
                                               let status = result["status"] as! String
                               print("\(result)")
                               
                               if status == "success" {

                                   let data = result["data"] as! [String: Any]
                                   let uid = data["uid"] as! Int
                                   let uname = data["uname"] as! String
                                   let email = data["email"] as! String

                                   // persist the userId in user defaults
                                   let userDefaults = UserDefaults.standard
                                   userDefaults.setValue(uid, forKey: "uid")
                                   userDefaults.setValue(uname, forKey: "uname")
                                   userDefaults.setValue(email, forKey: "email")
                                   userDefaults.synchronize()
                                   
                                   print(data)

                                   let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "tabBarController")
                                   self.navigationController?.pushViewController(tabBarController, animated: true)

                               } else {
                                   self.showError(message: "Invalid email or pasword")
                              }
                           })
                   }
               }
    }
    
    


