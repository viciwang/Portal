//
//  Router.swift
//  Portal
//
//  Created by Allen on 8/24/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class Router: NSObject {
    
    private static let viewModelViewMap: [String : String] = [:]
    
    class func viewControllerForViewModel(viewModel: ViewModel?) -> UIViewController? {
        guard let viewModel = viewModel else {
            assert(false, "Can't not push a viewController with a nil viewModel")
            return nil
        }
        guard let viewControllerName = Router.viewModelViewMap[classAsString(cls: type(of: viewModel))] else {
            assert(false, "Can't not find a viewController string map to the viewModel : \(type(of: viewModel))")
            return nil
        }
        guard let viewController = stringAsClass(string: viewControllerName) as? ViewController.Type else {
            assert(false, "Can't not instance a viewController from string : \(type(of: viewModel))")
            return nil
        }
        return viewController.init(viewModel:viewModel)
    }
}
