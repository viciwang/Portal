//
//  File.swift
//  Portal
//
//  Created by Allen on 8/16/16.
//  Copyright © 2016 Allen. All rights reserved.
//

import UIKit

class File: NSObject {
    
    let type: FileType
    let path: NSURL
    var size: UInt64?
    let displayName: String
    let fileExtension: String?
    let attributes: NSDictionary?
    
    var subpaths: [String]? {
        get {
            if type == .Directory {
                var paths = [String]()
                for p in NSFileManager.defaultManager().subpathsAtPath(path.absoluteString)!{
                    paths.insert(p, atIndex: 0);
                }
                return paths
            }
            else {
                return nil
            }
        }
    }
    
    init(path: NSURL) {
        if checkDirectory(path) {
            type = FileType.Directory
            fileExtension = nil
            attributes = nil
            size = nil
        }
        else {
            if let attr = getFileAttribute(path) {
                size = attr.fileSize()
                attributes = attr
            }
            else {
                size = nil
                attributes = nil
            }
            if let fileExtension = path.pathExtension {
                type = FileType(rawValue: fileExtension) ?? .Unknown
                self.fileExtension = fileExtension
            }
            else {
                type = .Unknown
                self.fileExtension = nil
            }
        }
        displayName = path.lastPathComponent!
        self.path = path
    }
}

func checkDirectory(filePath: NSURL) -> Bool {
    var isDirectory = false
    do {
        var resourceValue: AnyObject?
        try filePath.getResourceValue(&resourceValue, forKey: NSURLIsDirectoryKey)
        if let number = resourceValue as? NSNumber where number == true {
            isDirectory = true
        }
    }
    catch {}
    return isDirectory
}

func getFileAttribute(filePath: NSURL) -> NSDictionary? {
    guard let path = filePath.path else {
        return nil
    }
    do {
        let attribute = try NSFileManager.defaultManager().attributesOfItemAtPath(path) as NSDictionary
        return attribute
    }
    catch {}
    return nil
}

enum FileType:String {
    
    case Directory = "Directory"
    
    case ZIP = "zip"
    
    case MP4 = "mp4"
    
    case MP3 = "mp3"
    
    case PNG = "png"
    
    case Unknown = "Unknown"
}
