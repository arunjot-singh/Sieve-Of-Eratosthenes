//
//  ViewController.swift
//  sieveOfEratosthenes
//
//  Created by Arunjot Singh on 12/1/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit
var primes = Array<Int>()

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var background: UIView!
    @IBOutlet var input: UITextField!
    @IBOutlet var find: UIButton!
    
    var backgroundColors = [UIColor()]
    var backgroundLoop = 0
    var label = UILabel()
    
   
    @IBOutlet var tutorial: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        primes.removeAll()
        find.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.barTintColor = UIColor.white
        
        self.input.delegate = self
        
        background.backgroundColor = UIColor.init(red: 0.35, green: 0.00, blue: 0.71, alpha: 1.00)
        backgroundColors = [UIColor.init(red: 0.40, green: 0.00, blue: 0.71, alpha: 1.00), UIColor.init(red: 0.35, green: 0.00, blue: 0.71, alpha: 1.00)]
        
        animateBackgroundColour()
        placeholderSettings()
        buttonBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func calcPrimes(_ sender: Any) {
        
        self.view.endEditing(true)
        
        guard let text = input.text, !text.isEmpty  else {
            createToast(message: "Enter a number", width: 200, timed: true)
            return
        }
        
        if (Int(input.text!)! < 2) {
            createToast(message: "Enter a number > 1", width: 220, timed: true)
            input.text = ""
            return
        } else if (Int(input.text!)! > 9999999) {
            createToast(message: "Enter a number < 10,000,000", width: 260, timed: true)
            input.text = ""
            return
        } else {
            tutorial.isEnabled = false
            createToast(message: "Computing Primes!", width: 220, timed: false)
            find.isHidden = true
            activityIndicator.startAnimating()
            
            DispatchQueue.global(qos: .background).async {
                // Validate user input
                self.findPrimes(number: Int(self.input.text!)!)
                
                // Go back to the main thread to update the UI
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "show", sender: self)
                    self.input.text = ""
                    self.activityIndicator.stopAnimating()
                    self.hideLabel()
                    self.tutorial.isEnabled = true

                }
            }
        }

    }
    
    @IBAction func showTutorial(_ sender: Any) {
        performSegue(withIdentifier: "showTutorial", sender: self)
        
        func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
            return UIInterfaceOrientationMask.portrait
        }
        
    }
    
    
    // ---- Sieve of Eratosthenes ---- //
    func findPrimes(number : Int) {
        
        var array = Array(repeating: true, count: number+1)
        var last = 0
        
        if (Int(sqrt(Double(number))) < 2) {
            last = number
        } else {
            last = Int(sqrt(Double(number)))
        }
        
        for i in 2...last {

            if (array[i] == true) {
                var start = i*2
                
                while (start < number+1) {
                    array[start] = false
                    start += i
                }
            }
        }
        
        for j in 2...number {
            if(array[j] == true) {
                primes.append(j)
            }
        }
    }
    
    // --- creates changing background colors --- //
    func animateBackgroundColour () {
        
        if backgroundLoop < backgroundColors.count - 1 {
            backgroundLoop += 1
        } else {
            backgroundLoop = 0
        }
        UIView.animate(withDuration: 2, delay: 2, options: [UIViewAnimationOptions.curveLinear, UIViewAnimationOptions.allowUserInteraction], animations: { () -> Void in
            self.background.backgroundColor =  self.backgroundColors[self.backgroundLoop]
            
        }) {(Bool) -> Void in
            self.animateBackgroundColour()
        }
    }
    
    
    func placeholderSettings () {
        
        let fontP = UIFont(name: "ChalkboardSE-Light", size: 20)!
        let attributesP = [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: fontP]
        input.attributedPlaceholder = NSAttributedString(string: "Enter a number > 1", attributes: attributesP)
        input.textColor = UIColor.orange
        input.textAlignment = NSTextAlignment.center
        input.underlined()
    }
    
    func buttonBorder () {
        
        find.backgroundColor = UIColor.lightText
        find.layer.cornerRadius = 10
        find.layer.borderWidth = 1
        find.layer.borderColor = UIColor.black.cgColor
        find.contentEdgeInsets.left = 8
        find.contentEdgeInsets.right = 8
        find.contentEdgeInsets.top = 5
        find.contentEdgeInsets.bottom = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    
    
    // -- userdefined method to create a toast message -- //
    func createToast (message: String, width: CGFloat, timed: Bool) {
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 25))
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Light", size: 17)
        label.textColor = UIColor.white
        label.center.y = self.view.bounds.size.height/1.8
        label.center.x = self.view.bounds.size.width/2
        label.backgroundColor = UIColor.black
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.alpha = 0.70
        self.view.addSubview(label)
        label.isHidden = false
        
        if timed {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideLabel), userInfo: nil, repeats: false)
        }
    }
    
    func hideLabel () {
        label.removeFromSuperview()
    }
    
    
}

extension UITextField {
    
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}




