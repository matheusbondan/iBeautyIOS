//
//  AlertConfirmationViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 22/10/20.
//

import UIKit

protocol AlertConfirmationDelegate {
    func cancel()
    func confirmation()
}

class AlertConfirmationViewController: UIViewController {

    
    @IBOutlet weak var viewButtons: UIView!
    @IBOutlet weak var labelMessage: UILabel!
    
    var salon:SalonModel?
    var service:ServiceModel?
    var employee:EmployeeModel?
    
    var timeText:String?
    var dateText:String?
    
    var delegate:AlertConfirmationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewButtons.layer.cornerRadius = 15
        
        viewButtons.layer.borderWidth = 1
        viewButtons.layer.borderColor = UIColor.black.cgColor
        
        labelMessage.text = "Você confirma \(service?.name ?? "") em \(dateText ?? "") às \(timeText ?? "") com a \(employee?.name ?? "")"
    }

    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        delegate?.confirmation()
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        delegate?.cancel()
        dismiss(animated: true, completion: nil)
    }
    
}
