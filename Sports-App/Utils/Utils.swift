//
//  Utils.swift
//  Sports-App
//
//  Created by Moaz Khaled on 21/05/2023.
//

import Foundation
import UIKit

class Utils{
    
    static func showAlert(viewController:UIViewController,Title: String, Message: String) {
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    static func showToastMessage(view: UIView,message: String, color: UIColor) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.width / 2 - 120, y: view.frame.height - 130, width: 260, height: 30))

        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = color
        toastLabel.textColor = .white
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        view.addSubview(toastLabel)

        UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseIn, animations: {
            toastLabel.alpha = 0.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
    
    static func getSportStadium(sportType:SportsType)-> String {
        switch sportType {
            case .football:
                return "football-stadium"
            case .basketball:
                return "basketball-stadium"
            case .cricket:
                return "cricket-stadium"
            case .tennis:
                return "tennis-stadium"
        }
    }

    
    
    
}
