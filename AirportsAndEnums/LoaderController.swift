//
//  LoaderController.swift
//  AirportsAndEnums
//
//  Created by Flatiron School on 7/10/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LoaderController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.startAnimating()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            
            self.activityIndicatorView.stopAnimating()
            self.performSegue(withIdentifier: "statusSegue", sender: self)
            
        })
        
    }

}
