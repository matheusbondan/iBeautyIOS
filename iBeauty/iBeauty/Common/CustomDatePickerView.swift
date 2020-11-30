//
//  CustomDatePickerView.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 19/11/20.
//

import Foundation
import UIKit

class CustomPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerData : [String]!
    var pickerTextField : UITextField!
    var selectedValue : String!
    
    init(pickerData: [String], selectedValue: String, dropdownField: UITextField) {
        super.init(frame: .zero)
        
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        self.selectedValue = selectedValue
        
        self.delegate = self
        self.dataSource = self
        
        DispatchQueue.main.async {
            if pickerData.count > 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
                
                pickerData.forEach{
                    if $0 == self.selectedValue {
                        let index = self.pickerData.firstIndex(of: $0)
                        self.selectRow(index ?? 0, inComponent: 0, animated: true)
                        self.pickerTextField.text = $0
                    }
                }
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
    }
}


//public class CustomDatePickerView: UIDatePicker {
//
//    var textField: UITextField?
//
//    init(buttonTitle: String?, pickerDates: [Date], dropdownField: UITextField) {
//        super.init(frame: .zero)
//
//        self.textField = dropdownField
//
////        self.datePickerMode = .date
////        self.minimumDate = pickerDates.first
////        self.maximumDate = pickerDates.last
//        self.locale = Locale.init(identifier: "BR")
//        self.addTarget(self, action: #selector(handleDateChange(sender:)), for: .valueChanged)
//
//        /// Toolbar
//
//        if #available(iOS 13.4, *) {
//            self.preferredDatePickerStyle = .wheels
//        }
//
////        self.datePickerMode = .time
////        self.minuteInterval = 30
////
//
//        self.datePickerMode = .time // setting mode to timer so user can only pick time as you want
//        self.minuteInterval = 30  // with interval of 30
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat =  "HH:mm"
//
//        let min = dateFormatter.date(from: "8:00")      //createing min time
//        let max = dateFormatter.date(from: "20:00") //creating max time
//        self.minimumDate = min  //setting min time to picker
//        self.maximumDate = max
//
//
//
//        let toolBar = UIToolbar()
//        toolBar.barStyle = .default
//        toolBar.isTranslucent = false
//
//        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let doneButton = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(onClickDoneButton))
//        doneButton.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .medium)], for: .normal)
//        doneButton.tintColor = UIColor.green
//        toolBar.setItems([space, doneButton], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        toolBar.sizeToFit()
//        dropdownField.inputAccessoryView = toolBar
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func getStringDate(date: Date) -> String {
//        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "dd/MM/yyyy"
//        dateFormatter.dateFormat = "HH:mm"
//        return dateFormatter.string(from: date)
//    }
//
//    // MARK: - target
//
//    @objc private func onClickDoneButton() {
//        self.textField?.text = getStringDate(date: self.date)
//        self.textField?.resignFirstResponder()
//
////        self.textField?.text = date.description
////        self.textField?.resignFirstResponder()
//    }
//
//    @objc private func handleDateChange(sender: UIDatePicker) {
//        self.textField?.text = getStringDate(date: sender.date)
//
////        self.textField?.text = date.description
//    }
//}
