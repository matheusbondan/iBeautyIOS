//
//  EmployeeViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 22/10/20.
//

import UIKit

class EmployeeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var salon:SalonModel?
   
    var service:ServiceModel?
    var timeText:String?
    var dateText:String?
    var dateModel:DateScheduleModel?
    
    var dataSource:[EmployeeModel] = [EmployeeModel.init(name: "Sem Prefêrencia", price: "R$ 24,00", image: nil),EmployeeModel.init(name: "Jo", price: "R$ 24,00", image: nil), EmployeeModel.init(name: "Raquel", price: "R$ 24,00", image: nil), EmployeeModel.init(name: "Rê", price: "R$ 24,00", image: nil), EmployeeModel.init(name: "Rita", price: "R$ 24,00", image: nil), EmployeeModel.init(name: "Sheila", price: "R$ 24,00", image: nil)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = service?.name
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

}

extension EmployeeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
        
        cell.setupCell(employee: dataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SceduleViewController") as? ScheduleViewController{
            vc.salon = self.salon
            vc.service = self.service
            vc.employee = dataSource[indexPath.row]
            vc.dateText = self.dateText
            vc.dateModel = self.dateModel
            vc.timeText = self.timeText
            vc.service = self.service
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var employeeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(employee:EmployeeModel){
        nameLabel.text = employee.name
        priceLabel.text = employee.price
        employeeImage.image = employee.image
    }
}


