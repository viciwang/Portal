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
    let displayName: String
    let size: UInt64?
    let fileExtension: String?
    let attributes: [String : AnyObject]?
    
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
    
    init?(filePath: NSURL) {
        attributes = getFileAttribute(filePath)
        displayName = path.lastPathComponent!
        path = filePath
        if attributes == nil {
            return nil
        }
        if let fileType = (attributes?[NSFileType] as? String) where fileType == NSFileTypeDirectory {
            type = FileType.Directory
            fileExtension = nil
            size = nil
        }
        else {
            
            if let fileExtension = path.pathExtension {
                type = FileType(rawValue: fileExtension) ?? .Unknown
                self.fileExtension = fileExtension
            }
            else {
                type = .Unknown
                self.fileExtension = nil
            }
        }
    }
}

func checkDirectory(filePath: NSURL) -> Bool {
    var isDirectory = false
    do {
        var resourceValue = try NSFileManager.defaultManager().attributesOfItemAtPath(filePath.absoluteString)
        if let fileType = resourceValue[NSFileType] as? String where fileType == NSFileTypeDirectory {
            isDirectory = true
        }
    }
    catch {}
    return isDirectory
}

func getFileAttribute(filePath: NSURL) -> [String : AnyObject]? {
    guard let path = filePath.path else {
        return nil
    }
    do {
        let attribute = try NSFileManager.defaultManager().attributesOfItemAtPath(path)
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
