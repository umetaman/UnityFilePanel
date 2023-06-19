//
//  Plugin.swift
//  UnityFilePanel
//
//  Created by umetaman on 2023/06/12.
//

import Cocoa
import Foundation
import UniformTypeIdentifiers

private func pointerToString(text: OpaquePointer) -> String {
    return String(cString: UnsafePointer<CChar>(text))
}

private func nsstringToUnsafePointer(str: NSString) -> UnsafePointer<CChar>? {
    if let utf8String = str.utf8String {
        return utf8String
    }else{
        if let cString = "".cString(using: String.Encoding.utf8) {
            return UnsafePointer<CChar>(cString)
        }
        else{
            return nil
        }
    }
}

public class Dialog {
    public static func OpenPanel(
        title: OpaquePointer,
        prompt: OpaquePointer,
        message: OpaquePointer,
        directory: OpaquePointer,
        canChooseFiles: Bool,
        canChooseDirectories: Bool,
        multipleSelection: Bool,
        allowFileTypes: OpaquePointer
    ) -> NSString {
        let openPanel = NSOpenPanel()
        openPanel.title = pointerToString(text: title)
        openPanel.prompt = pointerToString(text: prompt)
        openPanel.message = pointerToString(text: message)
        openPanel.directoryURL = URL(string: pointerToString(text: directory));
        openPanel.canChooseFiles = canChooseFiles
        openPanel.canChooseDirectories = canChooseDirectories
        openPanel.allowsMultipleSelection = multipleSelection
        
        if let keyWindow = NSApplication.shared.keyWindow {
            keyWindow.beginSheet(openPanel)
        }
        
        let allowFileTypes = pointerToString(text: allowFileTypes).components(separatedBy: ",")
        if #available(macOS 11, *) {
            let mappedTypes = allowFileTypes.map { UTType(filenameExtension: $0) }
            var utTypes: [UTType] = []
            
            mappedTypes.forEach{ t in
                if let t {
                    utTypes.append(t)
                }
            }
            
            openPanel.allowedContentTypes = utTypes
        }else{
            openPanel.allowedFileTypes = allowFileTypes
        }
        
        if(openPanel.runModal() == NSApplication.ModalResponse.OK){
            if(openPanel.urls.count > 0){
                let paths = NSMutableArray.init(capacity: openPanel.urls.count)
                
                for i in 0..<openPanel.urls.count {
                    let url = openPanel.urls[i]
                    if #available(macOS 13, *){
                        paths.add(url.path(percentEncoded: false))
                    }else{
                        paths.add(url.absoluteString)
                    }
                }
                
                return paths.componentsJoined(by: "\n") as NSString
            }
        }
        
        return ""
    }
    
    public static func SavePanel(
        title: OpaquePointer,
        prompt: OpaquePointer,
        message: OpaquePointer,
        directory: OpaquePointer,
        allowFileTypes: OpaquePointer
    ) -> NSString {
        let savePanel = NSSavePanel()
        savePanel.title = pointerToString(text: title)
        savePanel.prompt = pointerToString(text: prompt)
        savePanel.message = pointerToString(text: message)
        savePanel.directoryURL = URL(string: pointerToString(text: directory))
        savePanel.canCreateDirectories = true
        
        if let keyWindow = NSApplication.shared.keyWindow {
            keyWindow.beginSheet(savePanel)
        }
        
        let allowFileTypes = pointerToString(text: allowFileTypes).components(separatedBy: ",")
        if #available(macOS 11, *) {
            let mappedTypes = allowFileTypes.map { UTType(filenameExtension: $0) }
            var utTypes: [UTType] = []
            
            mappedTypes.forEach{ t in
                if let t {
                    utTypes.append(t)
                }
            }
            
            savePanel.allowedContentTypes = utTypes
        }else{
            savePanel.allowedFileTypes = allowFileTypes
        }
        
        if(savePanel.runModal() == NSApplication.ModalResponse.OK) {
            if let url = savePanel.url {
                if #available(macOS 13, *) {
                    return url.path(percentEncoded: false) as NSString
                }else{
                    return url.absoluteString as NSString
                }
            }else{
                return "";
            }
        }else{
            return "";
        }
    }
}

@_cdecl("DialogOpenPanel")
public func DialogOpenPanel(title: OpaquePointer,
                             prompt: OpaquePointer,
                             message: OpaquePointer,
                             directory: OpaquePointer,
                             canChooseFiles: Bool,
                             canChooseDirectories: Bool,
                             multipleSelection: Bool,
                             allowFileTypes: OpaquePointer) -> UnsafePointer<CChar>? {
    let path = Dialog.OpenPanel(
        title: title,
        prompt: prompt,
        message: message,
        directory: directory,
        canChooseFiles: canChooseFiles,
        canChooseDirectories: canChooseDirectories,
        multipleSelection: multipleSelection,
        allowFileTypes: allowFileTypes)
    
    return nsstringToUnsafePointer(str: path)
}

@_cdecl("DialogSavePanel")
public func DialogSavePanel(title: OpaquePointer, prompt: OpaquePointer, message: OpaquePointer, directory: OpaquePointer, allowFileTypes: OpaquePointer) -> UnsafePointer<CChar>? {
 
    let path = Dialog.SavePanel(title: title, prompt: prompt, message: message, directory: directory, allowFileTypes: allowFileTypes)
    return nsstringToUnsafePointer(str: path)
}
