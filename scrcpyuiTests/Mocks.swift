/**
scrcpyui is a small project to provide UI access for macOS for the scrpcy (https://github.com/Genymobile/scrcpy) tool
Copyright (C) 2021 Pedro Fraca

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

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
    
    func addOptions() {
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
