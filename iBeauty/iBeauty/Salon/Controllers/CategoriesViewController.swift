//
//  CategoriesViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 14/10/20.
//

import UIKit
import SVProgressHUD

class CategoriesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var dataSource:[CategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        SVProgressHUD.show()
        SalonAPI().getCategories { (categories, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if error == nil{
                self.dataSource = categories ?? []
            }
            else{
                self.showAlertToast(title: "Ocorreu um erro para listas as categorias", displayTime: 10.0)
            }
            self.tableView.reloadData()
        }
    }
    
    func getImageFromType(type:String) -> UIImage {
        switch type {
        case "manicure":
            return UIImage.init(named: "manicure")!
        case "makeup":
            return UIImage.init(named: "maquiagem")!
        case "hair":
            return UIImage.init(named: "cabelo")!
        case "barber":
            return UIImage.init(named: "barbearia")!
        case "depilation":
            return UIImage.init(named: "depilacao")!
        case "massage":
            return UIImage.init(named: "massagem")!
        default:
            return UIImage.init(named: "")!
        }
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        SalonAPI().getCategories { (categories, error) in
            if error == nil{
                self.dataSource = categories ?? []
            }
            else{
                self.showAlertToast(title: "Ocorreu um erro para listas as categorias", displayTime: 10.0)
            }
            self.tableView.reloadData()
        }
    }
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categorieCell", for: indexPath) as! CategoriesTableViewCell
        
        let model = dataSource[indexPath.row]
        
        cell.setupCell(text: model.name ?? "", image: self.getImageFromType(type: model.type ?? ""))
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ServiceViewController") as? ServiceViewController{
            
            vc.category = dataSource[indexPath.row]
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
