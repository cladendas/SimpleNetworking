//
//  ViewController.swift
//  SimpleNetworking
//
//  Created by cladendas on 13.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
        
    func fetchImage() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.downLoadImage(url: url) { (image) in
            self.activityIndicator.stopAnimating()
            self.image.image = image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        //скроет индикатор, когда он остановится
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
}

