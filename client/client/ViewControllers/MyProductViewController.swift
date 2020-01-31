//
//  MyProductViewController.swift
//  client
//
//  Created by admin on 27/01/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class MyProductViewController: LoginViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var adds: [Post_ad] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Email1 :: \(email1)")

   
    }
    override func viewWillAppear(_ animated: Bool) {
        loadAdds()
    }
    func loadAdds(){
        makeApiCall(path: "/Post_ad/myAd/\(UserDefaults.standard.object(forKey: "uid")!)", completionHandler: { result in
            self.adds.removeAll()
            
            let array = result as! [[String: Any]]
            for item in array{
                let add  = Post_ad()
                add.ad_title = item["ad_title"] as? String
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyProductCollectionViewCell
        let add = adds[indexPath.row]
        
        cell.lbl.text = add.ad_title
        
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
