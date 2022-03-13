//
//  AppDelegate.swift
//  CandySpaceIOSTechnicalTask
//
//  Created by YORK CHAN on 11/3/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        startInitialViewController()
        
        return true
    }
    
    func startInitialViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController()
        let searchView = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let searchViewModel = SearchViewModel()
        let searchRouter = SearchRouter(view: searchView)
        searchView.viewModel = searchViewModel
        searchView.router = searchRouter
        nav.viewControllers = [searchView]
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        
        // TODO: To optimize the clearing cache feature, FILO - remove the cache which has the earliest creation time
        ImageCache.removeAllCache()
        SearchCache.removeAllCache()
    }
}

