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
        if let backgroundImg = backgroundImg{
            setupNavBar()
            setBackground(backgroundImg)
        }
        
        let addButton = rightBarButtonItem(iconNameButton: "plus", selector: #selector(addNavDidTap(sender:)))
        let otherButton = rightBarButtonItem(iconNameButton: "ellipsis.circle", selector: #selector(otherNavDidTap(sender:)))

        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.rightBarButtonItems = [otherButton, addButton]
        
        
    }
    
    
    func rightBarButtonItem(iconNameButton: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        button.setImage(UIImage(systemName: iconNameButton), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit

        let buttonBarButton = UIBarButtonItem(customView: UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25)))
        buttonBarButton.customView?.addSubview(button)
        buttonBarButton.customView?.frame = button.frame

        return buttonBarButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let movieID = movieID {
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
    
    
    func fetchMovieInfo(ID:String){
        BaseNetworkRequest.getInstance().fetchMovieOnID(ID: ID, handler:{
            [weak self] result in
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
    
    
    @objc func addNavDidTap(sender:Any){
        if let addButton = (sender as? UIButton) {
            addButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
    }
    
    @objc func otherNavDidTap(sender:Any){
        
    }

    
    
}


