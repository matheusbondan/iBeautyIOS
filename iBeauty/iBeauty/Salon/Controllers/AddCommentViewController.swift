//
//  AddCommentViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 02/06/21.
//

import UIKit
import SVProgressHUD

class AddCommentViewController: BaseViewController {

    
    @IBOutlet weak var oneStarButton: UIButton!
    @IBOutlet weak var twoStarButton: UIButton!
    @IBOutlet weak var threeStarButton: UIButton!
    @IBOutlet weak var fourStarButton: UIButton!
    @IBOutlet weak var fiveStarButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var salon:SalonModel?
    var placeholder = "Digite um comentário"
    var currentStar = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        var comment = ""
        
        if textView.text != "" && textView.text != placeholder{
            comment = textView.text
        }
        
        SVProgressHUD.show()
        RateAPI.addRate(salonID: salon?.idSalon ?? "", userID: AppContextHelper.share.userID ?? "", rateScore: currentStar, comment: comment) { rate, err in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if err == nil{
                self.navigationController?.popViewController(animated: true)
            }
            else{
                self.showAlertToast(title: "Ocorreu um erro", displayTime: 10)
                print("ERROOO: \(err)")
            }
        }
    }
    
    @IBAction func oneStarAction(_ sender: Any) {
        currentStar = 1
        oneStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        twoStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
        threeStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
        fourStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
    }
    
    @IBAction func twoStarAction(_ sender: Any) {
        currentStar = 2
        oneStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        twoStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        threeStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
        fourStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
    }
    
    @IBAction func threeStarButton(_ sender: Any) {
        currentStar = 3
        oneStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        twoStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        threeStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        fourStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
    }
    
    @IBAction func fourStarAction(_ sender: Any) {
        currentStar = 4
        oneStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        twoStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        threeStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        fourStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "icons8-star-50"), for: .normal)
    }
    
    @IBAction func fiveStarAction(_ sender: Any) {
        currentStar = 5
        oneStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        twoStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        threeStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        fourStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
        fiveStarButton.setImage(UIImage(named: "icons8-star-48"), for: .normal)
    }
}

extension AddCommentViewController:UITextViewDelegate{
    func setPlaceholder(){
        textView.text = placeholder
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != "" && textView.text != placeholder{
            
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setPlaceholder()
        }
    }
}
