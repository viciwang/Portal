
//
//  AppDelegate.swift
//  Portal
//
//  Created by Allen on 7/15/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var viewModelServices: ViewModelServices?
    var navigationControllerStack: NavigationControllerStack?
    var rootViewModel: ViewModel?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        viewModelServices = ViewModelServices()
        navigationControllerStack = NavigationControllerStack(services: viewModelServices!)
        rootViewModel = HomeViewModel(services: viewModelServices!, params: [:])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        viewModelServices?.resetRootViewModel(viewModel: rootViewModel!)
        window?.makeKeyAndVisible()
        return true
    }
}

