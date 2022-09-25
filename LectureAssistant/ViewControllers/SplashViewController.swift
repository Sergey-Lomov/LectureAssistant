//
//  SplashViewController.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 24.09.2022.
//

import AppKit

class SplashViewController: NSViewController, NibInstantiable {

    static var nibName: String { "Splash" }

    @IBOutlet private var panel: NSView?
    @IBOutlet private var messageField: NSTextField?

    override func viewDidLoad() {
        panel?.wantsLayer = true
        panel?.layer?.cornerRadius = 30
        panel?.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.85).cgColor
    }

    func setMessage(_ message: String) {
        messageField?.stringValue = message
    }
}
