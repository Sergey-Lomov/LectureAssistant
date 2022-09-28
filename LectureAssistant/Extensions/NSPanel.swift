//
//  NSPanel.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 28.09.2022.
//

import AppKit

extension NSView {

    func applyInfoPanelStyle() {
        wantsLayer = true
        layer?.cornerRadius = 10
        layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
    }
}
