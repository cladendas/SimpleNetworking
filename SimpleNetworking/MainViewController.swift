//
//  MainViewController.swift
//  SimpleNetworking
//
//  Created by cladendas on 17.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MainViewController: UICollectionViewController {
    
    let actions = ["Dowload Image", "GET", "POST", "Our Courses", "Upload Image"]

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        cell.label.text = actions[indexPath.row]
    
        return cell
    }
}
