//
//  DetailBeerViewController.swift.swift
//  BeerApp
//
//  Created by Andrea Gualandris on 02/04/2022.
//

import UIKit

class DetailBeerViewController: UIViewController {
    
    //MARK: - Declare variables
    
    let blurEffect = UIBlurEffect(style: .dark)
    
    lazy var visualEffectView: UIVisualEffectView = {
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        visualEffect.alpha = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismissViewController))
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissViewController))
        swipeDown.direction = .down
        visualEffect.addGestureRecognizer(swipeDown)
        visualEffect.addGestureRecognizer(tapGesture)
        return visualEffect
    }()
    
    let animationTime = 0.4
    
    let detailSlider = DetailViewSlider()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUPUI()
    }
    
    private func setUPUI(){
        visualEffectView.frame = view.bounds
        view.addSubview(visualEffectView)
        performBlurAnimationIn()
        animateDetailSliderUp()
    }
    
    private func performBlurAnimationIn() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            UIView.animate(withDuration: self.animationTime) {
                self.visualEffectView.alpha = 1
            }
        }
    }
    
    private func performBlurAnimationOut(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            UIView.animate(withDuration: self.animationTime) {
                self.visualEffectView.alpha = 0
            } completion: { _ in
                completion()
            }
        }
    }
    
    @objc private func handleDismissViewController() {
        animateDetailSliderDown()
        performBlurAnimationOut {
            self.dismiss(animated: false)
        }
    }
    
    private func animateDetailSliderUp() {
        view.addSubview(detailSlider)
        detailSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detailSlider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        detailSlider.transform = .init(translationX: 0, y: view.frame.height/3)
        UIView.animate(withDuration: self.animationTime) {
            self.detailSlider.transform = .identity
        }
    }
    
    private func animateDetailSliderDown() {
        UIView.animate(withDuration: self.animationTime) {
            self.detailSlider.transform = .init(translationX: 0, y: self.view.frame.height/3)
        }
    }
}
