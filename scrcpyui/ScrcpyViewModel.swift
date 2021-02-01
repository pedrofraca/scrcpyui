//
//  ScrcpyViewModel.swift
//  scrcpyui
//
//  Created by Pedro Fraca on 31.01.21.
//  Copyright © 2021 Fraca, Pedro. All rights reserved.
//

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
        statusBar.setInformation(info: "\(devices.count) devices detected" )
        statusBar.addOptions()
    }
    
    //Method that will open the scrcpy tool with the device selected by the user
    func openScrcpy(forDevice device : String) -> Void {
        let _ = commandLine.execute(launchPath:"/bin/bash",arguments:[ "-l", "-c", "scrcpy -s \(device)" ], readOutput: false)
    }
}
