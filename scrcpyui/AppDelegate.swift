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
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate, StatusBarProtocol {
    
	@IBOutlet weak var window: NSWindow!
	let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    var presenter : ScrCpyPresenter!
    let menu = NSMenu()
    
	func applicationDidFinishLaunching(_ aNotification: Notification) {
        
		if let button = statusItem.button {
			button.image = NSImage(named: "Image")
			button.target = self
		}
        
        let commandLine = BashCommandLine()
        
        presenter = ScrCpyPresenter(withDevicesRepo: DevicesRepository(withCommandLine: commandLine), withCommandLine: commandLine, toStatusBar: self)
        
        presenter.refresh()
        
        menu.delegate = self
        statusItem.menu = menu
	}
    
    func menuWillOpen(_ menu: NSMenu) {
        presenter.refresh()
    }
    
    func setInformation(info: String) {
        if(menu.items.count==0) {
            menu.addItem(NSMenuItem(title: info, action: nil, keyEquivalent: ""))
        } else {
            menu.item(at: 0)?.title = info
        }
    }
    
    func addItemToMenu(item: String, shortcut: String) {
        menu.addItem(NSMenuItem(title: item, action: #selector(AppDelegate.launchSrcpy(_:)), keyEquivalent: shortcut))
    }
    
    func addExtraOptions() {
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Refresh devices", action: #selector(AppDelegate.refreshDevices(_:)), keyEquivalent: "r"))
        menu.addItem(NSMenuItem(title: "Quit scrcpyui", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    }
    
    func clearList() {
        menu.removeAllItems()
    }
    
    @objc func launchSrcpy(_ sender: Any?) {
        let cast = sender as! NSMenuItem
        presenter.openScrcpy(forDevice: cast.title)
	}
    
    @objc func refreshDevices(_ sender: Any?) {
        presenter.refresh()
    }

}

