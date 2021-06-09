//
//  EditDataViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 04/06/21.
//

import UIKit
import SVProgressHUD

class EditDataViewController: BaseViewController {

    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: MaskTextField!
    @IBOutlet weak var cpfTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enableButton(enable: false)
        
        title = "Alteração de dados"
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        addCurrentData()
        
    }
    
    private func addCurrentData(){
        cpfTextField.text = AppContextHelper.share.currentUser?.cpf
        nameTextField.text = AppContextHelper.share.currentUser?.username
        emailTextField.text = AppContextHelper.share.currentUser?.email
        phoneTextField.text = AppContextHelper.share.currentUser?.phone
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        verifyFields()
    }
    
    func verifyFields(){
        if (nameTextField.text != "" || emailTextField.text != "" || phoneTextField.text != "") && (nameTextField.text != AppContextHelper.share.currentUser?.username || emailTextField.text != AppContextHelper.share.currentUser?.email || phoneTextField.text != AppContextHelper.share.currentUser?.phone){
            enableButton(enable: true)
        }
        else{
            enableButton(enable: false)
        }
    }
    
    func enableButton(enable:Bool){
        changeButton.backgroundColor = enable ? .darkGray : .lightGray
        changeButton.isEnabled = enable
    }
    
    @IBAction func changeButtonAction(_ sender: Any) {
        SVProgressHUD.show()
        
        var email = ""
        var phone = ""
        var name = ""
        
        if phoneTextField.text != AppContextHelper.share.currentUser?.phone && phoneTextField.text != ""{
            phone = phoneTextField.text ?? ""
        }
        
        if nameTextField.text != AppContextHelper.share.currentUser?.username && nameTextField.text != ""{
            name = nameTextField.text ?? ""
        }
        
        if emailTextField.text != AppContextHelper.share.currentUser?.email && emailTextField.text != ""{
            email = emailTextField.text ?? ""
        }
        
        UserAPI.changeUserData(userID: AppContextHelper.share.userID ?? "", email: email, name: name, phone: phone) { user, error in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if error == nil {
                AppContextHelper.share.currentUser = user
                self.navigationController?.popViewController(animated: true)
            } else {
                var message = ""
                
                if error?.message == ""{
                    message = "Ocorreu um erro na troca da dados!"
                }
                
                self.showAlertToast(title: message, displayTime: 10.0)
            }
        }
    }
    
}
