//
//  AlamofireNetworkRequest.swift
//  SimpleNetworking
//
//  Created by cladendas on 29.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import Foundation
import Alamofire

///Отвечает за все сетевые запросы с использованием Alamofire
class AlamofireNetworkRequest {
    
    static func sendRequest(url: String, complition: @escaping (_ courses: [Course]) -> ()) {
        guard let url = URL(string: url) else { return }

        //request - принмает адрес, по которому следует послать запрос
        //responseJSON - говорит, что ответ от серсвера нужен в формате JSON
        //response - ответ от сервера
        //если не указан тип запроса, то выполняется GET-запрос
        
        /*
        AF.request(url).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else { return }
            print("statusCode:", statusCode)

            //если statusCode в предела 200-300, то выводим полученное от сервера значение response.value
            if (200 ..< 300).contains(statusCode) {
                let value = response.value
                print("value: ", value ?? "nil")
            } else {
                let error = response.error
                print(error ?? "error")
            }
        }
        */
        
        AF.request(url).validate().responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    
                    var courses = [Course]()
                    courses = Course.getArray(from: value)!
                    complition(courses)
                
                case .failure(let error):
                    print(error)
            }
        }
    }
}
