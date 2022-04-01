//
//  BeerTableViewCell.swift.swift
//  BeerApp
//
//  Created by Andrea Gualandris on 01/04/2022.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
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
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("MORE INFO", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(handleMoreTapped), for: .touchUpInside)
        return button
    }()
    
    var model: BeerModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        backgroundColor = .clear
        
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
        
        addSubview(moreButton)
        moreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        moreButton.heightAnchor.constraint(equalTo: beerImageView.heightAnchor, multiplier: 0.1).isActive = true
        moreButton.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10).isActive = true
        
    }
    
    func configureCellWith(model: BeerModel) {
        beerImageView.setUpImageView(with: model.image_url)
        titleLabel.text = model.name
        taglineLabel.text = model.tagline
        descriptionLabel.text = model.description
    }
    
    @objc private func handleMoreTapped() {
        print(model)
    }
}

extension UIImageView {
    
    func setUpImageView(with stringUrl: String) {
        if let url = URL(string: stringUrl) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
}
