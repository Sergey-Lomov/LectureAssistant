//
//  AppleScriptService.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 25.09.2022.
//

import Foundation

typealias AppleScriptCompletion = (Bool, String) -> Void

class AppleScriptService {

    static func execute(_ code: String, completion: AppleScriptCompletion? = nil) {
        BashService.execute(command: "osascript", with: ["-e", code], completion: completion)
    }

    static func execute(_ script: AppleScript, completion: AppleScriptCompletion? = nil) {
        execute(script.code, completion: completion)
    }
}
