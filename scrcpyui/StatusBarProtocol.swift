//
//  StatusBarProtocol.swift
//  scrcpyui
//
//  Created by Pedro Fraca on 31.01.21.
//  Copyright © 2021 Fraca, Pedro. All rights reserved.
//

import Foundation

protocol StatusBarProtocol {
    func setInformation(info : String) -> Void
    func addItemToMenu(item : String, shortcut : String) -> Void
    func addOptions() -> Void
    func clearList() -> Void
}
