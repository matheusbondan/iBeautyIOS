//
//  LoginViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 14/11/20.
//

import UIKit
import SVProgressHUD

protocol LoginViewControllerDelegate {
    func login()
}

class LoginViewController: BaseViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    
    var isLoginIntern:Bool = false
    
    var delegate:LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        enableButton(enable: false)
        rememberMeSwitch.isOn = false
        
        self.title = "Login"
        
        if isLoginIntern{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(addTapped))
        }
    }
    
    @objc func addTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if let d = delegate{
            d.login()
        }
        
        AppContextHelper.share.rememberMe = rememberMeSwitch.isOn
        AppContextHelper.share.email = emailTextField.text
        AppContextHelper.share.isLogged = true
         
        SVProgressHUD.show()
        LoginAPI().login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (user, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if error == nil{
                AppContextHelper.share.currentUser = user?.user
                AppContextHelper.share.userID = user?.user?.userId ?? ""
                AppContextHelper.share.jwt = user?.token
                print("SUCESSO: \(user)")
                if self.isLoginIntern{
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNavController"){
                        vc.modalPresentationStyle = .overFullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
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
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController"){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        verifyFields()
    }
    
    func verifyFields(){
        if emailTextField.text != "" && emailTextField.text?.isValidEmail() == true && passwordTextField.text != ""{
            enableButton(enable: true)
        }
        else{
            enableButton(enable: false)
        }
    }
    
    func enableButton(enable:Bool){
        loginButton.backgroundColor = enable ? .darkGray : .lightGray
        loginButton.isEnabled = enable
    }
    
    
}

