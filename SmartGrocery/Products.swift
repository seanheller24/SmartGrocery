//
//  Products.swift
//  SmartGrocery
//
//  Created by Sean Heller on 4/30/22.
//

import Foundation

class Products {
    struct Returned: Codable {
        var count: Int
        var page: Int
        var page_count: Int
        var page_size: Int
        var products: [Product]
    }
    
    var count = 0
    var page = 0
    var page_count = 0
    var page_size = 0
    var urlString = "https://us.openfoodfacts.org/cgi/search.pl?action=process"
    // https://us.openfoodfacts.org/cgi/search.pl?action=process&tagtype_0=allergens&tag_contains_0=contains&tag_0=milk&tagtype_1=allergens&tag_contains_1=contains&tag_1=soybeans&json=true&page=1
    var productsArray: [Product] = []
    var isFetching = false
    var soyButtonSelectedNew = false
    var lactoseButtonSelectedNew = false
    var treenutButtonSelectedNew = false
    var peanutButtonSelectedNew = false
    var wheatButtonSelectedNew = false
    var eggButtonSelectedNew = false
    var fishButtonSelectedNew = false
    var shellfishButtonSelectedNew = false
    var productCategoryNew = ""
    
    func buildURL(urlString: String, soyButtonSelected: Bool, lactoseButtonSelected: Bool, treenutButtonSelected: Bool, peanutButtonSelected: Bool, wheatButtonSelected: Bool, eggButtonSelected: Bool, fishButtonSelected: Bool, shellfishButtonSelected: Bool, productCategory: String) -> String{
        soyButtonSelectedNew = soyButtonSelected
        lactoseButtonSelectedNew = lactoseButtonSelected
        treenutButtonSelectedNew = treenutButtonSelected
        peanutButtonSelectedNew = peanutButtonSelected
        wheatButtonSelectedNew = wheatButtonSelected
        eggButtonSelectedNew = eggButtonSelected
        fishButtonSelectedNew = fishButtonSelected
        shellfishButtonSelectedNew = shellfishButtonSelected
        productCategoryNew = productCategory
        var finalURLString = urlString
        let soyArray: [String] = soyAllergy(soyButtonSelected: soyButtonSelected)
        let lactoseArray: [String] = lactoseAllergy(lactoseButtonSelected: lactoseButtonSelected)
        let treenutArray: [String] = treenutAllergy(treenutButtonSelected: treenutButtonSelected)
        let peanutArray: [String] = peanutAllergy(peanutButtonSelected: peanutButtonSelected)
        let wheatArray: [String] = wheatAllergy(wheatButtonSelected: wheatButtonSelected)
        let eggArray: [String] = eggAllergy(eggButtonSelected: eggButtonSelected)
        let fishArray: [String] = fishAllergy(fishButtonSelected: fishButtonSelected)
        let shellfishArray: [String] = shellfishAllergy(shellfishButtonSelected: shellfishButtonSelected)
        let categoryArray: [String] = categoryString(productCategory: productCategory)
        var tagNumber = 0
        let tagType = "&tagtype_"
        let tag_contains = "&tag_contains_"
        let tag = "&tag_"
        let endPart = "&json=true&page="
        if !soyArray.isEmpty {
                finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(soyArray[0])" + tag_contains + "\(tagNumber)" + "=\(soyArray[1])" + tag + "\(tagNumber)" + "=\(soyArray[2])"
                tagNumber = tagNumber + 1
            }
        if !lactoseArray.isEmpty {
            finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(lactoseArray[0])" + tag_contains + "\(tagNumber)" + "=\(lactoseArray[1])" + tag + "\(tagNumber)" + "=\(lactoseArray[2])"
            tagNumber = tagNumber + 1
        }
        if !treenutArray.isEmpty {
            finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(treenutArray[0])" + tag_contains + "\(tagNumber)" + "=\(treenutArray[1])" + tag + "\(tagNumber)" + "=\(treenutArray[2])"
            tagNumber = tagNumber + 1
        }
        if !peanutArray.isEmpty {
            finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(peanutArray[0])" + tag_contains + "\(tagNumber)" + "=\(peanutArray[1])" + tag + "\(tagNumber)" + "=\(peanutArray[2])"
            tagNumber = tagNumber + 1
        }
        if !wheatArray.isEmpty {
            finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(wheatArray[0])" + tag_contains + "\(tagNumber)" + "=\(wheatArray[1])" + tag + "\(tagNumber)" + "=\(wheatArray[2])"
            tagNumber = tagNumber + 1
        }
        if !eggArray.isEmpty {
            finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(eggArray[0])" + tag_contains + "\(tagNumber)" + "=\(eggArray[1])" + tag + "\(tagNumber)" + "=\(eggArray[2])"
            tagNumber = tagNumber + 1
        }
        if !fishArray.isEmpty {
            finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(fishArray[0])" + tag_contains + "\(tagNumber)" + "=\(fishArray[1])" + tag + "\(tagNumber)" + "=\(fishArray[2])"
            tagNumber = tagNumber + 1
        }
        if !shellfishArray.isEmpty {
            finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(shellfishArray[0])" + tag_contains + "\(tagNumber)" + "=\(shellfishArray[1])" + tag + "\(tagNumber)" + "=\(shellfishArray[2])"
            tagNumber = tagNumber + 1
        }
        if !categoryArray.isEmpty {
            finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(categoryArray[0])" + tag_contains + "\(tagNumber)" + "=\(categoryArray[1])" + tag + "\(tagNumber)" + "=\(categoryArray[2])"
            tagNumber = tagNumber + 1
        }
        
        finalURLString = finalURLString + endPart
        if page == 1 {
            finalURLString = finalURLString + "1"
        }
        return finalURLString
    }
    
    
    func soyAllergy(soyButtonSelected: Bool) -> [String]{
        var returnString: [String] = []
        if soyButtonSelected {
            returnString.append("allergens")
            returnString.append("does_not_contain")
            returnString.append("Soybeans")
        }
        return returnString
    }
    
    func lactoseAllergy(lactoseButtonSelected: Bool) -> [String]{
        var returnString: [String] = []
        if lactoseButtonSelected {
            returnString.append("allergens")
            returnString.append("does_not_contain")
            returnString.append("Milk")
        }
        return returnString
    }
    func treenutAllergy(treenutButtonSelected: Bool) -> [String]{
        var returnString: [String] = []
        if treenutButtonSelected {
            returnString.append("allergens")
            returnString.append("does_not_contain")
            returnString.append("Nuts")
        }
        return returnString
    }
    func peanutAllergy(peanutButtonSelected: Bool) -> [String]{
        var returnString: [String] = []
        if peanutButtonSelected {
            returnString.append("allergens")
            returnString.append("does_not_contain")
            returnString.append("Nuts")
        }
        return returnString
    }
    func wheatAllergy(wheatButtonSelected: Bool) -> [String]{
        var returnString: [String] = []
        if wheatButtonSelected {
            returnString.append("allergens")
            returnString.append("does_not_contain")
            returnString.append("Nuts")
        }
        return returnString
    }
    func eggAllergy(eggButtonSelected: Bool) -> [String]{
        var returnString: [String] = []
        if eggButtonSelected {
            returnString.append("allergens")
            returnString.append("does_not_contain")
            returnString.append("Nuts")
        }
        return returnString
    }
    func fishAllergy(fishButtonSelected: Bool) -> [String]{
        var returnString: [String] = []
        if fishButtonSelected {
            returnString.append("allergens")
            returnString.append("does_not_contain")
            returnString.append("Nuts")
        }
        return returnString
    }
    func shellfishAllergy(shellfishButtonSelected: Bool) -> [String]{
        var returnString: [String] = []
        if shellfishButtonSelected {
            returnString.append("allergens")
            returnString.append("does_not_contain")
            returnString.append("Nuts")
        }
        return returnString
    }
    func categoryString(productCategory: String) -> [String]{
        var returnString: [String] = []
        returnString.append("categories")
        returnString.append("contains")
        returnString.append(productCategory)
        return returnString
    }
    
    func getData(completed: @escaping () -> ()) {
        guard isFetching == false else {
            return
        }
        
        isFetching = true
        
        let newurlString = buildURL(urlString: urlString, soyButtonSelected: soyButtonSelectedNew, lactoseButtonSelected: lactoseButtonSelectedNew, treenutButtonSelected: treenutButtonSelectedNew, peanutButtonSelected: peanutButtonSelectedNew, wheatButtonSelected: wheatButtonSelectedNew, eggButtonSelected: eggButtonSelectedNew, fishButtonSelected: fishButtonSelectedNew, shellfishButtonSelected: shellfishButtonSelectedNew, productCategory: productCategoryNew)
        print("🕸 We are accessing the url \(urlString)")
        guard let url = URL(string: newurlString) else {
            print("😡 ERROR: Couldn't not create a URL from \(urlString)")
            isFetching = false
            completed()
            return
        }
        
        // Create Session
        let session = URLSession.shared
        
        // get data with .dataTask method
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription)")
            }
            
            // deal with the data
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                self.page = returned.page
                self.page_count = returned.page_count
                self.page_size = returned.page_size
                self.count = returned.count
                if self.page < (self.count/self.page_size) {
                    self.urlString = self.urlString + "\(self.page+1)"
                }
                for product in returned.products {
                    if product.product_name != "" {
                        self.productsArray = self.productsArray + [product]
                    }
                }
                
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
            self.isFetching = false
            completed()
        }
        
        task.resume()
    }
}
