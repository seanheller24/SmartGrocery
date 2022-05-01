//
//  Product.swift
//  SmartGrocery
//
//  Created by Sean Heller on 4/30/22.
//

import Foundation

struct Product: Codable {
    var product_name: String
    var url: String
    var allergens_tags: [String]
}
