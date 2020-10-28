//
//  AppDelegate.swift
//  SimpleNetworking
//
//  Created by cladendas on 13.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var bgSessionComplitionHandler: (() -> ())?
    
    
    //completionHandler - сюда будет передаваться сообщение с идентификатором сессии, вызывающего запуск приложения
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        
        bgSessionComplitionHandler = completionHandler
    }

}

