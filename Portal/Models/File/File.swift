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
    let displaySize: String?
    let fileExtension: String?
    let attributes: [String : AnyObject]?
    
    var subpaths: [NSURL]? {
        get {
            if type == .Directory {
                var paths = [NSURL]()
                for p in NSFileManager.defaultManager().subpathsAtPath(path.absoluteString)!{
                    paths.insert(path.URLByAppendingPathComponent(p), atIndex: 0);
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
        displayName = filePath.lastPathComponent!
        path = filePath
        if attributes == nil {
            return nil
        }
        if let fileType = (attributes?[NSFileType] as? String) where fileType == NSFileTypeDirectory {
            type = FileType.Directory
            fileExtension = nil
            size = nil
            displaySize = nil
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
            size = (attributes![NSFileSize] as? NSNumber)?.unsignedLongLongValue
            displaySize = stringFromByte(size!)
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

func stringFromByte(byte: UInt64) -> String {
    switch byte {
    case 0...1024:
        return String("\(byte) byte")
    case 1024...1048575:
        return NSString(format: "%.2f Kb",Double(byte)/1024.0) as String
    default:
        return NSString(format: "%.2f Mb",Double(byte)/1048576.0) as String
    }
}

enum FileType:String {
    
    case Directory = "Directory"
    
    case ZIP = "zip"
    
    case MP4 = "mp4"
    
    case MP3 = "mp3"
    
    case PNG = "png"
    
    case Unknown = "Unknown"
}
