//
//  MyAppointmentsViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 04/06/21.
//

import UIKit
import SVProgressHUD
class MyAppointmentsViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource:[AppointmentModel] = []
    @IBOutlet weak var placeholderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Meus agendamentos"
        
        tableView.tableFooterView = UIView()

        tableView.estimatedRowHeight = 105
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.show()
        UserAPI.getAppointments(userID: AppContextHelper.share.userID ?? "") { appointments, error in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if error == nil {
                self.placeholderLabel.isHidden = true
                self.datasource = appointments ?? []
                if self.datasource.count == 0 {
                    self.showError(text: "Você ainda não tem agendamentos!")
                }
                self.tableView.reloadData()
            } else {
                self.showAlertToast(title: "Aconteceu um erro ao carregar os agendamentos", displayTime: 10.0)
                self.showError(text: "Aconteceu um erro ao carregar os agendamentos")
            }
        }
    }

    private func showError(text:String){
        placeholderLabel.text = text
        placeholderLabel.isHidden = false
    }
}

extension MyAppointmentsViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAppointmentsTableViewCell", for: indexPath) as! MyAppointmentsTableViewCell
        
        let appointment = datasource[indexPath.row]
        
        cell.salonLabel.text = appointment.salon?.name ?? ""
        cell.dateLabel.text = appointment.completeDate ?? ""
        cell.serviceLabel.text = "\(appointment.service?.name ?? "") - \(appointment.employee?.name ?? "")"
        cell.addressLabel.text = "\(appointment.salon?.address?.street ?? ""), \(appointment.salon?.address?.number ?? "") \(appointment.salon?.address?.complement ?? "") - \(appointment.salon?.address?.city ?? ""), \(appointment.salon?.address?.state ?? "")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

class MyAppointmentsTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var salonLabel: UILabel!
}
