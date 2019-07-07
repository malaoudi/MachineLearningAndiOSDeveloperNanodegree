//
//  AccountViewController.swift
//  On The Map
//
//  Created by Rajanikant Deshmukh on 23/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userInfo = Cache.shared.userInfo
        
        nicknameLabel.text = userInfo?.nickName
        nameLabel.text = "\(userInfo?.firstName ?? "") \(userInfo?.lastName ?? "")"
        
        DispatchQueue.global(qos: .background).async {
            let image: UIImage
            do {
                let url =  URL(string: "https:" + (userInfo?.imageUrl ?? ""))
                let data = try Data(contentsOf: url!)
                image = UIImage(data: data)!
            } catch {
                image = UIImage(named: "icon_world")!
            }
            
            DispatchQueue.main.async {
                self.userImage.image = image
            }
        }
    }
    
    @IBAction func onLogoutClick(_ sender: Any) {
        AuthHandler.shared.makeLogoutCall({error in
            if error != nil {
                self.showAlertDialog(title: "Error", message: (error?.rawValue)!, dismissHandler: nil)
                return
            }
            
            // Dismiss current view controller
            self.tabBarController?.dismiss(animated: true, completion: nil)
        })
    }
}
