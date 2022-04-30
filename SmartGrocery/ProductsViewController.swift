//
//  ProductsViewController.swift
//  SmartGrocery
//
//  Created by Sean Heller on 4/30/22.
//

import UIKit

class ProductsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var products = Products()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        products.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ProductsViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.productsArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row+1 == products.productsArray.count {
                products.getData {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "\(indexPath.row+1). \(products.productsArray[indexPath.row].product_name)"
            return cell
        }
}
