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
    private var movie:Movie?
    private var highResPoster:String?
    
    public static let identifier = "MovieViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //figureBackground()
        if let movie = movie {
            titleLable.text = movie.fullTitle
            yearLable.text = String(movie.year)
            obtainHighResPoster(movie: movie)
            frontImage.applyShadow(cornerRadius: 0)
        }
    }
    
    
    func figureBackground(){
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.view.bounds
//        self.view.alpha = 0.45
        self.view.addSubview(blurredEffectView)
    }
    
    func obtainHighResPoster(movie:Movie){
        BaseNetworkRequest.getInstance().fetchPosterForMovieID(id: movie.id, holder: { [weak self] link in
            if let strongSelf = self{
                DispatchQueue.main.async {
                    if let link = link{
                        strongSelf.highResPoster = link
                        strongSelf.loadImage(urlString: strongSelf.highResPoster!)
                    } else {
                        strongSelf.loadImage(urlString: movie.image)
                    }
                }
            }
        })
    }
    
    func configure(Movie movie:Movie){
        self.movie = movie
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadImage(urlString: String) {
        let url = URL(string: urlString)
        let processor = DownsamplingImageProcessor(size: self.view.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 2)
        frontImage.kf.indicatorType = .activity
        frontImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            [weak self] result in
            if let strongSelf = self{
                switch result {
                case .success(let value):
                    strongSelf.view.backgroundColor = UIColor(patternImage: value.image).withAlphaComponent(50)
                case .failure(let error):
                    strongSelf.present(error: error)
                }
            }
        }
    }
    
    
    
    
    
}


