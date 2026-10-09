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

class ShCommandLine : CommandLine {
    
    func execute(arguments: [String], readOutput: Bool) -> String {
        let task = Process()
        let fileManager = FileManager.default
        let zshrcPath = ("~/.zshrc" as NSString).expandingTildeInPath
        let defaultShell = fileManager.fileExists(atPath: zshrcPath) ? "/bin/zsh" : "/bin/bash"
        let requestedShell = ProcessInfo.processInfo.environment["SHELL"] ?? defaultShell
        let requestedShellName = URL(fileURLWithPath: requestedShell).lastPathComponent
        let isSupportedShell = requestedShellName == "zsh" || requestedShellName == "bash"
        let shellPath = isSupportedShell && fileManager.isExecutableFile(atPath: requestedShell)
            ? requestedShell : "/bin/bash"
        let shellConfig = URL(fileURLWithPath: shellPath).lastPathComponent == "zsh" ? ".zshrc" : ".bashrc"
        task.launchPath = shellPath
        var commandArguments = arguments

        if arguments.count >= 3 && arguments[0] == "-l" && arguments[1] == "-c" {
            commandArguments[2] = "if [ -r \"$HOME/\(shellConfig)\" ]; then source \"$HOME/\(shellConfig)\" >/dev/null 2>&1; fi; " + arguments[2]
        }
        task.arguments = commandArguments
        
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
    
}
