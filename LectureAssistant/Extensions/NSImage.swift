//
//  NSImage.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 22.09.2022.
//

import AppKit

extension NSImage {
    convenience init? (systemSymbolName: String) {
        self.init(systemSymbolName: systemSymbolName, accessibilityDescription: nil)
    }
}
