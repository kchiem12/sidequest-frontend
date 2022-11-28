//
//  mainTabBarViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 11/26/22.
//

import UIKit

class mainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SideQuest"
        
        // Nav Bar Color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.491, green: 0.57, blue: 0.771, alpha: 1)
        navigationItem.standardAppearance = appearance;
        navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
        
        tab()
        
    }
    
    func tab() {
        let firstVC = HomePage()
        let secondVC = AddJobViewController()
        
        let item1 = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let item2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        firstVC.tabBarItem = item1
        secondVC.tabBarItem = item2
        
        viewControllers = [firstVC, secondVC]
        }

}
