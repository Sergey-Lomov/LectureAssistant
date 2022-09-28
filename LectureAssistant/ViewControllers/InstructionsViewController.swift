//
//  InstructionsViewController.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 28.09.2022.
//

import AppKit

class InstructionsViewController: NSViewController, NibInstantiable {

    static var nibName: String { "Instructions" }

    @IBOutlet private var panel: NSView!
    @IBOutlet private var instructionsLabel: NSTextField!

    var onDone: Action?

    override func viewDidLoad() {
        super.viewDidLoad()
        panel.applyInfoPanelStyle()
        panel.layer?.borderColor = NSColor.lightGray.cgColor
        panel.layer?.borderWidth = 2
    }

    func setInstructions(_ instructions: [String]) {
        instructionsLabel.stringValue = instructions.joined(separator: "\n")
    }

    @IBAction func onDoneTapped(_ sender: NSButton) {
        onDone?()
    }
}
