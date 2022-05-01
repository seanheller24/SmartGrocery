//
//  ProductDetailViewController.swift
//  SmartGrocery
//
//  Created by Sean Heller on 4/30/22.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var allergenTextView: UITextView!
    @IBOutlet weak var productURLLabel: UITextView!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productNameLabel.text = product.product_name
        var allergies = ""
        for allergy in product.allergens_tags {
            allergies = allergies + "\n- \(allergy.replacingOccurrences(of: "en:" , with: "").capitalized)"
        }
        allergenTextView.text = allergies
        productURLLabel.text = product.url

        
    }

}
