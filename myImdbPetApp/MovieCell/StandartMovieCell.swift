//
//  MovieCell.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 28.03.22.
//

import UIKit

class StandartMovieCell: BaseTableViewCell {
    
//    @IBOutlet weak var titleImage:UIImageView?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLable:UILabel!
    @IBOutlet weak var yearLable:UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    
    static let identifier:String = "StandartMovieCell"
    private let imageLoader = ImageLoader()
    
    
    static func getNib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(Image image:String, Title title:String, Year year:String, Poster poster:String){
        titleLable.text = title
        yearLable.text = year
        self.imageLoader.loadImageAlt(urlString: poster, image: self.posterImage, cornerRadius: 4)
//        self.imageLoader.loadImage(link: poster, image: self.posterImage, radius: 10)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: 8.0
        ).cgPath
        containerView.layer.borderWidth = 0.5
        containerView.applyShadow(cornerRadius: 8)
        posterImage.contentMode = .scaleAspectFit
    }
    
}
