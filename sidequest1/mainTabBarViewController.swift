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
        
        self.delegate = self
        
        tab()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: false)
//        navigationController?.isNavigationBarHidden = false
    }
    
    
    func tab() {
        let firstVC = UINavigationController(rootViewController: HomePage(user: nil))
        let secondVC = UINavigationController(rootViewController: AddJobViewController(user: user))
        let thirdVC = UINavigationController(rootViewController: ProfileViewController(user: user))
        
        let item1 = UITabBarItem(title: "", image: UIImage(named: "search-post"), selectedImage: UIImage(named: "search-post"))
        let item2 = UITabBarItem(title: "", image: UIImage(named: "create-posting"), selectedImage: UIImage(named: "create-posting"))
        let item3 = UITabBarItem(title: "", image: UIImage(named: "profile-icon"), selectedImage: UIImage(named: "selected-profile"))

        firstVC.tabBarItem = item1
        secondVC.tabBarItem = item2
        thirdVC.tabBarItem = item3
        
        
//        UITabBar.appearance().tintColor = .white
//        UITabBar.appearance().unselectedItemTintColor = .white
        
        if #available(iOS 15, *) {
                   let tabBarAppearance = UITabBarAppearance()
                    tabBarAppearance.backgroundColor = .white
                    tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.red]
                    tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
                    tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.black
                    tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.red
                    tabBar.standardAppearance = tabBarAppearance
                    tabBar.scrollEdgeAppearance = tabBarAppearance
         }
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.491, green: 0.57, blue: 0.771, alpha: 1)
        tabBar.standardAppearance = appearance
        
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
//        tabBar.scrollEdgeAppearance = nil

        
        
        viewControllers = [firstVC, secondVC, thirdVC]
        
        }

}

extension mainTabBarViewController: UITabBarControllerDelegate {
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//       print("selected item")
//    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        print(tabBarIndex)
        if tabBarIndex == 0 {
            
        }
        else {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
            tabBar.standardAppearance = appearance
        }
    }
}
