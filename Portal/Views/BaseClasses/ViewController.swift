//
//  BaseViewController.swift
//  Portal
//
//  Created by Allen on 8/1/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    required init(viewModel: ViewModel) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
