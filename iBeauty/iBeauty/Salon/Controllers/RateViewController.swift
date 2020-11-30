//
//  RateViewController.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 22/10/20.
//

import UIKit

class RateViewController: UIViewController {

    @IBOutlet weak var salonImage: UIImageView!
    var salon:SalonModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource:[RateModel] = [RateModel(userName: "Leticia Rossignolo", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."), RateModel(userName: "Talita Jacques", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."), RateModel(userName: "Celma Matos", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Cras sed felis eget velit aliquet sagittis. Nullam ac tortor vitae purus faucibus ornare. Tincidunt vitae semper quis lectus nulla at. Semper quis lectus nulla at volutpat diam. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Feugiat pretium nibh ipsum consequat nisl vel pretium. Facilisis mauris sit amet massa vitae tortor condimentum. Duis at tellus at urna condimentum mattis. Amet risus nullam eget felis eget nunc lobortis mattis. Donec adipiscing tristique risus nec feugiat in fermentum posuere urna."), RateModel(userName: "Eliane G Martins", message: "Tempus quam pellentesque nec nam aliquam sem. Elementum nibh tellus molestie nunc non blandit massa. Massa ultricies mi quis hendrerit dolor magna. Tortor posuere ac ut consequat semper viverra nam. Mattis pellentesque id nibh tortor id aliquet. Justo nec ultrices dui sapien eget mi. Fringilla ut morbi tincidunt augue interdum velit euismod. Vestibulum sed arcu non odio euismod lacinia at. Leo urna molestie at elementum eu facilisis. Enim praesent elementum facilisis leo. Tempus iaculis urna id volutpat lacus laoreet non curabitur. Non odio euismod lacinia at quis. Porta non pulvinar neque laoreet. Praesent tristique magna sit amet purus gravida quis.")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.salonImage.image = salon?.image

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tableView.estimatedRowHeight = 45
        
        self.title = "Avaliações"
    }
    

}

extension RateViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RateTableViewCell
        
        let model = datasource[indexPath.row]
        
        cell.titleLabel.text = "\(model.userName ?? "") avaliou \(self.salon?.name ?? "")"
        cell.descLabel.text = model.message
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

class RateModel:NSObject {
    var userName:String?
    var message:String?
    var rate:Double?
    
    init(userName:String?, message:String?) {
        self.userName = userName
        self.message = message
        self.rate = 5
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
