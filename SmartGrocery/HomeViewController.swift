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
    @IBOutlet weak var soybeansButton: UIButton!
    @IBOutlet weak var lactoseButton: UIButton!
    @IBOutlet weak var treenutButton: UIButton!
    @IBOutlet weak var peanutButton: UIButton!
    @IBOutlet weak var wheatButton: UIButton!
    @IBOutlet weak var eggButton: UIButton!
    @IBOutlet weak var fishButton: UIButton!
    @IBOutlet weak var shellfishButton: UIButton!
    
    var groceryUser: GroceryUser!
    var authUI: FUIAuth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayNameLabel.text = groceryUser.displayName
        emailLabel.text = groceryUser.email
        userSinceLabel.text = "\(dateFormatter.string(from: groceryUser.userSince))"
        // round corners of image view
        userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2
        userImageView.clipsToBounds = true
        guard let url = URL(string: groceryUser.photoURL) else {
            userImageView.image = UIImage(systemName: "person.crop.circle")
            return
        }
        userImageView.sd_imageTransition = .fade
        userImageView.sd_imageTransition?.duration = 0.1
        userImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.crop.circle"))
        
    }
    
    @IBAction func soybeansButtonPressed(_ sender: UIButton) {
        if soybeansButton.currentImage! == UIImage(systemName: "square") {
            soybeansButton.setImage(UIImage(systemName: "square"),for: .normal)
        } else {
            soybeansButton.setImage(UIImage(systemName: "checkmark.square"),for: .normal)
        }
    }
    @IBAction func lactoseButtonPressed(_ sender: UIButton) {
        if lactoseButton.currentImage == UIImage(systemName: "square") {
            lactoseButton.setImage(UIImage(systemName: "square"),for: .normal)
        } else {
            lactoseButton.setImage(UIImage(systemName: "checkmark.square"),for: .normal)
        }
    }
    @IBAction func treenutButtonPressed(_ sender: UIButton) {
        if treenutButton.currentImage == UIImage(systemName: "square") {
            treenutButton.setImage(UIImage(systemName: "square"),for: .normal)
        } else {
            treenutButton.setImage(UIImage(systemName: "checkmark.square"),for: .normal)
        }
    }
    @IBAction func peanutButtonPressed(_ sender: UIButton) {
        if peanutButton.currentImage == UIImage(systemName: "square") {
            peanutButton.setImage(UIImage(systemName: "square"),for: .normal)
        } else {
            peanutButton.setImage(UIImage(systemName: "checkmark.square"),for: .normal)
        }
    }
    @IBAction func wheatButtonPressed(_ sender: UIButton) {
        if wheatButton.currentImage == UIImage(systemName: "square") {
            wheatButton.setImage(UIImage(systemName: "square"),for: .normal)
        } else {
            wheatButton.setImage(UIImage(systemName: "checkmark.square"),for: .normal)
        }
    }
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        if eggButton.currentImage == UIImage(systemName: "square") {
            eggButton.setImage(UIImage(systemName: "square"),for: .normal)
        } else {
            eggButton.setImage(UIImage(systemName: "checkmark.square"),for: .normal)
        }
    }
    @IBAction func fishButtonPressed(_ sender: UIButton) {
        if fishButton.currentImage == UIImage(systemName: "square") {
            fishButton.setImage(UIImage(systemName: "square"),for: .normal)
        } else {
            fishButton.setImage(UIImage(systemName: "checkmark.square"),for: .normal)
        }
    }
    @IBAction func shellfishButtonPressed(_ sender: UIButton) {
        if shellfishButton.currentImage == UIImage(systemName: "square") {
            shellfishButton.setImage(UIImage(systemName: "square"),for: .normal)
        } else {
            shellfishButton.setImage(UIImage(systemName: "checkmark.square"),for: .normal)
        }
    }
    @IBAction func searchButton(_ sender: UIButton) {
    }
    
    
}
