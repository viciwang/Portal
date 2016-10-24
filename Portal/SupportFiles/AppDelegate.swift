
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
    

    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        viewModelServices = ViewModelServices()
        navigationControllerStack = NavigationControllerStack(services: viewModelServices!)
//        rootViewModel = FileViewModel(services: viewModelServices!, params: [FileViewModel.ParamsKeyPath : documentsURL()])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        viewModelServices?.resetRootViewModel(viewModel: rootViewModel!)
        window?.makeKeyAndVisible()
        
        return true
    }
}

