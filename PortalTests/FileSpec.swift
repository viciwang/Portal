//
//  FileSpec.swift
//  Portal
//
//  Created by Allen on 8/16/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import Quick
import Nimble

class FileSpec: QuickSpec {
    
    override func spec() {
        
        describe("init method") {
            
            var fileViewModel: FileViewModel? = nil
            
            context("when init with a correct path") {
                
                context("and the path is a directory,") {
                    let pathUrl = NSURL(string:NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!)
                    fileViewModel = FileViewModel(services: ViewModelServices(), params: [FileViewModel.ParamsKeyPath : pathUrl!])
                    let file = fileViewModel?.file
                    it("the file property should be a directory.", closure: {
                        expect(file) != nil
                        if let file = file {
                            expect(file.type) == FileType.Directory
                            expect(file.attributes) != nil
                            expect(file.displayName).to(equal(pathUrl?.lastPathComponent!))
                            expect(file.fileExtension) == nil
                            expect(file.path).to(equal(pathUrl))
                            expect(file.size) == nil
                            expect(file.subpaths) != nil
                        }
                    })
                }
                
                context("and the path is a file") {
                    
                    let pathUrl = NSURL(string:NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!)
                    fileViewModel = FileViewModel(services: ViewModelServices(), params: [FileViewModel.ParamsKeyPath : pathUrl!])
                    let file = fileViewModel?.file
                    it("the file property should be a file.", closure: {
                        expect(file) != nil
                        if let file = file {
                            expect(file.type) == FileType.Directory
                            expect(file.attributes) != nil
                            expect(file.displayName).to(equal(pathUrl?.lastPathComponent!))
                            expect(file.fileExtension) == nil
                            expect(file.path).to(equal(pathUrl))
                            expect(file.size) == nil
                            expect(file.subpaths) != nil
                        }
                    })
                    
                }
            }
        }
    }
}
