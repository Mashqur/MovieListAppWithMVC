//
//  CustomImageViewHelper.swift
//  MovieListApp
//
//  Created by Mashqur Habib Himel on 10/9/22.
//

import Foundation
import UIKit

fileprivate let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    let activityIndicator = UIActivityIndicatorView()
    
    func loadImageWithUrl(_ url: URL) {
        
        // setup activityIndicator...
        activityIndicator.color = .darkGray
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        image = nil
        activityIndicator.startAnimating()
        
        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        
        loadImage(url: url)
    }
    
    private func loadImage(url: URL) {
        Task { @MainActor in
            do {
                let (imageData,_) = try await URLSession.shared.data(from: url)
                activityIndicator.stopAnimating()
                if let imageToCache = UIImage(data: imageData) {
                    self.image = imageToCache
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                } else {
                    self.image = UIImage(named: "no-image")
                }
                
            } catch {
                activityIndicator.stopAnimating()
                print(error)
            }
        }
    }
}

