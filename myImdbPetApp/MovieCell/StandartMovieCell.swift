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
    
    public static let identifier:String = "StandartMovieCell"
    
    public static func getNib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(Image image:String, Title title:String, Year year:String, Poster poster:String){
        titleLable.text = title
        yearLable.text = year
        if let data = try? Data(contentsOf: URL(string:poster)!){
            self.posterImage.image = UIImage(data: data)
        }
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
        containerView.applyShadow(cornerRadius: 8)
        posterImage.contentMode = .scaleAspectFit
        posterImage.layer.cornerRadius = 8
        posterImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
}
