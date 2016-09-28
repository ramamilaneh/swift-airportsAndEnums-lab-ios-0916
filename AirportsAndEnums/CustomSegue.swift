//
//  CustomSegue.swift
//  AirportsAndEnums
//
//  Created by Flatiron School on 7/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionFade
        
        self.source.view.window?.layer.add(transition, forKey: kCATransitionFade)
        self.source.present(self.destination, animated: false, completion: nil)
        
    }
}
