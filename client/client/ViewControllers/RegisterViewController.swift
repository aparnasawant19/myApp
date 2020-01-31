//
//  RegisterViewController.swift
//  client
//
//  Created by admin on 26/01/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editAddress: UITextField!
    @IBOutlet weak var editCollegeName: UITextField!
    @IBOutlet weak var editBranch: UITextField!
    @IBOutlet weak var editEmail: UITextField!
    @IBOutlet weak var editMobileNo: UITextField!
    @IBOutlet weak var editPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Register User"
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(onRegister))
        

        
    }
    
   @objc func onRegister() {
    if editName.text!.count == 0 {
        showError(message: " Name is mandatory")
    } else if editAddress.text!.count == 0 {
        showError(message: "Address is mandatory")
    } else if editCollegeName.text!.count == 0 {
        showError(message: "College Name is mandatory")
    } else if editEmail.text!.count == 0 {
        showError(message: "Email is mandatory")
    } else if editPassword.text!.count == 0 {
    showError(message: "Password is mandatory")
    }else{
        
        let body = [
            "uname": editName.text!,
            "address": editAddress.text!,
            "college_name": editCollegeName.text!,
            "branch": editBranch.text!,
            "email": editEmail.text!,
            "mobile_no": editMobileNo.text!,
            "password": editPassword.text!
        ]
        
        makeApiCall(path: "/user/register",
                    completionHandler: { result in
                    
                        let alert = UIAlertController(title: "success", message: "Registered a new user. Please login now.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                            
                    }, method: .post, parameters: body)
        
    }
    

}
}
