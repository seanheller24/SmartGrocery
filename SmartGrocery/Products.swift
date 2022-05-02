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
    var urlString = "https://us.openfoodfacts.org/cgi/search.pl?action=process&tagtype_0=allergens&tag_contains_0=contains&tag_0=milk&tagtype_1=allergens&tag_contains_1=contains&tag_1=soybeans&json=true&page=1"
    // https://us.openfoodfacts.org/cgi/search.pl?action=process&tagtype_0=allergens&tag_contains_0=contains&tag_0=milk&tagtype_1=allergens&tag_contains_1=contains&tag_1=soybeans&json=true&page=1
    var productsArray: [Product] = []
    var isFetching = false
    var soyButtonSelected1 = false
    var lactoseButtonSelected1 = false
    var treenutButtonSelected1 = false
    var peanutButtonSelected1 = false
    var wheatButtonSelected1 = false
    var eggButtonSelected1 = false
    var fishButtonSelected1 = false
    var shellfishButtonSelected1 = false
    var productCategory1 = ""
    
    func buildURL(urlString: String, soyButtonSelected: Bool, lactoseButtonSelected: Bool, treenutButtonSelected: Bool, peanutButtonSelected: Bool, wheatButtonSelected: Bool, eggButtonSelected: Bool, fishButtonSelected: Bool, shellfishButtonSelected: Bool, productCategory: String) -> String{
        soyButtonSelected1 = soyButtonSelected
        lactoseButtonSelected1 = lactoseButtonSelected
        treenutButtonSelected1 = treenutButtonSelected
        peanutButtonSelected1 = peanutButtonSelected
        wheatButtonSelected1 = wheatButtonSelected
        eggButtonSelected1 = eggButtonSelected
        fishButtonSelected1 = fishButtonSelected
        shellfishButtonSelected1 = shellfishButtonSelected
        productCategory1 = productCategory
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
        var filterArrays: [[String]] = []
        filterArrays.append(soyArray)
        filterArrays.append(lactoseArray)
        filterArrays.append(treenutArray)
        filterArrays.append(peanutArray)
        filterArrays.append(wheatArray)
        filterArrays.append(eggArray)
        filterArrays.append(fishArray)
        filterArrays.append(shellfishArray)
        filterArrays.append(categoryArray)
        var tagNumber = 0
        let tagType = "&tagtype_"
        let tag_contains = "&tag_contains_"
        let tag = "&tag_"
        let endPart = "json=true&page=1"
        for filterArray in filterArrays {
            if !filterArray.isEmpty {
                finalURLString = finalURLString + tagType + "\(tagNumber)" + "=\(filterArray[0])" + tag_contains + "\(tagNumber)" + "=\(filterArray[1])" + tag + "\(tagNumber)" + "=\(filterArray[2])"
                tagNumber = tagNumber + 1
            }
        }
        finalURLString = finalURLString + endPart
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
        
        print("🕸 We are accessing the url \(urlString)")
        urlString = buildURL(urlString: urlString, soyButtonSelected: soyButtonSelected1, lactoseButtonSelected: lactoseButtonSelected1, treenutButtonSelected: treenutButtonSelected1, peanutButtonSelected: peanutButtonSelected1, wheatButtonSelected: wheatButtonSelected1, eggButtonSelected: eggButtonSelected1, fishButtonSelected: fishButtonSelected1, shellfishButtonSelected: shellfishButtonSelected1, productCategory: productCategory1)
        guard let url = URL(string: urlString) else {
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
