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

//Constructor has to have the CommandLine integration and the adb integration
class ScrCpyViewModel {
    
    var repo : DevicesRepository
    var commandLine : CommandLine
    var statusBar : StatusBarProtocol
    
    init(withDevicesRepo repo : DevicesRepository, withCommandLine commandLine : CommandLine, toStatusBar statusBar : StatusBarProtocol) {
        self.repo = repo
        self.commandLine = commandLine
        self.statusBar = statusBar
    }
    
    //Steps to do here
    //1. Get always list of devices from adb. Update view in the meantime to tell user we're refreshing
    //2. Once list is received refresh the UI and tell user we're not refreshing anymore.
    func refresh() -> Void {
        statusBar.clearList()
        statusBar.setInformation(info: "Refreshing Devices")
        let devices = repo.getDevices()
        var deviceNumber = 1
        devices.forEach { device in
            statusBar.addItemToMenu(item: device, shortcut: String(deviceNumber))
            deviceNumber+=1
        }
        statusBar.setInformation(info: "\(devices.count) device(s) detected" )
        statusBar.addOptions()
    }
    
    //Method that will open the scrcpy tool with the device selected by the user
    func openScrcpy(forDevice device : String) -> Void {
        let _ = commandLine.execute(launchPath:"/bin/bash",arguments:[ "-l", "-c", "scrcpy -s \(device)" ], readOutput: false)
    }
}
