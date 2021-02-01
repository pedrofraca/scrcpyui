//
//  scrcpyuiTests.swift
//  scrcpyuiTests
//
//  Created by Pedro Fraca on 31.01.21.
//  Copyright © 2021 Fraca, Pedro. All rights reserved.
//

import XCTest
@testable import scrcpyui

class ScrCpyViewModelTest: XCTestCase {

    //This test is going to check that with one item is the list we're calling to the right methods in the right order
    //
    func testScrCpyViewModel() {
        let statusBar = MockStatusBar()
    
        let viewModel = ScrCpyViewModel(withDevicesRepo: DevicesRepository(withCommandLine: MockCommandLine()), withCommandLine: MockCommandLine(), toStatusBar: statusBar)
        
        viewModel.refresh()
        XCTAssertTrue(statusBar.hasBeenCalled(function: "setInformation(info:)"))
        XCTAssertTrue(statusBar.hasBeenCalled(function: "addItemToMenu(item:shortcut:)"))
        
    }
}
