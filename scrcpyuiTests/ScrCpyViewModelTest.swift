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
