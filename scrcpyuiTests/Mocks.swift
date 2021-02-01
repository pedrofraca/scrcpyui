//
//  Mocks.swift
//  scrcpyuiTests
//
//  Created by Pedro Fraca on 31.01.21.
//  Copyright © 2021 Fraca, Pedro. All rights reserved.
//

import Foundation
@testable import scrcpyui

class MockStatusBar : StatusBarProtocol {
    
    var functionCalled = [String: Bool]()
    
    func hasBeenCalled(function: String) -> Bool {
        let result = functionCalled[function] ?? false
        if(!result) {
            debugPrint("👉🏾 We can't find \(function) but we've this in the stack")
            debugPrint(functionCalled)
        }
        return result
    }
    
    func setInformation(info: String) {
        functionCalled[#function] = true
    }
    
    func addItemToMenu(item: String, shortcut: String) {
        functionCalled[#function] = true
    }
    
    func clearInformation() {
        functionCalled[#function] = true
    }
    
    func clearList() {
        functionCalled[#function] = true
    }
}

class MockCommandLineScrcpy : CommandLine {
    func execute(launchPath: String, arguments: [String], readOutput: Bool) -> String {
        return ""
    }
}

//Mock version of the command line returning one entry from adb when executing adb devices
class MockCommandLine : CommandLine {
    func execute(launchPath: String, arguments: [String], readOutput: Bool) -> String {
        return "List of devices attached\nemulator-5554\tdevice\n\n"
    }
}

//Mock version of the command line returning empty list of devices from adb when executing adb devices
class MockCommandLineWithoutDevices : CommandLine {
    func execute(launchPath: String, arguments: [String], readOutput: Bool) -> String {
        return "List of devices attached"
    }
}
