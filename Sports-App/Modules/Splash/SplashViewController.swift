//
//  SplashViewController.swift
//  SportsApp
//
//  Created by Moaz Khaled on 1/06/2023.
//

import UIKit
import Lottie


class SplashViewController: UIViewController {
    private let animationView = LottieAnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let vc = self.storyboard?.instantiateViewController(identifier: "SplashTabBarController") as! SplashTabBarController
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    private func setupAnimations(){
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: 400)
        animationView.center = view.center
        view.addSubview(animationView)
        animationView.animation = LottieAnimation.named("splash")
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
}

