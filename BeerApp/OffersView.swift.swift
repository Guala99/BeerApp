//
//  OffersView.swift.swift
//  BeerApp
//
//  Created by Andrea Gualandris on 01/04/2022.
//

import UIKit

class OffersView : UIView {
    
    let titleOfferLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Weekend Offers"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let descriptionOfferLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Free Shipping on orders over 60€"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let presentImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "present"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpUI() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 241/255, green: 177/255, blue: 78/255, alpha: 1)
        layer.cornerRadius = 20
        
        
        addSubview(titleOfferLabel)
        titleOfferLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        titleOfferLabel.bottomAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleOfferLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        titleOfferLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        
        addSubview(descriptionOfferLabel)
        descriptionOfferLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        descriptionOfferLabel.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
        descriptionOfferLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        descriptionOfferLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        
        addSubview(presentImage)
        presentImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        presentImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
        presentImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9).isActive = true
    }
}
