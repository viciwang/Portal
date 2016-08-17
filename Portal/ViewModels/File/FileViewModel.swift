//
//  FileListViewModel.swift
//  Portal
//
//  Created by Allen on 8/10/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class FileViewModel: ViewModel {
    
    static let ParamsKeyPath = "ParamsKeyPath"
    
    let path: NSURL?
    
    var file: File? {
        get {
            if let path = path {
                return File(path: path)
            }
            else {
                return nil
            }
        }
    }
    
    var subFiles: [File]? {
        get {
            if let file = self.file where file.type == .Directory {
                var files = [File]()
                for subPath in file.subpaths! {
                    let url = NSURL(string : subPath)
                    files.insert(File(path: url!), atIndex: 0)
                }
                return files
            }
            else {
                return nil
            }
        }
    }
    
    override init?(services: ViewModelServicesProtocal, params: [String : AnyObject]?) {
        if let params = params, url = params[FileViewModel.ParamsKeyPath] as? NSURL {
            path = url
        }
        else {
            return nil
        }
        super.init(services: services, params: params)
    }
    
    func selectFileAtIndex(index: Int) {
        
    }
}
