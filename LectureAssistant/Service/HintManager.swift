//
//  HintManager.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 23.09.2022.
//

import AppKit

final class HintManager: WindowPresentingManager<HintViewController> {

    override var styleMask: NSWindow.StyleMask { .resizable }

    override func setup() {
        super.setup()
        window?.isMovable = true
        window?.isMovableByWindowBackground = true
        window?.hasShadow = true
        window?.center()
        window?.collectionBehavior = .fullScreenAuxiliary.union(.canJoinAllSpaces)
    }

    func setHint(_ hint: String) {
        controller?.setHint(hint)
    }

    func setVisibility(_ visibility: Bool) {
        if visibility {
            showWindow()
        } else {
            hideWindow()
        }
    }
}
