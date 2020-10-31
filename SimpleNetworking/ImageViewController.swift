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
    
    private let url = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
        
    func fetchImage() {
        NetworkManager.downLoadImage(url: url) { (image) in
            self.activityIndicator.stopAnimating()
            self.image.image = image
        }
    }
    
    func fetchDataWithAlamofire() {
        AF.request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                self.activityIndicator.stopAnimating()
                self.image.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        //скроет индикатор, когда он остановится
        activityIndicator.hidesWhenStopped = true
    }
}

