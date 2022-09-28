//
//  InstructionsManager.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 28.09.2022.
//

import AppKit

final class InstructionsManager: WindowPresentingManager<InstructionsViewController> {

    var onDone: Action?

    override func setup() {
        super.setup()
        window?.isMovable = true
        window?.isMovableByWindowBackground = true
        window?.collectionBehavior = .fullScreenAuxiliary.union(.canJoinAllSpaces)
    }

    override func showWindow() {
        guard let window = window else { return }
        let size = CGSize(width: 1, height: 1)
        let frame = CGRect(origin: .zero, size: size)
        window.setFrame(frame, display: true)
        window.center()

        controller?.onDone = { [weak self] in
            self?.hideWindow()
            self?.onDone?()
        }

        super.showWindow()
    }

    func showInstructions(_ instructions: [String]) {
        controller?.setInstructions(instructions)
        showWindow()
    }
}
