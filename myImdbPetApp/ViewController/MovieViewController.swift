//
//  MovieViewController.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 01.04.22.
//

import UIKit
import Kingfisher


class MovieViewController : UIViewController{
    
    @IBOutlet weak var titleLable:UILabel!
    @IBOutlet weak var yearLable:UILabel!
    @IBOutlet weak var frontImage: UIImageView!
    private let imageLoader = ImageLoader()
    private var movie:Movie?
    private var highResPoster:String?
    
    public static let identifier = "MovieViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            titleLable.text = movie.fullTitle
            yearLable.text = String(movie.year)
            setBackground(movie)
            obtainHighResPoster(movie: movie)
            frontImage.applyShadow(cornerRadius: 0)
        }
    }
    
    
    func setBackground(_ movie:Movie){
        if let data = try? Data(contentsOf: URL(string:movie.image)!){
            self.view.backgroundColor = UIColor(patternImage: UIImage(data: data)!).withAlphaComponent(50)
        }
    }

    
    func obtainHighResPoster(movie:Movie){
        BaseNetworkRequest.getInstance().fetchPosterForMovieID(id: movie.id, holder: { [weak self] link in
            if let strongSelf = self{
                if let link = link, link.count > 0{
                        DispatchQueue.main.async {
                            strongSelf.highResPoster = link
                            strongSelf.imageLoader.loadImageAlt(urlString: strongSelf.highResPoster!,
                                                                image: strongSelf.frontImage, cornerRadius: 5)
//                            strongSelf.imageLoader.loadImage(link: strongSelf.highResPoster!, image: strongSelf.frontImage,
//                                                             radius: 20, vc: strongSelf)
                        }
                    } else {
                        DispatchQueue.main.async {
                            strongSelf.imageLoader.loadImageAlt(urlString: movie.image,
                                                                image: strongSelf.frontImage, cornerRadius: 5)
                    }
                }
            }
        })
    }
    
    
//    MARK: - Methods
    func configure(Movie movie:Movie){
        self.movie = movie
    }
    
}


