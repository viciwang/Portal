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
    
    @discardableResult
    func popNavigationController() -> UINavigationController? {
        return navigationControllers.popLast()
    }
    
    //MARK: private func
    
    private func registerNavigationHooks() {
        
        self.services.pushViewModelSignal.observeValues { [unowned self] (navigatinParams) in
            if let viewController = Router.viewControllerForViewModel(viewModel: navigatinParams.viewModel) {
                self.topNavigationController?.pushViewController(viewController as! ViewController, animated: navigatinParams.animated)
            }
        }
        
        self.services.popViewModelSignal.observeValues { [unowned self] (navigationParams) in
            if let topNavigationController = self.topNavigationController {
                if topNavigationController.viewControllers.count == 1 {
                    topNavigationController.dismiss(animated: true, completion: {
                        self.popNavigationController()
                    })
                }
                else {
                    topNavigationController.popViewController(animated: navigationParams.animated)
                }
            }
        }
        
        self.services.resetRootViewModelSignal.observeValues { [unowned self] (navigationParams) in
            self.navigationControllers.removeAll()
            var viewController: UIViewController!
            if let vc = Router.viewControllerForViewModel(viewModel: navigationParams.viewModel) {
                if !(vc is UINavigationController) && !(vc is UITabBarController) {
                    viewController = NavigationController(rootViewController: vc)
                    self.pushNavigationController(navigationController: viewController as! NavigationController)
                }
                else {
                    viewController = vc
                }
                Global.sharedAppWindow.rootViewController = viewController
            }
        }
    }
    
}
