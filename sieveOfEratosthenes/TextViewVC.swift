//
//  TextViewVC.swift
//  sieveOfEratosthenes
//
//  Created by Arunjot Singh on 12/3/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit

class TextViewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }


}
