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
    
//    var dataSource:[EmployeeModel] = [EmployeeModel.init(name: "Sem Preferência", price: "R$ 24,00", image: nil),EmployeeModel.init(name: "Jo", price: "R$ 24,00", image: nil), EmployeeModel.init(name: "Raquel", price: "R$ 24,00", image: nil), EmployeeModel.init(name: "Rê", price: "R$ 24,00", image: nil), EmployeeModel.init(name: "Rita", price: "R$ 24,00", image: nil), EmployeeModel.init(name: "Sheila", price: "R$ 24,00", image: nil)]
    
    var dataSource:[EmployeeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = service?.name
        
        if let employees = salon?.employees, !employees.isEmpty {
            var arrayEmployees = [EmployeeModel()]
            arrayEmployees.append(contentsOf: employees)
            self.dataSource = arrayEmployees
        }
        tableView.reloadData()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

}

extension EmployeeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
        
        if indexPath.row == 0 {
            cell.nameLabel.text = "Sem Preferência"
        } else {
            cell.setupCell(employee: dataSource[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupCell(employee:EmployeeModel){
        nameLabel.text = employee.name
    }
}


