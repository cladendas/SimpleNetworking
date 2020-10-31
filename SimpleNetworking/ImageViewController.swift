//
//  ViewController.swift
//  SimpleNetworking
//
//  Created by cladendas on 13.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import UIKit
import Alamofire

class ImageViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var completedLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    private let largeImageUrl = "https://i.imgur.com/3416rvI.jpg"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        //скроет индикатор, когда он остановится
        activityIndicator.hidesWhenStopped = true
        completedLabel.isHidden = true
        progressView.isHidden = true
    }
    
    func fetchImage() {
        NetworkManager.downLoadImage(url: url) { (image) in
            self.activityIndicator.stopAnimating()
            self.image.image = image
        }
    }
    
    func fetchDataWithAlamofire() {
        AlamofireNetworkRequest.downloadImage(url: url) { (image) in
            self.activityIndicator.stopAnimating()
            self.image.image = image
        }
    }
    
    func downloadImageWithProgress() {
        
        AlamofireNetworkRequest.onProgress = { progress in
            self.progressView.isHidden = false
            self.progressView.progress = Float(progress)
        }
        
        AlamofireNetworkRequest.completed = { completed in
            self.completedLabel.isHidden = false
            self.completedLabel.text = completed
        }
        
        AlamofireNetworkRequest.downloadImageWithProgress(url: largeImageUrl) { (image) in
            self.activityIndicator.stopAnimating()
            self.completedLabel.isHidden = true
            self.progressView.isHidden = true
            self.image.image = image
        }
    }
}

