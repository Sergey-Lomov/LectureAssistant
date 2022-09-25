//
//  BashService.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 23.09.2022.
//

import Foundation

typealias BashCompletion = (Bool, String) -> Void

class BashService {
    static func execute(command: String, dir: String? = nil, with arguments: [String] = [], completion: BashCompletion? = nil) {
        var fullArguments: [String] = .init(arguments)
        fullArguments.insert(command, at: 0)
        execute(path: "/usr/bin/env", dir: dir, with: fullArguments, completion: completion)
    }

    static func execute(path: String, dir: String? = nil, with arguments: [String] = [], completion: BashCompletion? = nil) {
        let process = Process()
        process.launchPath = path
        process.arguments = arguments
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = outputPipe

        if let dir = dir {
            process.currentDirectoryPath = dir
        }

        process.terminationHandler = {
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let output = String(decoding: outputData, as: UTF8.self)
            completion?($0.terminationStatus == 0, output)
        }

        do {
            try process.run()
        } catch {
            completion?(false, "\(error)")
        }
    }
}
