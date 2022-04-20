//
//  ViewController.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 28.03.22.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet var mainTable: UITableView!
    private let refreshControl = UIRefreshControl()
    private let searchBar = UISearchBar()
    private let network = BaseNetworkRequest.getInstance()
    var contents = [Movie]()

//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getContent()
        setUpUITable()
        setSearchTab()
    }
    
//    MARK: - UI
    func setUpUITable(){
        mainTable.dataSource = self
        mainTable.delegate = self
        mainTable.separatorStyle = .none
        mainTable.showsVerticalScrollIndicator = false
        mainTable.register(StandartMovieCell.getNib(), forCellReuseIdentifier: StandartMovieCell.identifier)
        
        if #available(iOS 10.0, *) {
            mainTable.refreshControl = refreshControl
        } else {
            mainTable.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshMoviesList(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Updating")
    }
    
    func setSearchTab(){
        searchBar.delegate = self
        searchBar.sizeToFit()
        navigationItem.rightBarButtonItem?.tintColor = .black
        showSearch(show: false)
    }
    
    func showSearch(show:Bool){
        navigationItem.rightBarButtonItem = show ? nil : UIBarButtonItem(barButtonSystemItem: .search,
                                                                         target: self,
                                                                         action: #selector(showSearchItem(_:)))
        navigationItem.titleView = show ? searchBar : nil
        searchBar.showsCancelButton = show
    }
    
    
//    MARK: - Functionality
    @objc func refreshMoviesList(_ sender: Any){
        getContent()
    }
    
    @objc func handleTap(_ sender: Any){
        searchBar.resignFirstResponder()
    }
    
    @objc func showSearchItem(_ sender:Any){
        showSearch(show: true)
        searchBar.becomeFirstResponder()
    }
    
    func getContent(){
        network.fetchMostPopularMovies(handler: {[weak self] handler in
            if let strongSelf = self{
                switch handler{
                    case .success(let data):
                    if(data.items.count == 0){
                        DispatchQueue.main.async {
                            strongSelf.present(message: data.errorMessage)
                        }
                        return
                    }
                    strongSelf.contents = data.items
                    DispatchQueue.main.async {
                        strongSelf.mainTable.reloadData()
                        strongSelf.refreshControl.endRefreshing()
                    }
                    case .error(let error):
                    DispatchQueue.main.async {
                        strongSelf.present(error: error)
                    }
                }
            }
        })
    }
            
    
    
}


//MARK: - Extension for UITable item
extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StandartMovieCell.identifier, for: indexPath) as! (StandartMovieCell)
        cell.configure(Image: "", Title: contents[indexPath.row].title, Year: contents[indexPath.row].year + ", " + contents[indexPath.row].crew, Poster: contents[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: MovieViewController.identifier) as! (MovieViewController)
        vc.configure(Movie: contents[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

//MARK: - Extension for UISearchDelegate
extension SearchViewController:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showSearch(show: false)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text{
            network.fetchMovieSearch(searchLine: searchText, handler: {[weak self] handler in
                if let strongSelf = self{
                    switch handler{
                    case .success(let data):
                        print(data)
                    case .error(let error):
                        print(error)
                    }
                }
            })
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
