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
        print("POSTER")
        BaseNetworkRequest.getInstance().fetchPosterForMovieID(id: movie.id, holder: { [weak self] link in
            if let strongSelf = self{
                print("STRONGSELF")
                    if let link = link{
                        print("LINK: \(link)")
                        DispatchQueue.main.async {
                            strongSelf.highResPoster = link
                            strongSelf.loadImage(urlString: strongSelf.highResPoster!, image: strongSelf.frontImage, cornerRadius: 5)
                        }
                    } else {
                        print("LINK: \(movie.image)")
                        DispatchQueue.main.async {
                            strongSelf.loadImage(urlString: movie.image, image: strongSelf.frontImage, cornerRadius: 5)
                        }
                    }
                }
        })
    }
    
    
//    MARK: - Methods
    func configure(Movie movie:Movie){
        self.movie = movie
    }
 
    func loadImage(urlString: String, image: UIImageView, cornerRadius: CGFloat) {
        let url = URL(string: urlString)
        let processor = DownsamplingImageProcessor(size: image.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: cornerRadius)
        image.kf.indicatorType = .activity
        image.kf.setImage(
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
                    print("Job done!")
                case .failure(let error):
                    strongSelf.present(error: error)
                }
            }
        }
    }
    
    
    
    
}


