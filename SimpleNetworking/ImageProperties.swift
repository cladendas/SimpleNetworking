//
//  ImageProperties.swift
//  SimpleNetworking
//
//  Created by cladendas on 19.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import UIKit

struct ImageProperties {
    
    let key: String
    let data: Data
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        //pngData() конвертирует изображение из png в Data
        guard let data = image.pngData() else { return nil }
        self.data = data
    }
}
