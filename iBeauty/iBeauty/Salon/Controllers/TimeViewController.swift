//
//  TimeViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 19/11/20.
//

import UIKit

class TimeViewController: BaseViewController {

    
    @IBOutlet weak var hourTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dayCollectionView: UICollectionView!
    
    var daysDataSource:[DateScheduleModel] = []
    
    var daySelectedIndex:Int = 0
    
    var service:ServiceModel?
    var category:CategoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cal = Calendar.current
        var date = cal.startOfDay(for: Date())
        var days = [DateScheduleModel]()
        for i in 1 ... 15 {
            let day = cal.component(.day, from: date)
            let month = cal.component(.month, from: date)
            days.append(DateScheduleModel(day: "\(day)", dayMonth: "\(day)/\(month)", date: date))
            date = cal.date(byAdding: .day, value: 1, to: date)!
        }
        daysDataSource = days
        dayCollectionView.reloadData()
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale.init(identifier: "pt_BR")
        let nameOfMonth = dateFormatter.string(from: now)
        titleLabel.text = nameOfMonth.capitalizingFirstLetter()
        
        hourTextField.loadDropdownData(data: ["09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00"], selected: "09:00")
    }
    
    
    @IBAction func scheduleButtonAction(_ sender: Any) {
        if AppContextHelper.share.isLogged ?? false{
            if let vc = storyboard?.instantiateViewController(withIdentifier: "SalonListViewController") as? SalonListViewController{
                
                vc.dateText = daysDataSource[daySelectedIndex].dayMonth
                vc.dateModel = daysDataSource[daySelectedIndex]
                vc.timeText = hourTextField.text
                vc.service = self.service
                vc.category = self.category
                
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        else{
            let alert = UIAlertController(title: "Atenção", message: "Para buscar estabeleciomentos você precisa fazer login no aplicativo", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Fazer login", style: .default, handler: { (action) in
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
                    
                    vc.isLoginIntern = true
                    let nav = UINavigationController(rootViewController: vc)
                    
                    self.present(nav, animated: true, completion: nil)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
                
            }) )
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}

extension UITextField {
    
    public func loadDropdownData(data: [String], selected: String) {
        self.inputView = CustomPickerView(pickerData: data, selectedValue: selected, dropdownField: self)
    }
    
//    public func loadDateDropdown(buttonTitle: String, dates: [Date]) {
//        self.inputView = CustomDatePickerView(buttonTitle: buttonTitle, pickerDates: dates, dropdownField: self)
//    }
    
    public func invalidateInput() {
        self.inputView = nil
    }
    
}

extension TimeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! SceduleDayCollectionViewCell
        cell.dayLabel.text = daysDataSource[indexPath.row].day
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale.init(identifier: "pt_BR")
        let nameOfMonth = dateFormatter.string(from: daysDataSource[indexPath.row].date!)
        cell.weekDayLabel.text = nameOfMonth.uppercased()
        
        if daySelectedIndex == indexPath.row{
            cell.viewBack.backgroundColor = .black
            cell.dayLabel.textColor = .white
            cell.weekDayLabel.textColor = .white
        }
        else{
            cell.viewBack.backgroundColor = .white
            cell.dayLabel.textColor = .darkGray
            cell.weekDayLabel.textColor = .lightGray
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        daySelectedIndex = indexPath.row
        
        dayCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: 100, height: 120)
    }
    
}
