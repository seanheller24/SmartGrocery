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
    var productsArray: [Product] = []
    var isFetching = false
    
    func getData(completed: @escaping () -> ()) {
        guard isFetching == false else {
            return
        }
        
        isFetching = true
        
        print("🕸 We are accessing the url \(urlString)")
        
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
                    self.urlString = "https://us.openfoodfacts.org/cgi/search.pl?action=process&tagtype_0=allergens&tag_contains_0=contains&tag_0=milk&tagtype_1=allergens&tag_contains_1=contains&tag_1=soybeans&json=true&page=\(self.page+1)"
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
