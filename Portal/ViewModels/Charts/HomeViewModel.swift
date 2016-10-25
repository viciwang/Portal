//
//  HomeViewModel.swift
//  Portal
//
//  Created by Allen on 24/10/2016.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class HomeViewModel: ViewModel, ViewModelProtocal {
    
    var chartsViewModels: [ChartsViewModel] = []
    var chartsThumbnails: [UIImage] = []
    
    required init?(params: [String : Any]) {
        
    }
    
}
