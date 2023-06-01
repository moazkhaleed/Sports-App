//
//  ResultCVCell.swift
//  Sports-App
//
//  Created by Moaz Khaled on 24/05/2023.
//

import UIKit
import SwiftUI

class ResultCVCell: UICollectionViewCell {

   
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    
    @IBOutlet weak var awayImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
//        awayImage.layer.cornerRadius = awayImage.frame.height/2
//        homeImage.layer.cornerRadius = homeImage.frame.height/2
//        homeImage.layer.borderColor = Color.accentColor.cgColor
//        awayImage.layer.borderColor = Color.accentColor.cgColor
//        homeImage.layer.borderWidth = 1.5
//        awayImage.layer.borderWidth = 1.5
        
        
        // Initialization code
    }

}
