//
//  BeerTableViewCell.swift.swift
//  BeerApp
//
//  Created by Andrea Gualandris on 01/04/2022.
//

import UIKit

protocol BeerTableViewCellDelegate: AnyObject {
    func moreInfoTapped(with model: BeerModel)
}

class BeerTableViewCell: UITableViewCell {
    
    // MARK: - Instantiation of variables
    
    let beerImageView : UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let taglineLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("MORE INFO", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(handleMoreTapped), for: .touchUpInside)
        return button
    }()
    
    var model: BeerModel?
    
    weak var delegate: BeerTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting up the ui using AutoLayout
    
    private func setUpUI() {
        backgroundColor = .clear
        
        contentView.addSubview(beerImageView)
        beerImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
        beerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        beerImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        beerImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.35).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: beerImageView.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: beerImageView.heightAnchor, multiplier: 0.2).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        contentView.addSubview(taglineLabel)
        taglineLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        taglineLabel.heightAnchor.constraint(equalTo: beerImageView.heightAnchor, multiplier: 0.2).isActive = true
        taglineLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10).isActive = true
        taglineLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: beerImageView.heightAnchor, multiplier: 0.5).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        contentView.addSubview(moreButton)
        moreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        moreButton.heightAnchor.constraint(equalTo: beerImageView.heightAnchor, multiplier: 0.1).isActive = true
        moreButton.leadingAnchor.constraint(equalTo: beerImageView.trailingAnchor, constant: 10).isActive = true
        
    }
    
    //MARK: - Configuration of cell
    
    func configureCellWith(model: BeerModel) {
        self.model = model
        titleLabel.text = model.name
        taglineLabel.text = model.tagline
        descriptionLabel.text = model.description
        configureImageViewFromURL(string: model.image_url)
    }
    
    @objc private func handleMoreTapped() {
        guard model != nil else { return }
        self.delegate?.moreInfoTapped(with: model!)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        beerImageView.image = nil
        titleLabel.text = nil
        taglineLabel.text = nil
        descriptionLabel.text = nil
    }
    
    /* Images are loaded asynchronously so if the cell is reused before the image is downloaded from the server it could end up with a wrong image -> to solve this problem I check that the response url that comes asynchronously is the same one of the model of the cell. */
    func configureImageViewFromURL(string: String) {
        guard model != nil else { return }
        if let url = URL(string: string) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard response != nil, data != nil else { return }
                DispatchQueue.main.async {
                    if self.model!.image_url == response!.url!.absoluteString {
                        self.beerImageView.image = UIImage(data: data!)
                    }
                }
            }.resume()
        }
    }
}
