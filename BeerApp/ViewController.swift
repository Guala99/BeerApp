//
//  ViewController.swift
//  BeerApp
//
//  Created by Andrea Gualandris on 01/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Beer Box"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    let searchBar : UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = "Search"
        search.barTintColor = .clear
        return search
    }()
    
    let offerView = OffersView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    fileprivate func setUpUI() {
        
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(offerView)
        offerView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        offerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        offerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        offerView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    
    }

}

