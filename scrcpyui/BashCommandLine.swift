//
//  BashCommandLine.swift
//  scrcpyui
//
//  Created by Pedro Fraca on 31.01.21.
//  Copyright © 2021 Fraca, Pedro. All rights reserved.
//

import Foundation

class BashCommandLine : CommandLine {
    
    func execute(launchPath: String, arguments: [String], readOutput: Bool) -> String {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        task.launch()
        
        if(!readOutput) {
            return ""
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: String.Encoding.utf8) else { return "" }
        
        return output
    }
    
}
