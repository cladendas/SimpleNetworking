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
    
    static func fetchData(url: String, complition: @escaping (_ courses: [Course]) -> ()) {
                
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                //keyDecodingStrategy() позволяет писать в коде в стиле camelCase, хотя в JSON поля написаны в snake_case
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //JSONDecoder позволяет декодировать данные и разложить их по модели
                //decode() декодирует в конкретный тип, который нужен
                let courses = try decoder.decode([Course].self, from: data)
                
                complition(courses)

            } catch let error {
                print("Error serialization json", error)
            }
            
        }.resume()
    }
    
    static func uploadImage(url: String) {
        
        let image = UIImage(named: "desertEagle")!
        
        //параметры в виде словаря для авторизации на сервере
        let httpHeaders = ["Authorization" : "Client-ID 34948ce5c28f481"]
        
        guard let imageProperties = ImageProperties(withImage: image, forKey: "image") else { return }
        
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //передаём словарь в качестве параметров заголовок запроса
        request.allHTTPHeaderFields = httpHeaders
        //передаём данные для отправки на сервер
        request.httpBody = imageProperties.data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}
