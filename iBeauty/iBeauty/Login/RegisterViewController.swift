//
//  RegisterViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 14/11/20.
//

import UIKit

class RegisterViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: MaskTextField!
    @IBOutlet weak var cpfTextField: MaskTextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func setupFields(){
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        phoneTextField.formatPattern = "(##) #####-####"
        
        cpfTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        cpfTextField.formatPattern = "###.###.###-##"
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        verifyFields()
    }
    
    func verifyFields(){
        if nameTextField.text != "" && emailTextField.text != "" && emailTextField.text?.isValidEmail() == true && phoneTextField.text != "" && phoneTextField.text?.count != phoneTextField.formatPattern.count  && cpfTextField.text != "" && cpfTextField.text?.count != cpfTextField.formatPattern.count && cpfTextField.text?.isCPF == true && passwordTextField.text != "" && confirmPasswordTextField.text != "" && confirmPasswordTextField.text == passwordTextField.text{
            enableButton(enable: true)
        }
        else{
            enableButton(enable: false)
        }
    }
    
    func enableButton(enable:Bool){
        registerButton.backgroundColor = enable ? .darkGray : .lightGray
        registerButton.isEnabled = enable
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
