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

class DevicesRepository {
    var commandLine : CommandLine
    
    init(withCommandLine commandLine : CommandLine) {
        self.commandLine = commandLine
    }

    func getDevices() -> [String] {
        let result = commandLine.execute(arguments:[ "-l", "-c", "adb devices" ], readOutput: true)
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
