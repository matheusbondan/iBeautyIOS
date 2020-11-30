//
//  SceduleViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 22/10/20.
//

import UIKit

class ScheduleViewController: UIViewController {

    var salon:SalonModel?
    var service:ServiceModel?
    var employee:EmployeeModel?
    var timeText:String?
    var dateText:String?
    var dateModel:DateScheduleModel?
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var daySelectedIndex:Int?
    var timeSelectedIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt_BR")
        let nameOfMonth = dateFormatter.string(from: now)
        monthLabel.text = nameOfMonth.capitalizingFirstLetter()
 
        employeeNameLabel.text = self.employee?.name
        priceLabel.text = employee?.price
        
        dayLabel.text = dateText
        timeLabel.text = timeText
        
        self.title = self.service?.name
    }

    @IBAction func sceduleButtonAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AlertConfirmationViewController") as? AlertConfirmationViewController{
            vc.salon = self.salon
            vc.service = self.service
            vc.employee = self.employee
            
            
            vc.dateText = dateText
            vc.timeText = timeText
            
            vc.delegate = self
            
            vc.modalPresentationStyle = .custom
            vc.modalTransitionStyle = .crossDissolve
            
            self.present(vc, animated: true, completion: nil)
        }
    }
}

extension ScheduleViewController:AlertConfirmationDelegate{
    func cancel() {}
    
    func confirmation() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SuccessConfirmViewController") as? SuccessConfirmViewController{
            vc.salon = self.salon
            vc.service = self.service
            vc.employee = self.employee
            
            vc.dateText = dateText
            vc.timeText = timeText
            vc.dateModel = dateModel
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
class SceduleDayCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var weekDayLabel: UILabel!
}

class SceduleTimeCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var viewBack: UIView!
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


