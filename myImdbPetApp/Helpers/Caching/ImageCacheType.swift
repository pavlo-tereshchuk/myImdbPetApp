//
//  ImageCacheType.swift
//  myImdbPetApp
//
//  Created by Pavlo Tereshchuk on 22.04.22.
//

import Foundation
import UIKit
// MARK: - protocol for image caching in memory
protocol ImageCacheType {
    func image(for url: URL) -> UIImage?
    func insertImage(_ image: UIImage?, for url: URL)
    func removeImage(for url: URL)
    func removeAllImages()
    subscript(_ url: URL) -> UIImage? { get set }
}
