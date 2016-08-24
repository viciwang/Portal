//
//  Router.swift
//  Portal
//
//  Created by Allen on 8/24/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class Router: NSObject {
    
    private static let viewModelViewMap = [classAsString(FileViewModel.classForCoder()) : classAsString(FileViewController.classForCoder())]
    
    class func viewControllerForViewModel(viewModel: ViewModel?) -> UIViewController? {
        guard let viewModel = viewModel else {
            assert(false, "Can't not push a viewController with a nil viewModel")
            return nil
        }
        guard let viewControllerName = Router.viewModelViewMap[classAsString(viewModel.dynamicType)] else {
            assert(false, "Can't not find a viewController string map to the viewModel : \(viewModel.dynamicType)")
            return nil
        }
        guard let viewController = stringAsClass(viewControllerName) as? ViewController.Type else {
            assert(false, "Can't not instance a viewController from string : \(viewModel.dynamicType)")
            return nil
        }
        return viewController.init(viewModel:viewModel)
    }
}
