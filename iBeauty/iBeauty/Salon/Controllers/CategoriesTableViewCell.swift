//
//  CategoriesTableViewCell.swift
//  iBeauty
//
//  Created by Matheus Baptista Bondan on 14/10/20.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categorieImage: UIImageView!
    @IBOutlet weak var categorieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setupCell(text:String, image:UIImage){
        self.categorieImage.image = image
        self.categorieLabel.text = text
    }
}
