//
//  Course.swift
//  SimpleNetworking
//
//  Created by cladendas on 14.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import Foundation

//данная структура создана для JSON, содержащего один объект
//создаётся в соответствии с API, с которым предполагается работа
struct Course: Decodable {
    
    //названия должны быть записаны как в JSON (в этом JSON данные были записаны в snake_case)
    //но для соблюдения в коде camelCase при сериализации можно использовать keyDecodingStrategy()
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
    
    init?(json: [String: Any]) {
        let id = json["id"] as? Int
        let name = json["name"] as? String
        let link = json["link"] as? String
        let imageUrl = json["imageUrl"] as? String
        let numberOfLessons = json["number_of_lessons"] as? Int
        let numberOfTests = json["number_of_tests"] as? Int
        
        self.id = id
        self.name = name
        self.link = link
        self.imageUrl = imageUrl
        self.numberOfLessons = numberOfLessons
        self.numberOfTests = numberOfTests
    }
    
    static func getArray(from jsonArray: Any) -> [Course]?{
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil}
        return jsonArray.compactMap { Course(json: $0) }
    }
}


/*
//Модель для работы с URLSession
struct Course: Decodable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
 */
