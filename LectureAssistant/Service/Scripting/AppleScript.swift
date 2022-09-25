//
//  AppleScript.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 25.09.2022.
//

import Foundation

class AppleScript {

    let code: String

    init(_ code: String) {
        self.code = code
    }

    static func showXCodeSymbol(_ symbol: String) -> AppleScript {
        .init("""
        activate application "Xcode"
        tell application "System Events"
            keystroke "o" using {shift down, command down}
            keystroke "\(symbol)"
            delay 0.5
            key code 36
        end tell
        """)
    }

    static func activateApp(_ app: String) -> AppleScript {
        .init("activate application \"\(app)\"")
    }
}
