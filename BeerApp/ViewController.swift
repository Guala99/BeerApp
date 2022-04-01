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
    
    let typeBeerView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let beerCellidentifier = "beerIdentifier"
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: beerCellidentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var beersModel : [BeerModel] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fetchBeers()
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
        
        view.addSubview(typeBeerView)
        typeBeerView.topAnchor.constraint(equalTo: offerView.bottomAnchor, constant: 5).isActive = true
        typeBeerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        typeBeerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        typeBeerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: typeBeerView.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    private func fetchBeers(){
        guard let url = URL(string: "https://api.punkapi.com/v2/beers") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            var beers: [BeerModel]?
            
            do{
                beers = try  JSONDecoder().decode([BeerModel].self, from: data)
            }
            catch{
                print("failed to convert \(error)")
            }
            guard beers != nil else { return }
            self.beersModel = beers!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: beerCellidentifier) as? BeerTableViewCell else { return UITableViewCell()}
        cell.configureCellWith(model: beersModel[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

