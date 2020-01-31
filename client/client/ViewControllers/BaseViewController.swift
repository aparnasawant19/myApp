//
//  BaseViewController.swift
//  client
//
//  Created by admin on 21/01/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController {
    // let url = "http://172.18.5.45:4000"
    let url = "http://192.168.1.22:4000"
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    func showError(message: String) {
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func showSuccess(message: String) {
        let alert = UIAlertController(title: "success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func makeApiCall(path: String,  completionHandler: @escaping (Any?) -> Void, method: HTTPMethod = .get, parameters: Parameters? = nil) {
        let url = "http://192.168.1.22:4000" + path
        print("calling API: \(url)")
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding())
            .responseJSON(completionHandler: { response in
                let result = response.value as! [String: Any]
//                print("RESPONSE :: \(response)")
//                print("RESULT :: \(result)")
                let status = result["status"] as! String
                if status == "success" {
                    
                    
                    completionHandler(result["data"])
                } else {
                    print("Error while calling API: \(result["error"]!)")
                }
            })
    }
    

    

}
