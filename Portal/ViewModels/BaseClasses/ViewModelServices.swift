//
//  ViewModelServices.swift
//  Portal
//
//  Created by Allen on 8/2/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

protocol ViewModelServicesProtocal: NavigationProtocal {
    
}

class ViewModelServices: NSObject, ViewModelServicesProtocal {
    
    func pushViewModel(viewModel: ViewModel, animated: Bool) {}
    
    func popViewModelAnimated(animated: Bool) {}
    
    func popToRootViewModelAnimated(animated: Bool) {}
    
    func presentViewModel(viewModel: ViewModel, animated: Bool, completion: () -> Void) {}
    
    func dismissViewModelAnimated(animated: Bool, completion: () -> Void) {}
    
    func resetRootViewModel(viewModel: ViewModel) {}
    
}
