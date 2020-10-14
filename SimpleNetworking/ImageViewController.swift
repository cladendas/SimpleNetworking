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
        
    func fetchImage() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let url = URL(string: "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg") else { return }
        
        //создание общей сессии
        let session = URLSession.shared
        
        //извлечение данных по указанному url
        //происходит ассинхронно в фоновом потоке
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.image.image = image
                }
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        //скроет индикатор, когда он остановится
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
}

