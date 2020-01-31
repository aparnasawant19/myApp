//
//  DetailViewController.swift
//  client
//
//  Created by admin on 26/01/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelOriginalPrice: UILabel!
    @IBOutlet weak var labelFinalPrice: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelSellerName: UILabel!
    @IBOutlet weak var labelSellerEmail: UILabel!
    @IBOutlet weak var labelSellerContact: UILabel!
    
    var add: Post_ad!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("title: \(add.ad_title)")
        print("des: \(add.ad_description)")
        labelTitle.text = add.ad_title
        labelDescription.text = add.ad_description
        labelOriginalPrice.text = String(add.price_original)
       labelFinalPrice.text = String( add.price_final!)
        labelCategory.text  = add.cat_name
        labelSellerName.text = add.uname
        labelSellerEmail.text = add.email
        print("email: \(add.email)")
        labelSellerContact.text = add.mobile_no
        
        print(add.thumbnail)
        let url = URL(string: "http://172.18.4.119:4000/\(add.thumbnail!)")
        print(url)
        
        imageView.kf.setImage(with: url)
        //imageView.image = add.thumbnail
        
        

    }

}
