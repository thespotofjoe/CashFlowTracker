//
//  PageViewController.swift
//  Daily Goal Tracker
//
//  Created by Joseph Buchoff on 10/2/20.
//  Copyright © 2020 Joe's Studio. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate
{
    /* Properties */
    var currPage = 0
    lazy var viewControllerList:[UIViewController] = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = storyboard.instantiateViewController(identifier: "VC1")
        let vc2 = storyboard.instantiateViewController(identifier: "VC2")
        let vc3 = storyboard.instantiateViewController(identifier: "VC3")
             
        return [vc1, vc2, vc3]
             
       }()
    
    /* Computed Properties */
    var prevPage: Int? { return (currPage == 0) ? nil : (currPage - 1) }
    var nextPage: Int? { return (currPage == 3) ? nil : (currPage + 1) }
     
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
           self.dataSource = self
           if let vc = viewControllerList.first
           {
               self.setViewControllers([vc],
                                       direction: .forward,
                                       animated: true,
                                       completion: nil)
           }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let index = viewControllerList.lastIndex(of: viewController) else { return nil }
        
        return index <= 0 ? nil : viewControllerList[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let index = viewControllerList.lastIndex(of: viewController) else { return nil }
        
        return index == (viewControllerList.count - 1) ? nil : viewControllerList[index+1]
    }
    
    
}
