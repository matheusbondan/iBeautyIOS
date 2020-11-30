//
//  CategoriesViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 14/10/20.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource:[CategorieModelCell] = [CategorieModelCell.init(image: UIImage.init(named: "manicure"), text: "Manicure e Pedicure"),CategorieModelCell.init(image: UIImage.init(named: "maquiagem"), text: "Maquiagem"),CategorieModelCell.init(image: UIImage.init(named: "cabelo"), text: "Cabelo"), CategorieModelCell.init(image: UIImage.init(named: "barbearia"), text: "Barbearia"),  CategorieModelCell.init(image: UIImage.init(named: "depilacao"), text: "Depilação") ,  CategorieModelCell.init(image: UIImage.init(named: "massagem"), text: "Massagem")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorieCell", for: indexPath) as! CategoriesTableViewCell
        
        let model = dataSource[indexPath.row]
        
        cell.setupCell(text: model.text!, image: model.image!)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "SalonListViewController"){
//            navigationController?.pushViewController(vc, animated: true)
//        }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceViewController") as? ServiceViewController{
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

class CategorieModelCell:NSObject {
    var image:UIImage?
    var text:String?
    
    init(image:UIImage?, text:String?) {
        self.image = image
        self.text = text
    }
}
