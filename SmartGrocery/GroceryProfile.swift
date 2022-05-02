//
//  GroceryProfile.swift
//  SmartGrocery
//
//  Created by Sean Heller on 5/2/22.
//

import Foundation
import Firebase

class GroceryProfile{
    var soyButtonSelected: Bool
    var lactoseButtonSelected: Bool
    var treenutButtonSelected: Bool
    var peanutButtonSelected: Bool
    var wheatButtonSelected: Bool
    var eggButtonSelected: Bool
    var fishButtonSelected: Bool
    var shellfishButtonSelected: Bool
    var documentID: String
    
    var dictionary: [String: Any] {
        return["soyButtonSelected": soyButtonSelected, "lactoseButtonSelected": lactoseButtonSelected, "treenutButtonSelected": treenutButtonSelected, "peanutButtonSelected": peanutButtonSelected, "wheatButtonSelected": wheatButtonSelected, "eggButtonSelected": eggButtonSelected, "fishButtonSelected": fishButtonSelected, "shellfishButtonSelected": shellfishButtonSelected]
    }
    
    init(soyButtonSelected: Bool, lactoseButtonSelected: Bool, treenutButtonSelected: Bool, peanutButtonSelected: Bool, wheatButtonSelected: Bool, eggButtonSelected: Bool, fishButtonSelected: Bool, shellfishButtonSelected: Bool, documentID: String) {
        self.soyButtonSelected = soyButtonSelected
        self.lactoseButtonSelected = lactoseButtonSelected
        self.treenutButtonSelected = treenutButtonSelected
        self.peanutButtonSelected = peanutButtonSelected
        self.wheatButtonSelected = wheatButtonSelected
        self.eggButtonSelected = eggButtonSelected
        self.fishButtonSelected = fishButtonSelected
        self.shellfishButtonSelected = shellfishButtonSelected
        self.documentID = documentID
        
    }
    
    convenience init(groceryUserID: String) {
        self.init(soyButtonSelected: false, lactoseButtonSelected: false, treenutButtonSelected: false, peanutButtonSelected: false, wheatButtonSelected: false, eggButtonSelected: false, fishButtonSelected: false, shellfishButtonSelected: false, documentID: groceryUserID)
    }
    
    convenience init(dictionary: [String: Any]) {
        let soyButtonSelected = dictionary["soyButtonSelected"] as! Bool? ?? false
        let lactoseButtonSelected = dictionary["lactoseButtonSelected"] as! Bool? ?? false
        let treenutButtonSelected = dictionary["treenutButtonSelected"] as! Bool? ?? false
        let peanutButtonSelected = dictionary["peanutButtonSelected"] as! Bool? ?? false
        let wheatButtonSelected = dictionary["wheatButtonSelected"] as! Bool? ?? false
        let eggButtonSelected = dictionary["eggButtonSelected"] as! Bool? ?? false
        let fishButtonSelected = dictionary["fishButtonSelected"] as! Bool? ?? false
        let shellfishButtonSelected = dictionary["shellfishButtonSelected"] as! Bool? ?? false
        self.init(soyButtonSelected: soyButtonSelected, lactoseButtonSelected: lactoseButtonSelected, treenutButtonSelected: treenutButtonSelected, peanutButtonSelected: peanutButtonSelected, wheatButtonSelected: wheatButtonSelected, eggButtonSelected: eggButtonSelected, fishButtonSelected: fishButtonSelected, shellfishButtonSelected: shellfishButtonSelected, documentID: "")
    }
    
    func saveIfNewProfile(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Create the dictionary representing data we want to save
        let userRef = db.collection("profiles").document(documentID)
        userRef.getDocument { (document, error) in
            guard error == nil else {
                print("😡 ERROR: could not access document for user \(self.documentID)")
                return completion(false)
            }
            guard document?.exists == false else{
                print("👍 The document for user \(self.documentID) already exists. No reason to re-create it.")
                return completion(true)
            }
            // create the new document
            let dataToSave: [String: Any] = self.dictionary
            db.collection("profiles").document(self.documentID).setData(dataToSave) { (error) in
                guard error == nil else{
                    print("ERROR: \(error!.localizedDescription), could not save data for \(self.documentID)")
                    return completion(false)
                }
                return completion(true)
            }
        }
    }
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        let ref = db.collection("profiles").document(documentID)
        ref.getDocument { (document, error) in
            guard error == nil else {
                print("😡 ERROR: could not access document for user \(self.documentID)")
                return completion(false)
            }
            db.collection("profiles").document(self.documentID).setData(dataToSave) { (error) in
                guard error == nil else {
                    print("😡 ERROR: updating document \(error!.localizedDescription)")
                    return completion(false)
                }
                print("💨 Updated document: \(self.documentID)") // It worked!
                completion(true)
            }
        }
    }
    
    
}
