//
//  ViewModel.swift
//  Portal
//
//  Created by Allen on 8/1/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    fileprivate(set) var services: ViewModelServicesProtocal? = nil
}

protocol ViewModelProtocal {
    init?(params: [String : Any])
}

extension ViewModelProtocal {
    init?(services: ViewModelServicesProtocal, params: [String : Any]) {
        if let obj: Self = ParameterBuilder.build(params: params) {
            if let viewModel = obj as? ViewModel {
                viewModel.services = services
            }
            self = obj
        }
        else {
            return nil
        }
    }
}

private class ParameterBuilder <T: ViewModelProtocal> {
    
    class func build(params: [String : Any]) -> T? {
        return T.init(params: params)
    }
}

infix operator <-

public func <- <T>(left: inout T, right: Any?) {
    if let rightObject = right as? T {
        left = rightObject
    }
}

public func <- <T>(left: inout T?, right: Any?) {
    if let rightObject = right as? T {
        left = rightObject
    }
    else {
        left = nil
    }
}

