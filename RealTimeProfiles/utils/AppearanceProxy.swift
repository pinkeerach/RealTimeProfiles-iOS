//
//  AppearanceProxy.swift
//  RealTimeProfiles
//
//  Created by Rachel Parsons on 8/29/18.
//  Copyright © 2018 Rachel Parsons. All rights reserved.
//

import Foundation
import UIKit

class AppearanceProxy {
    
    static func applyStyles() {
        UIButton.appearance(whenContainedInInstancesOf: [UIStackView.self]).backgroundColor = Constants.DARK_BLUE_COLOR
        UIButton.appearance(whenContainedInInstancesOf: [UIStackView.self]).tintColor = UIColor.white
        
        UIButton.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).backgroundColor = UIColor.clear
        UIButton.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = Constants.DARK_BLUE_COLOR
    }
}
