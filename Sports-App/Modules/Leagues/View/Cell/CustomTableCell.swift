//
//  CustomTableCell.swift
//  Sports-App
//
//  Created by Moaz Khaled on 21/05/2023.
//

import UIKit

class CustomTableCell: UITableViewCell {

   
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgView.layer.cornerRadius = imgView.frame.height/2
        self.layer.cornerRadius = self.frame.height/2
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
   
}
