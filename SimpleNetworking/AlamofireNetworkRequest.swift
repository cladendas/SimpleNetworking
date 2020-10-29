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
    
    static func sendRequest(url: String) {
        guard let url = URL(string: url) else { return }

        //request - принмает адрес, по которому следует послать запрос
        //responseJSON - говорит, что ответ от серсвера нужен в формате JSON
        //response - ответ от сервера
        //если не указан тип запроса, то выполняется GET-запрос
        AF.request(url).responseJSON { (response) in
            print(response)
        }
    }
}
