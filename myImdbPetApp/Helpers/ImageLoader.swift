//
//  ImageLoader.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 22.04.22.
//

import Foundation
import UIKit
import Kingfisher


final class ImageLoader{
    
    private static let cache = ImageCache()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    
    // MARK: - Image Loading
    func loadImage(link:String, image: UIImageView, radius: CGFloat? = nil, vc:UIViewController? = nil){
        let url = URL(string: link)!
        if let cachedImage = ImageLoader.cache[url]{
            image.image = cachedImage
        } else {
            loadImageFromNetwork(url: url, completion: { result in
                switch result{
                case .success(let downloadedImage):
                    image.image = downloadedImage?.withRoundedCorners(radius: radius)
                    ImageLoader.cache[url] = downloadedImage
                case .error(let error):
                    if let vc = vc{
                        vc.present(error: error)
                    } else {
                        print(error.localizedDescription)
                    }
                }
            })
        }
    }
    
    func loadImageAlt(urlString: String, image: UIImageView, cornerRadius: CGFloat? = nil) {
        let url = URL(string: urlString)
        let processor = DownsamplingImageProcessor(size: image.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: cornerRadius ?? 0)
        image.kf.indicatorType = .activity
        image.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    
    private func loadImageFromNetwork(url:URL, completion: @escaping (Result<UIImage?>) -> ()) {
        utilityQueue.async {
            guard let data = try? Data(contentsOf: url) else {
                completion(Result.error(RequestException.dataNotFound(error: "Data was not found")))
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(Result.success(image))
            }
        }
    }
}
