//
//  WebsiteDescription.swift
//  SimpleNetworking
//
//  Created by cladendas on 14.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import Foundation

//данная структура создана для JSON представленного некоторым описанием и массивом объектов
//если поля могут отсутствовать, то их можно сделать опцилнальными
struct WebsiteDescription: Decodable {
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
