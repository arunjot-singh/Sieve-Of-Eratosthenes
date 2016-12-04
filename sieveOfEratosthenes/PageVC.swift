//
//  PageVC.swift
//  sieveOfEratosthenes
//
//  Created by Arunjot Singh on 12/3/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var array: [UIViewController] {
        return [self.VCInstance(name: "textViewVC"), self.VCInstance(name: "imageViewVC")]
    }
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self

        if let firstVC = array.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        view.backgroundColor = UIColor.white
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.orange
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        if viewController.isKind(of: ImageViewVC.self) {
            return array.last
        } else {
            return nil
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController.isKind(of: TextViewVC.self) {
            return array.last
        } else {
            return nil
        }
    }
    
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return array.count
        
    }
    
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    
        guard let firstVC = viewControllers?.first, let firstVCIndex = array.index(of: firstVC) else {
            return 0
        }
        return firstVCIndex
    }
    

}
