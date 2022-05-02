//
//  ViewController.swift
//  SmartGrocery
//
//  Created by Sean Heller on 4/27/22.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

class LoginViewController: UIViewController {
    
    var authUI: FUIAuth!
    var groceryUser: GroceryUser!
    var groceryProfile: GroceryProfile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }

    func signIn() {
        // note FUIGoogleAuth line was previously: FUIGoogleAuth(), Google changed to line below in latest update
        let providers: [FUIAuthProvider] = [
          FUIGoogleAuth(authUI: authUI!),
        ]
        if authUI.auth?.currentUser == nil { // user has not signed in
            self.authUI.providers = providers // show providers named after let providers: above
            let loginViewController = authUI.authViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true, completion: nil)
        } else { // user is already logged in
            guard let currentUser = authUI.auth?.currentUser else{
                print("😡 ERROR: Couldn't get currentUser")
                return
            }
            groceryUser = GroceryUser(user: currentUser)
            
//            let db = Firestore.firestore()
//            // Create the dictionary representing data we want to save
//            let userRef = db.collection("profiles").document(groceryUser.documentID)
//            userRef.getDocument { (document, error) in
//                guard error == nil else {
//                    print("😡 ERROR: could not access document for user \(self.groceryUser.documentID)")
//                    return
//                }
//                guard document?.exists == false else{
//                    self.groceryProfile = GroceryProfile(dictionary: document!.data()!)
//                    return
//                }
//                let dataToSave: [String: Any] = GroceryProfile(groceryUserID: self.groceryUser.documentID).dictionary
//                db.collection("profiles").document(self.groceryUser.documentID).setData(dataToSave) { (error) in
//                guard error == nil else{
//                    print("ERROR: \(error!.localizedDescription), could not save data for \(self.groceryUser.documentID)")
//                    return
//                }
//                print("Created new GroceryProfile")
//                    self.groceryProfile = GroceryProfile(dictionary: GroceryProfile(groceryUserID: self.groceryUser.documentID).dictionary)
//                }
//            }
            groceryProfile = GroceryProfile(groceryUserID: groceryUser.documentID)
            groceryProfile.saveIfNewProfile { (success) in
                if success {
                    print("Saved / Updated GroceryProfile")
                }
                else {
                    print("😡 ERROR: Tried to save a new GroceryProfile, but failed")
                }
            }
            groceryUser.saveIfNewUser { (success) in
                if success {
                    self.performSegue(withIdentifier: "FirstShowSegue", sender: nil)
                } else {
                    print("😡 ERROR: Tried to save a new GroceryUser, but failed")
                }
            }
        }
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FirstShowSegue" {
            let destination = segue.destination as! HomeViewController
            destination.groceryUser = groceryUser
        }
    }
    
    func signOut() {
        do {
            try authUI!.signOut()
        } catch {
            print("😡 ERROR: couldn't sign out")
            performSegue(withIdentifier: "FirstShowSegue", sender: nil)
        }
    }
    
    @IBAction func unwindSignOutPressed(segue: UIStoryboardSegue) {
        if segue.identifier == "SignOutUnwind" {
            signOut()
        }
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        let marginInsets: CGFloat = 16.0 // amount to indent UIImageView on each side
        let topSafeArea = self.view.safeAreaInsets.top
        
        // Create an instance of the FirebaseAuth login view controller
        let loginViewController = FUIAuthPickerViewController(authUI: authUI)
        
        // Set background color to white
        loginViewController.view.backgroundColor = UIColor.white
        loginViewController.view.subviews[0].backgroundColor = UIColor.clear
        loginViewController.view.subviews[0].subviews[0].backgroundColor = UIColor.clear
        
        // Create a frame for a UIImageView to hold our logo
        let x = marginInsets
        let y = marginInsets + topSafeArea
        let width = self.view.frame.width - (marginInsets * 2)
        //        let height = loginViewController.view.subviews[0].frame.height - (topSafeArea) - (marginInsets * 2)
        let height = UIScreen.main.bounds.height - (topSafeArea) - (marginInsets * 2)
        
        let logoFrame = CGRect(x: x, y: y, width: width, height: height)
        
        // Create the UIImageView using the frame created above & add the "logo" image
        let logoImageView = UIImageView(frame: logoFrame)
        logoImageView.image = UIImage(named: "LaunchScreenFood")
        logoImageView.contentMode = .scaleAspectFit // Set imageView to Aspect Fit
        loginViewController.view.addSubview(logoImageView) // Add ImageView to the login controller's main view
        return loginViewController
    }
}

