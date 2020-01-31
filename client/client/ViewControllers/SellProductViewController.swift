//
//  SellProductViewController.swift
//  client
//
//  Created by admin on 26/01/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class SellProductViewController: BaseViewController {
    @IBOutlet weak var editTitle: UITextField!
    @IBOutlet weak var editDescription: UITextField!
    @IBOutlet weak var editOriginalPrice: UITextField!
    @IBOutlet weak var editFinalPrice: UITextField!
    @IBOutlet weak var CategoryPicker: UIPickerView!
    
    @IBOutlet weak var editUserId: UITextField!
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBAction func onSelect() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onCamera() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    var catageories: [String] = []
    var categoryId: [Int] = []
    

    let imagePicker: UIImagePickerController = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoryPicker.dataSource = self as! UIPickerViewDataSource
        CategoryPicker.delegate = self as! UIPickerViewDelegate
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sell", style: .done, target: self, action: #selector(onSellProduct))
        
        
         makeApiCall(path: "/Category",
                                      completionHandler: { result in
                                      
                                       //print("result:\(result)")
                                       let tempcategory = result as! NSArray;                            // print("tempcategory:\(tempcategory)")
                                       for object in tempcategory {
                                           let cat = object as! NSDictionary
                                        self.catageories.append(cat.value(forKey: "cat_name") as! String)
                                        self.categoryId.append(cat.value(forKey: "cat_id") as! Int)
                                           //self.categories1.append(cat)
                                       }
                                        self.CategoryPicker.reloadComponent(0)
                                       //print(self.categories)
                                       //print(self.categoryid)
                                       }, method: .get, parameters: nil)
               
           }

        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Product", style: .done, target: self, action: #selector(onSellProduct))
        
    
    
    @objc func onSellProduct(){
        if editTitle.text!.count == 0 {
            showError(message: "Title is mandatory")
        } else if editDescription.text!.count == 0 {
            showError(message: "Description is mandatory")
        } else if editOriginalPrice.text!.count == 0 {
            showError(message: "Original Price is mandatory")
        } else if editFinalPrice.text!.count == 0 {
            showError(message: "Final Price is mandatory")
        } else if editUserId.text!.count == 0 {
        showError(message: "User Id is mandatory")
        }else{
            
            let row = CategoryPicker.selectedRow(inComponent: 0)
            let selectedCategory = catageories[row]
        
            let body: [String: Any] = [
                "ad_title": editTitle.text!,
                "ad_description": editDescription.text!,
                "price_original": editOriginalPrice.text!,
                "price_final": editFinalPrice.text!,
                "uid": editUserId.text!,
                "cat_id": categoryId[catageories.firstIndex(of: selectedCategory)!],
                "thumbnail": ProductImage.image!.pngData()!
                //"thumbnail": MultipartFormData
            ]
            print(body)
            
//            AF.upload(multipartFormData: {multipartFormData in
//                multipartFormData.append(Data(self.ProductImage.image!.pngData()!), withName: "thumbnail")
//            }, to: "http://172.18.5.45:4000/post_ad",method: .post).responseData(completionHandler: {response in
//                print(response)
//            })
            let headers: HTTPHeaders
            headers = ["Content-type": "multipart/form-data",
                       "Content-Disposition" : "form-data"]
            
             AF.upload(multipartFormData: {multipartFormData in
                multipartFormData.append(self.ProductImage.image!.pngData()!, withName: "thumbnail",fileName: "document.png",mimeType: "image/png")
                multipartFormData.append((self.editTitle.text?.data(using: .utf8))!, withName: "ad_title", fileName: nil, mimeType: nil)
                multipartFormData.append((self.editDescription.text?.data(using: .utf8))!, withName: "ad_description", fileName: nil, mimeType: nil)
                multipartFormData.append((self.editOriginalPrice.text?.data(using: .utf8))!, withName: "price_original", fileName: nil, mimeType: nil)
                multipartFormData.append((self.editFinalPrice.text?.data(using: .utf8))!, withName: "price_final", fileName: nil, mimeType: nil)
                multipartFormData.append((String(self.categoryId.count).data(using: .utf8))!, withName: "cat_id", fileName: nil, mimeType: nil)
                multipartFormData.append((self.editUserId.text!.data(using: .utf8))!, withName: "uid", fileName: nil, mimeType: nil)
                
                
             },to: "http://192.168.1.22:4000/post_ad", usingThreshold: UInt64.init(),method: .post,headers: headers).response(completionHandler: {response in
                            print(response)
                        })
        }
        let Post_adViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Post_adViewController") as! Post_adViewController;
        //Post_adViewController.present(Post_adViewController, animated: true, completion: nil)
self.navigationController?.pushViewController(Post_adViewController, animated: true)
    }
}
            
           // AF.upload(multipartFormData: { multipartFormData in
                                            //multipartFormData.append(Data("thumbnail".utf8), withName: "thumbnail")
                                            
                                               
//                                           }, to: "http://172.18.4.119:4000/post_ad")
//                                               .responseJSON { response in
//                                                   debugPrint(response)
//                                               }
//                   },method : .post)
//

extension SellProductViewController: UINavigationControllerDelegate{
    
}

extension SellProductViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        

        ProductImage.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SellProductViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return catageories.count
    }
    
}

extension SellProductViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return catageories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
}

