//
//  FirstViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 14/11/20.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Inicio"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController"){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController"){
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func accessWithoutLoginButtonAction(_ sender: Any) {
        AppContextHelper.share.isLogged = false
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MainNavController"){
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
