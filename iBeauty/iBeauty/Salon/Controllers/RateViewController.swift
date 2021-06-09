//
//  RateViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 22/10/20.
//

import UIKit
import SVProgressHUD

class RateViewController: BaseViewController {

    @IBOutlet weak var salonImage: UIImageView!
    var salon:SalonModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource:[RateModel] = []
    @IBOutlet weak var placeholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.salonImage.image = UIImage.init(named: "salao1")

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.estimatedRowHeight = 45
        
        datasource = salon?.ratings ?? []
        tableView.reloadData()
        
        self.title = "Avaliações"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.show()
        
        RateAPI.getRatingsBySalon(salonID: salon?.idSalon ?? "") { ratings, err in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if err == nil {
                self.datasource = ratings ?? []
                
                if self.datasource.count == 0{
                    self.placeholder.isHidden = false
                } else {
                    self.placeholder.isHidden = true
                }
                
                self.tableView.reloadData()
            } else {
                self.showAlertToast(title: "Ocorreu um erro ao carregar as avaliações", displayTime: 10.0)
            }
        }
    }
    
    
    @IBAction func addRateButtonAction(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddCommentViewController") as? AddCommentViewController{
            vc.salon = self.salon

            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension RateViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RateTableViewCell
        
        let model = datasource[indexPath.row]
        
        cell.titleLabel.text = "\(model.user?.username ?? "") avaliou \(self.salon?.name ?? "")"
        cell.descLabel.text = model.comment
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

class RateTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
