//
//  MainTabController.swift
//  soku
//
//  Created by 酒井ゆうき on 2020/08/01.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import FirebaseAuth


class MainTabController : UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuth()
        
        
    }
    
    private func configureTabControllers(uid : String) {
        let homeVC = HomeViewController()
        homeVC.uid = uid
        homeVC.tabBarItem.image = UIImage(systemName: "house.fill")
        homeVC.tabBarItem.title = "Home"
        
        let couplesVC = CouplesViewController()
        let nav1 = createNavController(image: UIImage(systemName: "person.2.fill"), title: "カップル", rootVC: couplesVC)
        
        let searchVC = SearchViewController()
        let nav2 = createNavController(image: UIImage(systemName: "magnifyingglass"), title: "サーチ", rootVC: searchVC)
        

        
        UITabBar.appearance().barTintColor = UIColor.black
        viewControllers = [homeVC, nav1, nav2]
        UITabBar.appearance().tintColor = .systemPink
        tabBar.unselectedItemTintColor = .white

        
    }
    
    //MARK: - API
    
    func checkAuth() {
        
        if let currentUser = Auth.auth().currentUser {
           
            let uid = currentUser.uid
            self.configureTabControllers(uid: uid)
        } else {
            //            self.showErrorAlert(message: "申し訳ありません、認証に失敗しました。")
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            
            DispatchQueue.main.async {
                self.present(loginVC, animated: true, completion: nil)
                
            }
            
            
        }
        
        
    }
    
    func deleteAnonymousUser(user : User) {
        
        user.delete(completion: nil)
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("Can'")
        }
        
        return
        
    }
    //MARK: - Helpers
    
    private func createNavController(image : UIImage?, title : String, rootVC : UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootVC)
        let appearence = UINavigationBarAppearance()

        
        
        appearence.configureWithOpaqueBackground()
        appearence.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        appearence.backgroundColor = .systemGroupedBackground
        
        appearence.shadowColor = .clear
        
        nav.navigationBar.standardAppearance = appearence
        nav.navigationBar.compactAppearance = appearence
        nav.navigationBar.scrollEdgeAppearance = appearence
        
        nav.navigationBar.tintColor = .black
        nav.navigationBar.layer.borderColor = UIColor.white.cgColor
        
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        
        return nav
        
        
    }
    
}
