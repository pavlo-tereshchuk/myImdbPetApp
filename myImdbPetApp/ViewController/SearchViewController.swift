//
//  ViewController.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 28.03.22.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet var mainTable: UITableView!
    var contents = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUITable()
        setUpContents()
    }
    
    func setUpUITable(){
        mainTable.dataSource = self
        mainTable.delegate = self
        mainTable.separatorStyle = .none
        mainTable.showsVerticalScrollIndicator = false
        mainTable.register(StandartMovieCell.getNib(), forCellReuseIdentifier: StandartMovieCell.identifier)
    }
    
    func setUpContents(){
        contents.append(Movie( title: "Seven", year: 1999, genre: "Thriller, Detective"))
        contents.append(Movie( title: "X-men", year: 2002, genre: "Fiction, Super-hero"))
        contents.append(Movie( title: "Fight Club", year: 1999, genre: "Criminal, Detective"))
        contents.append(Movie( title: "Pulp Fiction", year: 1999, genre: "Thriller, Detective"))
        contents.append(Movie( title: "Spider-man", year: 2001, genre: "Fiction, Super-hero"))
        contents.append(Movie( title: "Seven", year: 1999, genre: "Thriller, Detective"))
        contents.append(Movie( title: "X-men", year: 2002, genre: "Fiction, Super-hero"))
        contents.append(Movie( title: "Fight Club", year: 1999, genre: "Criminal, Detective"))
        contents.append(Movie( title: "Pulp Fiction", year: 1999, genre: "Thriller, Detective"))
        contents.append(Movie( title: "Spider-man", year: 2001, genre: "Fiction, Super-hero"))
        contents.append(Movie( title: "Seven", year: 1999, genre: "Thriller, Detective"))
        contents.append(Movie( title: "X-men", year: 2002, genre: "Fiction, Super-hero"))
        contents.append(Movie( title: "Fight Club", year: 1999, genre: "Criminal, Detective"))
        contents.append(Movie( title: "Pulp Fiction", year: 1999, genre: "Thriller, Detective"))
        contents.append(Movie( title: "Spider-man", year: 2001, genre: "Fiction, Super-hero"))
    }
}

extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StandartMovieCell.identifier, for: indexPath) as! (StandartMovieCell)
        cell.configure(Image: "", Title: contents[indexPath.row].title, Year: contents[indexPath.row].year)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieViewController") as! (MovieViewController)
        vc.configure(Movie: contents[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
