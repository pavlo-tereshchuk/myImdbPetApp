//
//  ViewController.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 28.03.22.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    @IBOutlet var mainTable: UITableView!
    private let refreshControl = UIRefreshControl()
    private let searchBar = UISearchBar()
    private let network = BaseNetworkRequest.getInstance()
    var contents = [Movie]()
    var top250Contents = [Movie]()

//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        getTop250Content()
        setUpUITable()
        setSearchTab()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = mainTable.indexPathForSelectedRow {
            mainTable.deselectRow(at: selectedIndexPath, animated: animated)
        }
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
        tableContentsSwitch(search: show)
    }
    
    func tableContentsSwitch(search:Bool){
        if search {
            top250Contents = contents
            contents = [Movie]()
        } else {
            contents = top250Contents
        }
        mainTable.reloadData()
    }
    
//    MARK: - Functionality
    @objc func refreshMoviesList(_ sender: Any){
        getTop250Content()
    }

    @objc func showSearchItem(_ sender:Any){
        showSearch(show: true)
        searchBar.becomeFirstResponder()
    }
    
    func getTop250Content(){
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
            
    func getSearchContent(searchText:String){
        network.fetchMovieSearch(searchLine: searchText, handler: {[weak self] handler in
            if let strongSelf = self{
                switch handler{
                case .success(let data):
                    strongSelf.contents = Array(data.produceMovieArray()[0...5])
                    DispatchQueue.main.async {
                        strongSelf.mainTable.reloadData()
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
        cell.configure(Image: contents[indexPath.row].image, Title: contents[indexPath.row].title, Year: contents[indexPath.row].year + ", " + contents[indexPath.row].crew)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: MovieViewController.identifier) as! (MovieViewController)
        vc.configureOnID(MovieID: contents[indexPath.row].id, backImg: contents[indexPath.row].image)
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
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if (text.count > 5){
            getSearchContent(searchText: searchText)
        } else if (text.count == 0 && contents.count > 0){
            contents.removeAll()
            mainTable.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text.count > 0 {
            getSearchContent(searchText: text)
        }
        searchBar.resignFirstResponder()
    }
}
