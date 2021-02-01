//
//  DevicesRepository.swift
//  scrcpyui
//
//  Created by Pedro Fraca on 31.01.21.
//  Copyright © 2021 Fraca, Pedro. All rights reserved.
//

import Foundation

class DevicesRepository {
    var commandLine : CommandLine
    
    init(withCommandLine commandLine : CommandLine) {
        self.commandLine = commandLine
    }

    func getDevices() -> [String] {
        let result = commandLine.execute(launchPath:"/bin/bash",arguments:[ "-l", "-c", "adb devices" ], readOutput: true)
        return parseDevicesFromAdbOutput(output: result)
    }
    
    func parseDevicesFromAdbOutput(output: String) -> [String] {
        let devices = output.split(separator: "\n")
        var result = [String]()
        if(devices.count>1) {
            for n in 1...devices.count-1 {
                result.append(String(output.split(separator: "\n")[n].split(separator: "\t")[0]))
            }
        }
        return result
    }
}
