//
//  HomeViewController.swift
//  SmartGrocery
//
//  Created by Sean Heller on 4/27/22.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import SDWebImage

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
} ()

class HomeViewController: UIViewController {
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userSinceLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    
    var db: Firestore!
    var authUI: FUIAuth!
    var groceryUser: GroceryUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        groceryUser = groceryUser.dictionary(db.collection("users").document(authUI.auth!.currentUser!.uid).getDocument())
        
//        var groceryUser = GroceryUser(user: <#T##User#>)
//        var groceryUserUnwrapped = GroceryUser(dictionary: db.collection("users").document(groceryUser.documentID).data())
//        displayNameLabel.text = groceryUser.displayName
//        emailLabel.text = groceryUser.email
//        userSinceLabel.text = "\(dateFormatter.string(from: groceryUser.userSince))"
//        // round corners of image view
//        userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2
//        userImageView.clipsToBounds = true
//        guard let url = URL(string: groceryUser.photoURL) else {
//            userImageView.image = UIImage(systemName: "person.crop.circle")
//            return
//        }
//        userImageView.sd_imageTransition = .fade
//        userImageView.sd_imageTransition?.duration = 0.1
//        userImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.crop.circle"))
        
    }
    
}
