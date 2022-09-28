//
//  WindowPresentingManager.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 24.09.2022.
//

import AppKit

class WindowPresentingManager<T> where T : NSViewController & NibInstantiable {

    var window: NSWindow?
    var controller: T? {
        window?.contentViewController as? T
    }
    var styleMask: NSWindow.StyleMask { .borderless }
    var presentingDuration = 0.5

    func setup() {
        let window = NSWindow(contentRect: .zero, styleMask: styleMask, backing: .buffered, defer: false)
        window.contentViewController = T.instantiate()
        window.viewsNeedDisplay = true
        window.level = .floating
        window.backgroundColor = .clear
        window.animationBehavior = .none

        self.window = window
    }

    func showWindow() {
        window?.alphaValue = 0
        window?.makeKeyAndOrderFront(self)
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = presentingDuration
            window?.animator().alphaValue = 1
        }, completionHandler: { [weak self] in
            self?.window?.invalidateShadow()
        })
    }

    func hideWindow() {
        NSAnimationContext.runAnimationGroup({ (context) -> Void in
            context.duration = presentingDuration
            window?.animator().alphaValue = 0
        }, completionHandler: {
            self.window?.orderOut(self)
        })
    }
}
