//
//  NavigationControllerStack.swift
//  Portal
//
//  Created by Allen on 8/1/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit
import ReactiveCocoa

class NavigationControllerStack: NSObject {
    
    let services: ViewModelServicesProtocal
    
    var navigationControllers: [UINavigationController]
    
    var topNavigationController: UINavigationController? {
        return navigationControllers.last
    }
    
    let viewModelViewMap = [NSClassFromString()]
    
    
    //MARK: pubilc func
    
    init(services: ViewModelServicesProtocal) {
        self.services = services
        self.navigationControllers = []
        super.init()
        self.registerNavigationHooks()
    }
    
    func pushNavigationController(navigationController: UINavigationController) {
        if navigationControllers.contains(navigationController) {
            return
        }
        navigationControllers.append(navigationController)
    }
    
    func popNavigationController() -> UINavigationController? {
        return navigationControllers.popLast()
    }
    
    //MARK: private func
    
    private func registerNavigationHooks() {
        
    }
    
}
