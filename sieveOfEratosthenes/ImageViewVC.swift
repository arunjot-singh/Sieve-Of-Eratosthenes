//
//  ImageViewVC.swift
//  sieveOfEratosthenes
//
//  Created by Arunjot Singh on 12/3/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit

class ImageViewVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageLoop = 0
    var timer = Timer()
    let delayInSeconds = 1.5

    @IBOutlet var done: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        done.layer.cornerRadius = 15
        imageView.image = UIImage(named: "output/tmp-0.png")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            
            self.timer = Timer.scheduledTimer(timeInterval: 0.3, target:self, selector: #selector(self.animateImage), userInfo: nil, repeats: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    
    // -- for creating the animation gif of images -- //
    func animateImage () {
        
        if imageLoop < 158 {
            imageLoop += 1
        } else {
            imageLoop = 0
        }
        
        self.imageView.image = UIImage(named: "output/tmp-\(self.imageLoop).png")
    }
    
}
