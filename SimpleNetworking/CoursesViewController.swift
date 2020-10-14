//
//  CoursesViewController.swift
//  SimpleNetworking
//
//  Created by cladendas on 14.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import Foundation
import UIKit

class CoursesViewController: UITableViewController {
    
    override func viewDidLoad() {
        fetchData()
    }
    
    func fetchData() {
        
        //здесь один объект
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_course"
        
        //здесь массив объектов
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_courses"
        
        //здесь описание сайта и массив объектов
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_website_description"
        
        //здесь описание сайта и массив объектов, но с пропущенными полям, т.е. не соотвествует модели
        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_missing_or_wrong_fields"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                //JSONDecoder позволяет декодировать данные и разложить их по модели
                //decode() декодирует в конкретный тип, который нужен
//                let course = try JSONDecoder().decode(Course.self, from: data)
//                let courses = try JSONDecoder().decode([Course].self, from: data)
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                
                print("\(websiteDescription.websiteName ?? "") \(websiteDescription.websiteDescription ?? "")")
                print(websiteDescription.courses)
            } catch let error {
                print("Error serialization json", error)
            }
            
        }.resume()
    }
}

//extension CoursesViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//    
//    
//}
