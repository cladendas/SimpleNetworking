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
    
    var courses = [Course]()
    
    override func viewDidLoad() {
        fetchData()
    }
    
    func fetchData() {
        
        //здесь один объект
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_course"
        
        //здесь массив объектов
        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_courses"
        
        //здесь описание сайта и массив объектов
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_website_description"
        
        //здесь описание сайта и массив объектов, но с пропущенными полям, т.е. не соотвествует модели
//        let jsonUrlString = "https://swiftbook.ru/wp-content/uploads/api/api_missing_or_wrong_fields"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                //JSONDecoder позволяет декодировать данные и разложить их по модели
                //decode() декодирует в конкретный тип, который нужен
//                let course = try JSONDecoder().decode(Course.self, from: data)
                self.courses = try JSONDecoder().decode([Course].self, from: data)
//                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                
//                print("\(websiteDescription.websiteName ?? "") \(websiteDescription.websiteDescription ?? "")")
//                print(websiteDescription.courses)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("Error serialization json", error)
            }
            
        }.resume()
    }
    
    private func configureCell(cell: TableViewCell, for indexPath: IndexPath) {
        let course = courses[indexPath.row]
        cell.courseNameLabel.text = course.name
        
        if let numberOfLessons = course.number_of_lessons {
            cell.numberOfLessons.text = "Number of lessons: \(numberOfLessons)"
        }
        
        if let numberOfTests = course.number_of_tests {
            cell.numberOfTests.text = "Number of tests: \(numberOfTests)"
        }
        
        //работа с данными получаемыми из сети должна происходить в глобальном потоке
        DispatchQueue.global().async {
            //проверка валидности адреса для изображения
            guard let imageUrl = URL(string: course.imageUrl!) else { return }
            //проверка наличия данных по указанному адресу
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            //обновление интерфейса должно происходить ассинхронно в основном потоке
            DispatchQueue.main.async {
                cell.courseImage.image = UIImage(data: imageData)
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        configureCell(cell: cell, for: indexPath)
        
        return cell
        
    }
    
    //высота ячейки
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
