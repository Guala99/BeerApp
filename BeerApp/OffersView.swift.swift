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
        label.text = "Weekend Offers"
        return label
    }()
    
    let descriptionOfferLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Free Shipping on orders over 60€"
        return label
    }()
    
    let packageImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "present"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
