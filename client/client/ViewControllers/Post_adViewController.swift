//
//  Post_adViewController.swift
//  client
//
//  Created by admin on 21/01/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Kingfisher

class Post_adViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var adds: [Post_ad] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAdds()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadAdds()
    }
    func loadAdds(){
        makeApiCall(path: "/post_ad", completionHandler: { result in
            self.adds.removeAll()
            
            let array = result as! [[String: Any]]
            for item in array{
                let add  = Post_ad()
                add.ad_title = item["ad_title"] as? String
                add.ad_description = item["ad_description"] as? String
                add.price_original = item["price_original"] as? Int
                add.price_final = item["price_final"] as? Int
                add.cat_name = item["cat_name"] as? String
                add.uname = item["uname"] as? String
                add.email = item["email"] as? String
                add.mobile_no = item["mobile_no"] as? String
                add.thumbnail = item["thumbnail"]as? String
                self.adds.append(add)
            }
            self.collectionView.reloadData()
        }, method: .get)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ListCollectionViewCell
        let add = adds[indexPath.row]
        
        cell.labelTitle.text = add.ad_title
        
        
        let url1 = URL(string: url + "/\(add.thumbnail!)" )
        cell.imageView.kf.setImage(with: url1)
        cell.imageView.layer.cornerRadius = 20
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        // let add = Post_ad()
        //add.ad_title = ["ad_title"] as? String
        let add = adds[indexPath.row]
        vc?.add = add
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
}
