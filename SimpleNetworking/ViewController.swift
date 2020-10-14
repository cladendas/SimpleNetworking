//
//  ImageViewController.swift
//  SimpleNetworking
//
//  Created by cladendas on 14.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    @IBAction func getRequest(_ sender: UIButton) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
        
        //response - ответ сервера
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                let response = response
                else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    @IBAction func postRequest(_ sender: UIButton) {
    }
    
}
