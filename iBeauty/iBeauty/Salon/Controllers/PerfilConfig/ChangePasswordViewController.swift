//
//  ChangePasswordViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 04/06/21.
//

import UIKit
import SVProgressHUD

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    
    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enableButton(enable: false)
        
        title = "Alteração de senha"
        
        currentPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        newPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        confirmNewPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        verifyFields()
    }
    
    func verifyFields(){
        if currentPasswordTextField.text != "" && newPasswordTextField.text != "" && newPasswordTextField.text != "" && confirmNewPasswordTextField.text == newPasswordTextField.text {
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
        UserAPI.changePassword(userID: AppContextHelper.share.userID ?? "", currentPassword: currentPasswordTextField.text ?? "", newPassword: newPasswordTextField.text ?? "") { user, error in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if error == nil {
                self.navigationController?.popViewController(animated: true)
            } else {
                var message = ""
                
                if error?.message == ""{
                    message = "Ocorreu um erro na troca da senha"
                }
                
                self.showAlertToast(title: message, displayTime: 10.0)
            }
        }
    }
    
}
