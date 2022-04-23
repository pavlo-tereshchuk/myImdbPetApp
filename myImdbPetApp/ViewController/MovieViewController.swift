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
    @IBOutlet weak var genreLable:UILabel!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var imdbButton: UIButton!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    private let imageLoader = ImageLoader()
    private var advancedMovie:MovieAdvanced?
    private var backgroundImg:String?
    private var movieID:String?
    
    public static let identifier = "MovieViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let backgroundImg = backgroundImg, let movieID = movieID {
            setupNavBar()
            setBackground(backgroundImg)
            self.fetchMovieInfo(ID: movieID)
        }
    }
    
    
    func setContent(movie:MovieAdvanced){
        imageLoader.loadImageAlt(urlString: movie.image, image: frontImage, cornerRadius: 5)
        titleLable.text = movie.fullTitle
        genreLable.text = "\(movie.genres) \n IMDB: \(movie.imDBRating)/10"
        actorsLabel.text = "Director: \(movie.directors), Writer: \(movie.writers), Actors: \(movie.stars)"
        plotLabel.text = movie.plot
    }
    
    override func viewDidLayoutSubviews() {
//        frontImage.applyShadow(cornerRadius: 0)
//        Utilities.blurryButton(button: youtubeButton)
//        Utilities.blurryButton(button: imdbButton)
        youtubeButton.layer.cornerRadius = 10
        youtubeButton.layer.cornerCurve = .continuous
        imdbButton.layer.cornerRadius = 10
    }
    
    
    func setBackground(_ image:String){
        if let data = try? Data(contentsOf: URL(string:image)!){
            self.view.backgroundColor = UIColor(patternImage: UIImage(data: data)!
                                        .resized(to: CGSize(width: 414, height: 725)))
                                                            .withAlphaComponent(20)
                                                            
        }
    }

    
//    MARK: - Methods

    func configureOnID(MovieID: String, backImg:String){
        self.backgroundImg = backImg
        self.movieID = MovieID
    }
    
//    func obtainHighResPoster(movie:Movie){
//        BaseNetworkRequest.getInstance().fetchPosterForMovieID(id: movie.id, holder: { [weak self] link in
//            if let strongSelf = self{
//                if let link = link, link.count > 0{
//                        DispatchQueue.main.async {
//                            strongSelf.highResPoster = link
//                            strongSelf.imageLoader.loadImageAlt(urlString: strongSelf.highResPoster!,
//                                                                image: strongSelf.frontImage, cornerRadius: 5)
////                            strongSelf.imageLoader.loadImage(link: strongSelf.highResPoster!, image: strongSelf.frontImage,
////                                                             radius: 20, vc: strongSelf)
//                        }
//                    } else {
//                        DispatchQueue.main.async {
//                            strongSelf.imageLoader.loadImageAlt(urlString: movie.image,
//                                                                image: strongSelf.frontImage, cornerRadius: 5)
//                    }
//                }
//            }
//        })
//    }
    
    func fetchMovieInfo(ID:String){
        BaseNetworkRequest.getInstance().fetchMovieOnID(ID: ID, handler:{
            [weak self] result in
            print("YES")
            if let strongSelf = self{
                switch result{
                case .success(let data):
                    DispatchQueue.main.async{
                        strongSelf.advancedMovie = data
                        strongSelf.setContent(movie: strongSelf.advancedMovie!)
                    }
                case .error(let error):
                    strongSelf.present(error: error)
                }
            }
        })
    }
    
    
    
}


