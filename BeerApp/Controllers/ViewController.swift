//
//  ViewController.swift
//  BeerApp
//
//  Created by Andrea Gualandris on 01/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let beerCellidentifier = "beerIdentifier"
    
    let rootURL = "https://api.punkapi.com/v2/beers"
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Beer Box"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    lazy var searchBar : UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.delegate = self
        search.placeholder = "Search"
        search.barTintColor = .clear
        search.searchTextField.textColor = .white
        return search
    }()
    
    let offerView = OffersView()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: beerCellidentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let loadingIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        return indicator
    }()
    
    var isFetching = false
    var isSearchMode = false
    var page: Int?
    var beersModel : [BeerModel] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        fetchBeers(page: 1, initialLoad: true)
    }
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
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
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: offerView.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.addSubview(loadingIndicator)
        loadingIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        
    }
    
    private func fetchBeers(page: Int, initialLoad: Bool){
        guard let url = URL(string: "\(rootURL)?page=\(page)") else { return }
        
        self.page = page
        
        if initialLoad {
            resetTableViewData()
        }
        fetchBeersUsing(url)
    }
    
    private func fetchBeersUsing(_ url: URL) {
        self.loadingIndicator.startAnimating()
        isFetching = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            var beers: [BeerModel]?
            self.isFetching = false
            
            do{
                beers = try  JSONDecoder().decode([BeerModel].self, from: data)
            }
            catch{
                print("failed to convert \(error)")
            }
            guard beers != nil else { return }
            self.beersModel.append(contentsOf: beers!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loadingIndicator.stopAnimating()
            }
        }.resume()
    }
    
    private func resetTableViewData() {
        beersModel.removeAll()
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: beerCellidentifier) as? BeerTableViewCell else { return UITableViewCell()}
        cell.configureCellWith(model: beersModel[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - Fetch more beers when bottom of tableView content is reached
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            if isFetching == false && isSearchMode == false {
                guard page != nil else { return }
                fetchBeers(page: page!+1, initialLoad: false)
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchForBeer(with: searchBar.text)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            isSearchMode = false
            fetchBeers(page: 1, initialLoad: true)
        }
    }
    
    private func searchForBeer(with name: String?) {
        guard name != nil else { return }
        guard let url = URL(string: "\(rootURL)?beer_name=\(name!)") else { return }
        isSearchMode = true
        resetTableViewData()
        
        fetchBeersUsing(url)
    }
}

extension ViewController: BeerTableViewCellDelegate {
    func moreInfoTapped(with model: BeerModel) {
        let detailVC = DetailBeerViewController()
        detailVC.modalPresentationStyle = .overFullScreen
        detailVC.detailSlider.model = model
        self.present(detailVC, animated: false, completion: nil)
    }
}
