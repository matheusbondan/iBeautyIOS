//
//  ServiceViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 22/10/20.
//

import UIKit

class ServiceViewController: UIViewController {

    var salon:SalonModel?
    
    var category:CategoryModel?
    
    @IBOutlet weak var tableView: UITableView!
//    var dataSource:[ServiceModel] = [ServiceModel.init(name: "Manicure Decorado", price: "A partir de R$ 25,00", time: "40m"), ServiceModel.init(name: "Manicure Francesinha", price: "R$ 24,00", time: "1h"), ServiceModel.init(name: "Manicure Simples", price: "R$ 20,00", time: "1h"), ServiceModel.init(name: "Pedicure Decorada", price: "A partir de R$ 35,00", time: "40m"), ServiceModel.init(name: "Pedicure Francesinha", price: "R$ 34,00", time: "1h"), ServiceModel.init(name: "Pedicure Simples", price: "R$ 30,00", time: "1h")]
    var dataSource:[ServiceModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = category?.services ?? []
        tableView.reloadData()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
    }

}

extension ServiceViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceTableViewCell", for: indexPath) as! ServiceTableViewCell
        
        cell.setupCell(service: dataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        if let vc = storyboard?.instantiateViewController(withIdentifier: "EmployeeViewController") as? EmployeeViewController{
        //            vc.salon = self.salon
        //            vc.service = dataSource[indexPath.row]
        //
        //            navigationController?.pushViewController(vc, animated: true)
        //        }
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "TimeViewController") as? TimeViewController{
            vc.service = dataSource[indexPath.row]
            vc.category = self.category
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

class ServiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setupCell(service:ServiceModel){
        nameLabel.text = service.name
//        priceLabel.text = service.price
//        timeLabel.text = service.time
    }
}


