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
    
    var soyButtonSelected = false
    var lactoseButtonSelected = false
    var treenutButtonSelected = false
    var peanutButtonSelected = false
    var wheatButtonSelected = false
    var eggButtonSelected = false
    var fishButtonSelected = false
    var shellfishButtonSelected = false
    
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
        if soyButtonSelected {
            soybeansButton.setImage(UIImage(systemName: "square"), for: .normal)
            soyButtonSelected = false
        } else {
            soybeansButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            soyButtonSelected = true
        }
    }
    @IBAction func lactoseButtonPressed(_ sender: UIButton) {
        if lactoseButtonSelected {
            lactoseButton.setImage(UIImage(systemName: "square"), for: .normal)
            lactoseButtonSelected = false
        } else {
            lactoseButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            lactoseButtonSelected = true
        }
    }
    @IBAction func treenutButtonPressed(_ sender: UIButton) {
        if treenutButtonSelected {
            treenutButton.setImage(UIImage(systemName: "square"), for: .normal)
            treenutButtonSelected = false
        } else {
            treenutButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            treenutButtonSelected = true
        }
    }
    @IBAction func peanutButtonPressed(_ sender: UIButton) {
        if peanutButtonSelected {
            peanutButton.setImage(UIImage(systemName: "square"), for: .normal)
            peanutButtonSelected = false
        } else {
            peanutButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            peanutButtonSelected = true
        }
    }
    @IBAction func wheatButtonPressed(_ sender: UIButton) {
        if wheatButtonSelected {
            wheatButton.setImage(UIImage(systemName: "square"), for: .normal)
            wheatButtonSelected = false
        } else {
            wheatButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            wheatButtonSelected = true
        }
    }
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        if eggButtonSelected {
            eggButton.setImage(UIImage(systemName: "square"), for: .normal)
            eggButtonSelected = false
        } else {
            eggButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            eggButtonSelected = true
        }
    }
    @IBAction func fishButtonPressed(_ sender: UIButton) {
        if fishButtonSelected {
            fishButton.setImage(UIImage(systemName: "square"), for: .normal)
            fishButtonSelected = false
        } else {
            fishButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            fishButtonSelected = true
        }
    }
    @IBAction func shellfishButtonPressed(_ sender: UIButton) {
        if shellfishButtonSelected {
            shellfishButton.setImage(UIImage(systemName: "square"), for: .normal)
            shellfishButtonSelected = false
        } else {
            shellfishButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            shellfishButtonSelected = true
        }
    }
    @IBAction func searchButton(_ sender: UIButton) {
    }
    
    
}
