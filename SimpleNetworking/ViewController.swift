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
    
    //считываем данные с сервера
    @IBAction func getRequest(_ sender: UIButton) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
        
        //response - ответ сервера
        session.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                let response = response
            else { return }
            
            print(response)
            
            //обработка ответа от сервера
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    //передаём данные на сервер
    @IBAction func postRequest(_ sender: UIButton) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        //передаваемые данные на сервер
        let userData = ["Course": "Networking,", "Lesson": "GET and POST requests"]
        
        var request = URLRequest(url: url)
        //указываем тип запроса
        request.httpMethod = "POST"
        //правило добавления новой записи
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //сериализуем в JSON
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        
        //помещение данных в тело запроса
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            guard
                let data = data,
                let response = response
            else { return }
            
            print(response)

            //обработка ответа от сервера
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
}
