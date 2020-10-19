//
//  NetworkManager.swift
//  SimpleNetworking
//
//  Created by cladendas on 19.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static func getRequest(url: String) {
        guard let url = URL(string: url) else { return }
        
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
    
    static func postRequest(url: String) {
        
        guard let url = URL(string: url) else { return }
        
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
    
    
    //с помощью замыкания захватываем изображение
    static func downLoadImage(url: String, complition: @escaping (_ image: UIImage) -> ()) {
        
        //"https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
        guard let url = URL(string: url) else { return }
        
        //создание общей сессии
        let session = URLSession.shared
        
        //извлечение данных по указанному url
        //происходит ассинхронно в фоновом потоке
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    complition(image)
                }
            }
        }.resume()
    }
}
