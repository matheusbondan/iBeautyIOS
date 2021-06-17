//
//  RegisterViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 14/11/20.
//

import UIKit
import SVProgressHUD

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
        setupFields()
    }
    
    private func setupFields(){
        enableButton(enable: true)
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
    
    func verifyFields() -> Bool{
        if nameTextField.text != "" && emailTextField.text != "" && emailTextField.text?.isValidEmail() == true && phoneTextField.text != "" && phoneTextField.text?.count == phoneTextField.formatPattern.count  && cpfTextField.text != "" && cpfTextField.text?.count == cpfTextField.formatPattern.count && cpfTextField.text?.isCPF == true && passwordTextField.text != "" && confirmPasswordTextField.text != "" && confirmPasswordTextField.text == passwordTextField.text{
            return true
        }
        else{
            return false
        }
    }
    
    func enableButton(enable:Bool){
        registerButton.backgroundColor = enable ? .darkGray : .lightGray
        registerButton.isEnabled = enable
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if verifyFields(){
            SVProgressHUD.show()
            LoginAPI().register(name: nameTextField.text ?? "", email: emailTextField.text ?? "", phone: phoneTextField.text ?? "", cpf: cpfTextField.text ?? "", password: passwordTextField.text ?? "") { (user, error) in
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
                if error == nil{
    //                self.navigationController?.popViewController(animated: true)
                    self.showAlertToast(title: "Cadastro realizado com sucesso!", displayTime: 10)
                    
                    AppContextHelper.share.currentUser = user?.user
                    AppContextHelper.share.userID = user?.user?.userId ?? ""
                    AppContextHelper.share.jwt = user?.token
                    AppContextHelper.share.isLogged = true
                    
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNavController"){
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                else{
                    if error?.message == ""{
                        error?.message = "Ocorreu um erro"
                    }
                    
                    self.showAlertToast(title: error?.message ?? "Ocorreu um erro", displayTime: 10)
                    print("ERROOO: \(error)")
                }
            }
        }
        else {
            showErrorAlert()
        }
    }
    
    func showErrorAlert(){
        if nameTextField.text == ""{
            self.showAlertToast(title: "O campo nome é obrigatório!", displayTime: 10)
        } else if emailTextField.text == ""{
            self.showAlertToast(title: "O campo email é obrigatório!", displayTime: 10)
        } else if emailTextField.text?.isValidEmail() == false{
            self.showAlertToast(title: "O campo email está com o formato incorreto!", displayTime: 10)
        } else if phoneTextField.text == ""{
            self.showAlertToast(title: "O campo telefone é obrigatório!", displayTime: 10)
        } else if phoneTextField.text?.count != phoneTextField.formatPattern.count{
            self.showAlertToast(title: "O campo telefone está com o formato incorreto!", displayTime: 10)
        } else if cpfTextField.text == ""{
            self.showAlertToast(title: "O campo CPF é obrigatório!", displayTime: 10)
        } else if cpfTextField.text?.count != cpfTextField.formatPattern.count{
            self.showAlertToast(title: "O campo CPF está com o formato incorreto!", displayTime: 10)
        } else if cpfTextField.text?.isCPF == false{
            self.showAlertToast(title: "O campo CPF está inválido!", displayTime: 10)
        } else if passwordTextField.text == ""{
            self.showAlertToast(title: "O campo de senha é obrigatório!", displayTime: 10)
        } else if confirmPasswordTextField.text == ""{
            self.showAlertToast(title: "O campo confirmação de senha é obrigatório!", displayTime: 10)
        } else if confirmPasswordTextField.text != passwordTextField.text{
            self.showAlertToast(title: "Os campos senha e confirmação de senha estão diferentes!", displayTime: 10)
        } else {
            self.showAlertToast(title: "Os campos com * são obrigatorios", displayTime: 10)
        }
    }
}
