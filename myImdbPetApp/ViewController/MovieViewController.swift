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
    @IBOutlet weak var titleImage: UIImageView!
    private var movie:Movie?
    private var highResPoster:String?
    
    public static let identifier = "MovieViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            titleLable.text = movie.title
            yearLable.text = String(movie.year)
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
    
        
    }
    
    func configure(Movie movie:Movie){
        self.movie = movie
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadImage(urlString: String) {
        let url = URL(string: urlString)
        print("#######################################")
        print(urlString)
        let processor = DownsamplingImageProcessor(size: titleImage.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 2)
        titleImage.kf.indicatorType = .activity
        titleImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            [weak self] result in
            switch result {
            case .success(let value):
                print("Jobdone for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                if let strongSelf = self{
                    strongSelf.present(error: error)
                }
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
    
}
