//
//  SuccessConfirmViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 29/10/20.
//

import UIKit

class SuccessConfirmViewController: UIViewController {

    @IBOutlet weak var salonImage: UIImageView!
    @IBOutlet weak var dateCompleteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var employeeName: UILabel!
    @IBOutlet weak var employeeService: UILabel!
    
    @IBOutlet weak var priceService: UILabel!
    
    var salon:SalonModel?
    var service:ServiceModel?
    var employee:EmployeeModel?
    
    var timeText:String?
    var dateText:String?
    
    var dateModel:DateScheduleModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Agendamento"
        
        
        salonImage.image = self.salon?.image
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd 'de' MMMM"
        dateFormatter.locale = Locale.init(identifier: "pt_BR")
        let dateComplete = dateFormatter.string(from: dateModel?.date ?? Date())
        
        dateCompleteLabel.text = dateComplete
        
        timeLabel.text = "às \(timeText ?? "")"
        addressLabel.text = self.salon?.address
        employeeName.text = self.employee?.name
        employeeService.text = self.service?.name
        priceService.text = self.employee?.price
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func okButtonAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    


}
