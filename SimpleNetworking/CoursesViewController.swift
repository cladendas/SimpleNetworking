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
    
    private var courses = [Course]()
    private var courseName: String?
    private var courseURL:String?
    private let url = "https://swiftbook.ru/wp-content/uploads/api/api_courses"
    
    
    override func viewDidLoad() {
        fetchData()
    }
    
    func fetchData() {
        
        NetworkManager.fetchData(url: url) { (courses) in
            self.courses = courses
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureCell(cell: TableViewCell, for indexPath: IndexPath) {
        let course = courses[indexPath.row]
        cell.courseNameLabel.text = course.name
        
        if let numberOfLessons = course.numberOfLessons {
            cell.numberOfLessons.text = "Number of lessons: \(numberOfLessons)"
        }
        
        if let numberOfTests = course.numberOfTests {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        
        courseURL = course.link
        courseName = course.name
        
//        performSegue(withIdentifier: "Description", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewController = segue.destination as! WebViewController
        
        webViewController.selectedCourse = courseName
        
        if let url = courseURL {
            webViewController.courseURL = url
        }
    }
}
