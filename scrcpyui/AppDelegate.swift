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

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!
	let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		if let button = statusItem.button {
			button.image = NSImage(named: "Image")
			button.target = self
		}
        refreshDevices(nil)
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
	
    func shell(launchPath: String, arguments: [String], readOutput : Bool) -> String {
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

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}
	
    @objc func launchSrcpy(_ sender: Any?) {
		
        let cast = sender as! NSMenuItem
        _ = shell(launchPath:"/bin/bash",arguments:[ "-l", "-c", "scrcpy -s \(cast.title)" ], readOutput: false)
        print("\(cast.title)")
	}
    
    @objc func refreshDevices(_ sender: Any?) {
        
        let result = shell(launchPath:"/bin/bash",arguments:[ "-l", "-c", "adb devices" ], readOutput: true)
        
        let devicesList = parseDevicesFromAdbOutput(output: result)
        
        constructMenu(devices : devicesList)
    }
	
    
    func constructMenu(devices : [String]) {
		let menu = NSMenu()
        menu.removeAllItems()
        
        if(devices.isEmpty) {
            menu.addItem(NSMenuItem(title: "No devices detected", action: nil, keyEquivalent: ""))
        } else {
            var deviceNumber = 1
            for device in devices {
                menu.addItem(NSMenuItem(title: device, action: #selector(AppDelegate.launchSrcpy(_:)), keyEquivalent: String(deviceNumber)))
                deviceNumber+=1
            }
        }
		
		menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Refresh devices", action: #selector(AppDelegate.refreshDevices(_:)), keyEquivalent: "r"))
        
		menu.addItem(NSMenuItem(title: "Quit scrcpyui", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
		
		statusItem.menu = menu
	}


}

