//
//  PerfilViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 20/11/20.
//

import UIKit

class PerfilViewController: UIViewController {

    var datasource:[String] = []
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        updateValues()
    }
    
    func updateValues(){
        if AppContextHelper.share.isLogged ?? false{
            emailLabel.text = AppContextHelper.share.email
            datasource = ["Editar dados", "Alterar senha", "Meus agendamentos", "Logout"]
        }
        else{
            emailLabel.text = ""
            datasource = ["Login"]
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        updateValues()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension PerfilViewController:LoginViewControllerDelegate{
    func login() {
        updateValues()
    }
}

extension PerfilViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = datasource[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if AppContextHelper.share.isLogged ?? false{
            if datasource[indexPath.row] == "Editar dados"{
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditDataViewController"){
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if datasource[indexPath.row] == "Alterar senha"{
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController"){
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if datasource[indexPath.row] == "Meus agendamentos"{
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyAppointmentsViewController"){
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if datasource[indexPath.row] == "Logout"{
                AppContextHelper.share.rememberMe = false
                AppContextHelper.share.jwt = nil
                AppContextHelper.share.isLogged = false
                AppContextHelper.share.userID = nil
                AppContextHelper.share.currentUser = nil
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirstNav"){
                    
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
            
            
        }
        else{
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
                
                vc.isLoginIntern = true
                let nav = UINavigationController(rootViewController: vc)
                
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    
}
