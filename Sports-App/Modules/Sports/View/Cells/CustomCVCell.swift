//
//  CustomCollectionViewCell.swift
//  Sports-App
//
//  Created by Moaz Khaled on 21/05/2023.
//

import UIKit
import SwiftUI

class CustomCVCell: UICollectionViewCell {

    @IBOutlet weak var sportsImageView: UIImageView!
    
    @IBOutlet weak var sportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 20
        //sportsImageView.layer.cornerRadius = sportsImageView.frame.height/2
        
//        self.layer.backgroundColor = Color.gray.opacity(0.2).cgColor
//        self.layer.borderColor = Color.accentColor.cgColor
//        self.layer.borderWidth = 2
    }

}
