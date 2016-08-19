//
//  FileListViewModel.swift
//  Portal
//
//  Created by Allen on 8/10/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

func documentURL() -> NSURL {
    let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, false).first!
    return NSURL(string: path)!
}

class FileViewModel: ViewModel {
    
    static let ParamsKeyPath = "ParamsKeyPath"
    
    let pathURL: NSURL?
    var file: File?
    let subFiles: [File]?
    
    override init?(services: ViewModelServicesProtocal, params: [String : AnyObject]?) {
        if let params = params, url = params[FileViewModel.ParamsKeyPath] as? NSURL {
            pathURL = url
            file = File(filePath: pathURL!)
            if let file = self.file where file.type == .Directory {
                var files = [File]()
                for subPath in file.subpaths! {
                    let url = NSURL(string : subPath)
                    if let subFile = File(filePath: url!) {
                        files.insert(subFile, atIndex: 0)
                    }
                }
                subFiles = files
            }
            else {
                subFiles = nil
            }
        }
        else {
            return nil
        }
        super.init(services: services, params: params)
    }
    
    func selectFileAtIndex(index: Int) {
        guard let subFiles = subFiles else {
            return
        }
        guard index > 0 && index < subFiles.count else {
            return
        }
        if let viewModel = FileViewModel(services: services, params: [FileViewModel.ParamsKeyPath : subFiles[index].path]) {
            services.pushViewModel(viewModel, animated: true)
        }
    }
}
