//
//  SplashMessageManager.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 24.09.2022.
//

import AppKit

final class SplashMessageManager: WindowPresentingManager<SplashViewController> {

    private let durationPerChar: TimeInterval = 0.1
    private let durationDelay: TimeInterval = 2
    private var timer: Timer?

    override func setup() {
        super.setup()
        window?.collectionBehavior = .canJoinAllSpaces
    }

    override func showWindow() {
        guard let window = window, let screen = NSScreen.main?.frame else { return }
        let frame = CGRect(origin: .zero, size: screen.size)
        window.setFrame(frame, display: true)

        super.showWindow()
    }

    func showMessage(_ message: String) {
        controller?.setMessage(message)
        showWindow()

        timer?.invalidate()
        let interval = durationPerChar * Double(message.count) + durationDelay
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { [weak self] _ in
                DispatchQueue.main.async {
                    self?.hideWindow()
                    self?.timer = nil
                }
        }
    }

//    func setVisibility(_ visibility: Bool) {
//        if visibility {
//            hintWindow?.makeKeyAndOrderFront(NSApp)
//        } else {
//            hintWindow?.orderOut(self)
//        }
//    }
}
