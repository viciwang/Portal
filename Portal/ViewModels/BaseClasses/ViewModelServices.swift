//
//  ViewModelServices.swift
//  Portal
//
//  Created by Allen on 8/2/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

public class ViewModelNavigationParams {
    var viewModel: ViewModel?
    var animated = true
    var completion: (() -> Void)?
    
    init(viewModel: ViewModel? , animated: Bool = true, completion: (()-> Void)? = nil) {
        self.viewModel = viewModel
        self.animated = animated
        self.completion = completion
    }
}

typealias NavigationSignal = Signal<ViewModelNavigationParams, NoError>
typealias NavigationObserver = Observer<ViewModelNavigationParams, NoError>

protocol ViewModelServicesProtocal: NavigationProtocal {
    
    var pushViewModelSignal: NavigationSignal {get}
    
    var popViewModelSignal: NavigationSignal {get}
    
    var popToRootViewModelSignal: NavigationSignal {get}
    
    var presentViewModelSignal: NavigationSignal {get}
    
    var dismissViewModelSignal: NavigationSignal {get}
    
    var resetRootViewModelSignal: NavigationSignal {get}
    
}

class ViewModelServices: NSObject, ViewModelServicesProtocal {
    
    typealias NavigationSignalPipe = (NavigationSignal, NavigationObserver)
    
    private let pushSignalPipe: NavigationSignalPipe
    private let popSignalPipe: NavigationSignalPipe
    private let popToRootSignalPipe: NavigationSignalPipe
    private let presentSignalPipe: NavigationSignalPipe
    private let dismissSignalPipe: NavigationSignalPipe
    private let resetRootSignalPipe: NavigationSignalPipe
    
    var pushViewModelSignal: NavigationSignal {
        return pushSignalPipe.0
    }
    
    var popViewModelSignal: NavigationSignal {
        return popSignalPipe.0
    }
    
    var popToRootViewModelSignal: NavigationSignal {
        return popToRootSignalPipe.0
    }
    
    var presentViewModelSignal: NavigationSignal {
        return presentSignalPipe.0
    }
    
    var dismissViewModelSignal: NavigationSignal {
        return dismissSignalPipe.0
    }
    
    var resetRootViewModelSignal: NavigationSignal {
        return resetRootSignalPipe.0
    }
    
    override init() {
        pushSignalPipe = Signal.pipe()
        popSignalPipe = Signal.pipe()
        popToRootSignalPipe = Signal.pipe()
        presentSignalPipe = Signal.pipe()
        dismissSignalPipe = Signal.pipe()
        resetRootSignalPipe = Signal.pipe()
    }
    
    func pushViewModel(viewModel: ViewModel, animated: Bool) {
        pushSignalPipe.1.sendNext(ViewModelNavigationParams(viewModel: viewModel, animated: animated))
    }
    
    func popViewModelAnimated(animated: Bool) {
        popSignalPipe.1.sendNext(ViewModelNavigationParams(viewModel: nil, animated: animated))
    }
    
    func popToRootViewModelAnimated(animated: Bool) {
        popToRootSignalPipe.1.sendNext(ViewModelNavigationParams(viewModel: nil, animated: animated))
    }
    
    func presentViewModel(viewModel: ViewModel, animated: Bool, completion: (() -> Void)?) {
        presentSignalPipe.1.sendNext(ViewModelNavigationParams(viewModel: viewModel, animated: animated, completion: completion))
    }
    
    func dismissViewModelAnimated(animated: Bool, completion: (() -> Void)?) {
        dismissSignalPipe.1.sendNext(ViewModelNavigationParams(viewModel: nil, animated: animated, completion: completion))
    }
    
    func resetRootViewModel(viewModel: ViewModel) {
        resetRootSignalPipe.1.sendNext(ViewModelNavigationParams(viewModel: viewModel))
    }
    
}
