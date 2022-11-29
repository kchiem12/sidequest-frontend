//
//  mainTabBarViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 11/26/22.
//

import UIKit

class mainTabBarViewController: UITabBarController {
    
    var user: User?
    
    init(user: User?) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tab()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    func tab() {
        let firstVC = HomePage()
        let secondVC = AddJobViewController()
        
        let item1 = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let item2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        firstVC.tabBarItem = item1
        secondVC.tabBarItem = item2
        
        UITabBar.appearance().tintColor = UIColor(red: 0.141, green: 0.383, blue: 0.383, alpha: 1)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.491, green: 0.57, blue: 0.771, alpha: 1)
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        viewControllers = [firstVC, secondVC]
        
        }

}
