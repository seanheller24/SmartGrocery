//
//  ProductDetailViewController.swift
//  SmartGrocery
//
//  Created by Sean Heller on 4/30/22.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var allergenTextView: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var productURLLabel: UITextView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productNameLabel.text = product.product_name
        var allergies = ""
        for allergy in product.allergens_tags {
            if allergies == "" {
                allergies = "- \(allergy.replacingOccurrences(of: "en:" , with: "").capitalized)"
            } else {
                allergies = allergies + "\n- \(allergy.replacingOccurrences(of: "en:" , with: "").capitalized)"
            }
        }
        allergenTextView.text = allergies
        productURLLabel.text = product.url
        var ingredients = ""
        for ingredient in product.ingredients {
            if ingredients == "" {
                ingredients = "\(ingredient.id.replacingOccurrences(of: "en:", with: "").capitalized)"
            } else {
                ingredients = ingredients + ", \(ingredient.id.replacingOccurrences(of: "en:", with: "").capitalized)"
            }
        }
        ingredientsTextView.text = ingredients
    }
    
}
