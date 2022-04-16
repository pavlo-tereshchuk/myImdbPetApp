//
//  ViewController.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 28.03.22.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet var mainTable: UITableView!
    let network = BaseNetworkRequest.getInstance()
    var contents = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getContent()
        setUpUITable()
    }
    
    func setUpUITable(){
        mainTable.dataSource = self
        mainTable.delegate = self
        mainTable.separatorStyle = .none
        mainTable.showsVerticalScrollIndicator = false
        mainTable.register(StandartMovieCell.getNib(), forCellReuseIdentifier: StandartMovieCell.identifier)
    }
    
    func getContent(){
        network.fetchMostPopularMovies(handler: {[weak self] handler in
            if let strongSelf = self{
                switch handler{
                    case .success(let data):
                    strongSelf.contents = data.items
                    DispatchQueue.main.async {
                        strongSelf.mainTable.reloadData()
                    }
                    case .error(let error):
                    strongSelf.present(error: error)
                }
            }
        })
    }
            
    
    
}

extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StandartMovieCell.identifier, for: indexPath) as! (StandartMovieCell)
        cell.configure(Image: "", Title: contents[indexPath.row].fullTitle, Year: contents[indexPath.row].year)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: MovieViewController.identifier) as! (MovieViewController)
        vc.configure(Movie: contents[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension UIViewController{
    
    func present(error:LocalizedError){
        let dialogMessage = UIAlertController(title: "Error!", message: error.errorDescription, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "Dismiss", style: .destructive))
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
