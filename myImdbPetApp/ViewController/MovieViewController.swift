//
//  MovieViewController.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 01.04.22.
//

import UIKit


class MovieViewController : UIViewController{
    
    @IBOutlet weak var titleLable:UILabel!
    @IBOutlet weak var yearLable:UILabel!
    private var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            titleLable.text = movie.title
            yearLable.text = String(movie.year)
        }
    }
    
    func configure(Movie movie:Movie){
        self.movie = movie
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
