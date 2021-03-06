//
//  VeinsPageViewController.swift
//  Common Conditions
//
//  Created by Cameron Bardell on 2016-04-29.
//  Copyright © 2016 Cameron Bardell. All rights reserved.
//

import UIKit

class VeinsPageViewController: UIPageViewController {
    @IBAction func done() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController("One"),
                self.newViewController("Two"),
                self.newViewController("Three"),
                self.newViewController("Four"),
                self.newViewController("Five")]
    }()
    
    private func newViewController(number: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .instantiateViewControllerWithIdentifier("veins\(number)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
    }
}

extension VeinsPageViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
}


