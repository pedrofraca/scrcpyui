//
//  DevicesRepositoryTest.swift
//  scrcpyuiTests
//
//  Created by Pedro Fraca on 31.01.21.
//  Copyright © 2021 Fraca, Pedro. All rights reserved.
//

import XCTest
@testable import scrcpyui


class DevicesRepositoryTest: XCTestCase {

    func testDevicesReturnedProperly() {
        let repo = DevicesRepository(withCommandLine: MockCommandLine())
        XCTAssertEqual(["emulator-5554"], repo.getDevices())
    }
    
    func testNoDevicesAreReturnedIfNoDevicesConnected() {
        let repo = DevicesRepository(withCommandLine: MockCommandLineWithoutDevices())
        XCTAssertEqual([], repo.getDevices())
    }
}
