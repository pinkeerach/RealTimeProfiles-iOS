//
//  ViewController.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/15/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import UIKit

class ProfilesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ProfilesViewController : UICollectionViewDelegate {
    
}

extension ProfilesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath)
        
        return cell
    }
    
    
}
