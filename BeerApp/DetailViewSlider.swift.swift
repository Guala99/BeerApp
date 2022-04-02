//
//  DetailViewSlider.swift.swift
//  BeerApp
//
//  Created by Andrea Gualandris on 02/04/2022.
//

import UIKit

class DetailViewSlider : UIView {
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "flag"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let beerImageView : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title Label"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let taglineLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Tagline"
        label.textColor = .lightGray
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    var model: BeerModel? {
        didSet{
            titleLabel.text = model!.name
            taglineLabel.text = model!.tagline
            descriptionLabel.text = model!.description
            configureImageViewFromURL(string: model!.image_url)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 41/255, green: 42/255, blue: 47/255, alpha: 1)
        clipsToBounds = true
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        addSubview(flagImageView)
        flagImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        flagImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        addSubview(beerImageView)
        beerImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
        beerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        beerImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        beerImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: beerImageView.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: beerImageView.heightAnchor, multiplier: 0.2).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(taglineLabel)
        taglineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        taglineLabel.heightAnchor.constraint(equalTo: beerImageView.heightAnchor, multiplier: 0.2).isActive = true
        taglineLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10).isActive = true
        taglineLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: beerImageView.heightAnchor, multiplier: 0.5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func configureImageViewFromURL(string: String) {
        if let url = URL(string: string) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard response != nil, data != nil else { return }
                DispatchQueue.main.async {
                    self.beerImageView.image = UIImage(data: data!)
                }
            }.resume()
        }
    }
}

