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
        
        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_course"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                //JSONDecoder позволяет декодировать данные и разложить их по модели
                //decode() декодирует в конкретный тип, который нужен
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course.name)
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
