//
//  TableViewController.swift
//  sieveOfEratosthenes
//
//  Created by Arunjot Singh on 12/2/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       navigationBar()

    }

    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return primes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LabelTableViewCell
        cell.numLabel.text = String(primes[indexPath.row])
        
        return cell
    }
    
   
    
    // -- for creating the effect of gradually changing color of the cells -- //
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = primes.count - 1
        let green = (CGFloat(index) / CGFloat(itemCount)) * 0.8
        return UIColor(red: 0.9, green: green, blue: 0.2, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorForIndex(index: indexPath.row)
    }
    
    
    
    func navigationBar () {
        
        self.navigationController!.navigationBar.barTintColor = UIColor.black
        self.navigationItem.title = "Primes"
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "Avenir-Book", size: 22)!
        ]
        
        self.navigationController!.navigationBar.titleTextAttributes = attrs
        self.navigationController!.navigationBar.tintColor = UIColor.white
        
    }



}
