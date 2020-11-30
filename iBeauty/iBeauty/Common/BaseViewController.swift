//
//  BaseViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 19/11/20.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTapDismiss()
    }
    
    private func setupTapDismiss(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }

}
