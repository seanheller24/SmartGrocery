//
//  User.swift
//  SmartGrocery
//
//  Created by Sean Heller on 4/28/22.
//

import Foundation
import Firebase

class Profile {
    
    var userID: String
    var soybeans: Bool
    var lactoseIntolerance: Bool
    var treenutAllergy: Bool
    var peanutAllergy: Bool
    var wheatAllergy: Bool
    var eggAllergy: Bool
    var shellfishAllergy: Bool
    var fish: Bool
    var documentID: String
    
    init(userID: String, soybeans: Bool, lactoseIntolerance: Bool, treenutAllergy: Bool, peanutAllergy: Bool, wheatAllergy: Bool, eggAllergy: Bool, shellfishAllergy: Bool, fish: Bool, documentID: String) {
            self.userID = userID
            self.soybeans = soybeans
            self.lactoseIntolerance = lactoseIntolerance
            self.treenutAllergy = treenutAllergy
            self.peanutAllergy = peanutAllergy
            self.wheatAllergy = wheatAllergy
            self.eggAllergy = eggAllergy
            self.shellfishAllergy = shellfishAllergy
            self.fish = fish
            self.documentID = documentID
        }
        
        convenience init() {
            self.init(userID: "", soybeans: false, lactoseIntolerance: false, treenutAllergy: false, peanutAllergy: false, wheatAllergy: false, eggAllergy: false, shellfishAllergy: false, fish: false, documentID: "")
        }
    
    var dictionary: [String: Any] {
        return ["userID": userID, "soybeans": soybeans, "lactoseIntolerance": lactoseIntolerance, "treenutAllergy": treenutAllergy, "peanutAllergy": peanutAllergy, "wheatAllergy": wheatAllergy, "eggAllergy": eggAllergy, "shellfishAllergy": shellfishAllergy]
    }
    
    
    func saveData(completion: @escaping (Bool) -> ())  {
        let db = Firestore.firestore()
        // Grab the user ID
        guard let userID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completion(false)
        }
        self.userID = userID
        // Create the dictionary representing data we want to save
        let dataToSave: [String: Any] = self.dictionary
        // if we HAVE saved a record, we'll have an ID
        if self.documentID != "" {
            let ref = db.collection("users").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("ERROR: updating document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked!
                    completion(true)
                }
            }
        } else { // Otherwise create a new document via .addDocument
            var ref: DocumentReference? = nil // Firestore will create a new ID for us
            ref = db.collection("users").addDocument(data: dataToSave) { (error) in
                if let error = error {
                    print("ERROR: adding document \(error.localizedDescription)")
                    completion(false)
                } else { // It worked! Save the documentID in Spot’s documentID property
                    self.documentID = ref!.documentID
                    completion(true)
                }
            }
        }
    }
}
