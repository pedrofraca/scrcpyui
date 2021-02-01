//
//  CommanLineProtocol.swift
//  scrcpyui
//
//  Created by Pedro Fraca on 31.01.21.
//  Copyright © 2021 Fraca, Pedro. All rights reserved.
//

import Foundation

protocol CommandLine {
    func execute(launchPath: String, arguments: [String], readOutput : Bool) -> String
}
