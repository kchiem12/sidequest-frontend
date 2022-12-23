//
//  mainTabBarViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 11/26/22.
//

import UIKit

class mainTabBarViewController: UITabBarController {
    
    var user: User
    
    // Requires a User to be passed into it
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
//        tabBar.tintColor = UIColor(rgb: 0x4b66ac)
//        tabBar.unselectedItemTintColor = UIColor(rgb: 0xFFFFFF)
        tab()
    }
    
    
    // Configure Tabs (located at bottom)
    func tab() {
        let firstVC = UINavigationController(rootViewController: HomePage(user: user))
        let secondVC = UINavigationController(rootViewController: AddJobViewController(user: user))
        let thirdVC = UINavigationController(rootViewController: ProfileViewController(user: user))
        
        let item1 = UITabBarItem(title: "", image: UIImage(named: "search-post"), selectedImage: UIImage(named: "search-post"))
        let item2 = UITabBarItem(title: "", image: UIImage(named: "create-posting"), selectedImage: UIImage(named: "create-posting"))
        let item3 = UITabBarItem(title: "", image: UIImage(named: "profile-icon"), selectedImage: UIImage(named: "selected-profile"))

        firstVC.tabBarItem = item1
        secondVC.tabBarItem = item2
        thirdVC.tabBarItem = item3
        
        configureTabColors(tabBar: tabBar, background: UIColor(rgb: 0x7D91C5))

        viewControllers = [firstVC, secondVC, thirdVC]
        
        }

}

// Configure tab bar background
func configureTabColors(tabBar: UITabBar, background: UIColor) {
    if #available(iOS 15, *) {
       let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = background
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .white
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(rgb: 0x4b66ac)
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    } else {
        let tabBarAppearance = UITabBarAppearance()
         tabBarAppearance.backgroundColor = background
         tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .white
         tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(rgb: 0x4b66ac)
         tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}

extension mainTabBarViewController: UITabBarControllerDelegate {
    // If User selects Create tab, then the background of the tabbar will be a different color
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            configureTabColors(tabBar: tabBar, background: UIColor(rgb: 0x6EBABA))
        }
        else {
            configureTabColors(tabBar: tabBar, background: UIColor(rgb: 0x7D91C5))
        }
    }
}
