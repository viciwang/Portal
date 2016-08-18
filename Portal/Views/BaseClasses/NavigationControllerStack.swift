//
//  NavigationControllerStack.swift
//  Portal
//
//  Created by Allen on 8/1/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit
import ReactiveCocoa

internal func classAsString(cls: AnyClass) -> String {
    #if _runtime(_ObjC)
        return NSStringFromClass(cls)
    #else
        return String(cls)
    #endif
}

internal func stringAsClass(string: String) -> AnyClass? {
    return NSClassFromString(string)
}

class NavigationControllerStack: NSObject {
    
    let services: ViewModelServicesProtocal
    
    var navigationControllers: [UINavigationController]
    
    var topNavigationController: UINavigationController? {
        return navigationControllers.last
    }
    
    let viewModelViewMap = ["FileViewModel" : "FileViewController"]
    
    
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
        self.services.pushViewModelSignal.observeNext { (navigatinParams) in
            guard let viewModel = navigatinParams.viewModel else {
                assert(false, "Can't not push a viewController with a nil viewModel")
                return
            }
            guard let viewControllerName = self.viewModelViewMap[classAsString(viewModel.dynamicType)] else {
                assert(false, "Can't not find a viewController string map to the viewModel : \(viewModel.dynamicType)")
                return
            }
            guard let viewController = stringAsClass(viewControllerName) as? ViewController.Type else {
                assert(false, "Can't not instance a viewController from string : \(viewModel.dynamicType)")
                return
            }
            self.topNavigationController?.pushViewController(viewController.init(viewModel:viewModel), animated: navigatinParams.animated)
        }
        
        self.services.popViewModelSignal.observeNext { (navigationParams) in
            if let topNavigationController = self.topNavigationController {
                if topNavigationController.viewControllers.count == 1 {
                    topNavigationController.dismissViewControllerAnimated(true, completion: {
//                        unowned self
                        self.popNavigationController()
                    })
                }
                else {
                    topNavigationController.popViewControllerAnimated(navigationParams.animated)
                }
            }
        }
    }
    
}
