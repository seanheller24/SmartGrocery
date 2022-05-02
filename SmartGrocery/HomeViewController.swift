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
    var groceryProfile: GroceryProfile!
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
        let db = Firestore.firestore()
        // Create the dictionary representing data we want to save
        let userRef = db.collection("profiles").document("\(groceryUser.documentID)")
        userRef.getDocument { document, error in
            if let error = error {
                print("Couldn't access document \(error.localizedDescription)")
            }
            self.groceryProfile = GroceryProfile(dictionary: document!.data()!)
            self.groceryProfile.documentID = "\(self.groceryUser.documentID)"
            self.soyButtonSelected = self.groceryProfile.soyButtonSelected
            self.lactoseButtonSelected = self.groceryProfile.lactoseButtonSelected
            self.treenutButtonSelected = self.groceryProfile.treenutButtonSelected
            self.peanutButtonSelected = self.groceryProfile.peanutButtonSelected
            self.wheatButtonSelected = self.groceryProfile.wheatButtonSelected
            self.eggButtonSelected = self.groceryProfile.eggButtonSelected
            self.fishButtonSelected = self.groceryProfile.fishButtonSelected
            self.shellfishButtonSelected = self.groceryProfile.shellfishButtonSelected
            self.soybeansButton.setImage(UIImage(systemName: self.soyButtonSelected ? "checkmark.square" : "square"), for: .normal)
            self.lactoseButton.setImage(UIImage(systemName: self.lactoseButtonSelected ? "checkmark.square" : "square"), for: .normal)
            self.treenutButton.setImage(UIImage(systemName: self.treenutButtonSelected ? "checkmark.square" : "square"), for: .normal)
            self.peanutButton.setImage(UIImage(systemName: self.peanutButtonSelected ? "checkmark.square" : "square"), for: .normal)
            self.wheatButton.setImage(UIImage(systemName: self.wheatButtonSelected ? "checkmark.square" : "square"), for: .normal)
            self.eggButton.setImage(UIImage(systemName: self.eggButtonSelected ? "checkmark.square" : "square"), for: .normal)
            self.fishButton.setImage(UIImage(systemName: self.fishButtonSelected ? "checkmark.square" : "square"), for: .normal)
            self.shellfishButton.setImage(UIImage(systemName: self.shellfishButtonSelected ? "checkmark.square" : "square"), for: .normal)
        }
        
        
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
            groceryProfile.soyButtonSelected = soyButtonSelected
        } else {
            soybeansButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            soyButtonSelected = true
            groceryProfile.soyButtonSelected = soyButtonSelected
        }
        groceryProfile.saveData { (success) in
            if success {
                print("Updated GroceryProfile")
            }
            else {
                print("😡 ERROR: Tried to update a new GroceryProfile, but failed")
            }
        }
    }
    @IBAction func lactoseButtonPressed(_ sender: UIButton) {
        if lactoseButtonSelected {
            lactoseButton.setImage(UIImage(systemName: "square"), for: .normal)
            lactoseButtonSelected = false
            groceryProfile.lactoseButtonSelected = lactoseButtonSelected
        } else {
            lactoseButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            lactoseButtonSelected = true
            groceryProfile.lactoseButtonSelected = lactoseButtonSelected
        }
        groceryProfile.saveData { (success) in
            if success {
                print("Updated GroceryProfile")
            }
            else {
                print("😡 ERROR: Tried to update a new GroceryProfile, but failed")
            }
        }
    }
    @IBAction func treenutButtonPressed(_ sender: UIButton) {
        if treenutButtonSelected {
            treenutButton.setImage(UIImage(systemName: "square"), for: .normal)
            treenutButtonSelected = false
            groceryProfile.treenutButtonSelected = treenutButtonSelected
        } else {
            treenutButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            treenutButtonSelected = true
            groceryProfile.treenutButtonSelected = treenutButtonSelected
        }
        groceryProfile.saveData { (success) in
            if success {
                print("Updated GroceryProfile")
            }
            else {
                print("😡 ERROR: Tried to update a new GroceryProfile, but failed")
            }
        }
    }
    @IBAction func peanutButtonPressed(_ sender: UIButton) {
        if peanutButtonSelected {
            peanutButton.setImage(UIImage(systemName: "square"), for: .normal)
            peanutButtonSelected = false
            groceryProfile.peanutButtonSelected = peanutButtonSelected
        } else {
            peanutButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            peanutButtonSelected = true
            groceryProfile.peanutButtonSelected = peanutButtonSelected
        }
        groceryProfile.saveData { (success) in
            if success {
                print("Updated GroceryProfile")
            }
            else {
                print("😡 ERROR: Tried to update a new GroceryProfile, but failed")
            }
        }
    }
    @IBAction func wheatButtonPressed(_ sender: UIButton) {
        if wheatButtonSelected {
            wheatButton.setImage(UIImage(systemName: "square"), for: .normal)
            wheatButtonSelected = false
            groceryProfile.wheatButtonSelected = wheatButtonSelected
        } else {
            wheatButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            wheatButtonSelected = true
            groceryProfile.wheatButtonSelected = wheatButtonSelected
        }
        groceryProfile.saveData { (success) in
            if success {
                print("Updated GroceryProfile")
            }
            else {
                print("😡 ERROR: Tried to update a new GroceryProfile, but failed")
            }
        }
    }
    @IBAction func eggButtonPressed(_ sender: UIButton) {
        if eggButtonSelected {
            eggButton.setImage(UIImage(systemName: "square"), for: .normal)
            eggButtonSelected = false
            groceryProfile.eggButtonSelected = eggButtonSelected
        } else {
            eggButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            eggButtonSelected = true
            groceryProfile.eggButtonSelected = eggButtonSelected
        }
        groceryProfile.saveData { (success) in
            if success {
                print("Updated GroceryProfile")
            }
            else {
                print("😡 ERROR: Tried to update a new GroceryProfile, but failed")
            }
        }
    }
    @IBAction func fishButtonPressed(_ sender: UIButton) {
        if fishButtonSelected {
            fishButton.setImage(UIImage(systemName: "square"), for: .normal)
            fishButtonSelected = false
            groceryProfile.fishButtonSelected = fishButtonSelected
        } else {
            fishButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            fishButtonSelected = true
            groceryProfile.fishButtonSelected = fishButtonSelected
        }
        groceryProfile.saveData { (success) in
            if success {
                print("Updated GroceryProfile")
            }
            else {
                print("😡 ERROR: Tried to update a new GroceryProfile, but failed")
            }
        }
    }
    @IBAction func shellfishButtonPressed(_ sender: UIButton) {
        if shellfishButtonSelected {
            shellfishButton.setImage(UIImage(systemName: "square"), for: .normal)
            shellfishButtonSelected = false
            groceryProfile.shellfishButtonSelected = shellfishButtonSelected
        } else {
            shellfishButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            shellfishButtonSelected = true
            groceryProfile.shellfishButtonSelected = shellfishButtonSelected
        }
        groceryProfile.saveData { (success) in
            if success {
                print("Updated GroceryProfile")
            }
            else {
                print("😡 ERROR: Tried to update a new GroceryProfile, but failed")
            }
        }
    }
    @IBAction func searchButton(_ sender: UIButton) {
    }
    
    
}
