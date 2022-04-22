//
//  Extensions.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 19.04.22.
//


import UIKit
import Foundation
import Kingfisher

extension UIViewController{
    
    func present(error:LocalizedError){
        let dialogMessage = UIAlertController(title: "Error!", message: error.errorDescription, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "Dismiss", style: .destructive))
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func present(message:String){
        let dialogMessage = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "Dismiss", style: .destructive))
        self.present(dialogMessage, animated: true, completion: nil)
    }
}


extension UIView {
    
    func applyShadow (cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 16.0
        self.layer.shadowOpacity = 0.10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize (width: 0, height: 5)
//        self.layer.borderColor = UIColor.black.cgColor
    }
}

extension UIImage {
        // image with rounded corners
        public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
            let maxRadius = min(size.width, size.height) / 2
            let cornerRadius: CGFloat
            if let radius = radius, radius > 0 && radius <= maxRadius {
                cornerRadius = radius
            } else {
                cornerRadius = maxRadius
            }
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            let rect = CGRect(origin: .zero, size: size)
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
            draw(in: rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    
    func decodedImage() -> UIImage {
            guard let cgImage = cgImage else { return self }
            let size = CGSize(width: cgImage.width, height: cgImage.height)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: cgImage.bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
            context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
            guard let decodedImage = context?.makeImage() else { return self }
            return UIImage(cgImage: decodedImage)
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    func matches(_ string: String) -> Bool {
            let range = NSRange(location: 0, length: string.utf16.count)
            return firstMatch(in: string, options: [], range: range) != nil
    }
}




