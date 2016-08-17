//
//  ViewModel.swift
//  Portal
//
//  Created by Allen on 8/1/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class ViewModel: NSObject {
    
    let services: ViewModelServicesProtocal
    let params: [String : AnyObject]?
    
    init?(services: ViewModelServicesProtocal, params: [String : AnyObject]?) {
        self.services = services
        self.params = params;
    }
}
