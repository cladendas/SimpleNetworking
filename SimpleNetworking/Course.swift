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
}
