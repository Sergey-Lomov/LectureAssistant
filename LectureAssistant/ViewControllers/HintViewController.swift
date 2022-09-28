//
//  HintViewController.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 23.09.2022.
//

import AppKit

class HintViewController: NSViewController, NibInstantiable {

    static var nibName: String { "Hint" }

    @IBOutlet private var panel: NSView!
    @IBOutlet private var hintField: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        panel.applyInfoPanelStyle()
    }

    func setHint(_ hint: String) {
        hintField.stringValue = hint
    }
}
