//
//  SceduleViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 22/10/20.
//

import UIKit
import SVProgressHUD

class ScheduleViewController: BaseViewController {

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
    
    var completeDate:String?
    var dateMonthYear:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt_BR")
        let nameOfMonth = dateFormatter.string(from: (dateModel?.date)!)
        monthLabel.text = nameOfMonth.capitalizingFirstLetter()
 
        employeeNameLabel.text = self.employee?.name
        
        dayLabel.text = dateText
        timeLabel.text = timeText
        
        self.title = self.service?.name
        
        let dateFormatterWeekDay = DateFormatter()
        dateFormatterWeekDay.dateFormat = "dd/MM/yyyy"
        dateFormatterWeekDay.locale = Locale.init(identifier: "pt_BR")
        completeDate = dateFormatterWeekDay.string(from: (dateModel?.date)!) + " " + (timeText ?? "")
         
        dateMonthYear = dateFormatterWeekDay.string(from: (dateModel?.date)!)
        
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
        SVProgressHUD.show()
        ScheduleAPI.doAppointment(salonID: self.salon?.idSalon ?? "", completeDate: self.completeDate  ?? "", hour:self.timeText ?? "", dayMonth:dateText ?? "", serviceID: self.service?.serviceId  ?? "", employeeID: self.employee?.employeeId  ?? "", userID: AppContextHelper.share.userID ?? "", dayMonthYear: dateMonthYear ?? "") { appointment, err in
            
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            
            if err == nil {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SuccessConfirmViewController") as? SuccessConfirmViewController{
                    vc.salon = self.salon
                    vc.service = self.service
                    vc.employee = self.employee
                    
                    vc.dateText = self.dateText
                    vc.timeText = self.timeText
                    vc.dateModel = self.dateModel
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                if err?.message == ""{
                    err?.message = "Ocorreu um erro"
                }
                
                self.showAlertToast(title: err?.message ?? "Ocorreu um erro", displayTime: 10)
            }
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


