//
//  AppDelegate.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 22.09.2022.
//

import Cocoa
import KeyboardShortcuts

@main
struct Application {
    static let appDelegate = AppDelegate()

    static func main() {
        NSApplication.shared.setActivationPolicy(.regular)
        NSApp.delegate = appDelegate
        NSApp.activate(ignoringOtherApps: true)
        NSApp.setActivationPolicy(.accessory)
        NSApp.run()
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {

    private let keyHandlingDelay = 0.5

    var coordinator = Coordinator()
    var statusBarItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let barItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        barItem.button?.image = NSImage(systemSymbolName: "paperclip")

        let barMenu = NSMenu(title: "Status Bar Menu")
        barMenu.addItem(withTitle: "Next step".localized, action: #selector(nextStep), keyEquivalent: "")
        barMenu.addItem(withTitle: "Previous step".localized, action: #selector(previousStep), keyEquivalent: "")
        barMenu.addItem(withTitle: "Restart".localized, action: #selector(restart), keyEquivalent: "")
        barMenu.addItem(.separator())
        barMenu.addItem(withTitle: "Disable actions".localized, action: #selector(disableActions), keyEquivalent: "")
        barMenu.addItem(withTitle: "Enable actions".localized, action: #selector(enableActions), keyEquivalent: "")
        barMenu.addItem(withTitle: "Load scenario".localized, action: #selector(loadScenario), keyEquivalent: "")
        barMenu.addItem(.separator())
        barMenu.addItem(withTitle: "Quit".localized, action: #selector(quit), keyEquivalent: "")

        barItem.menu = barMenu
        statusBarItem = barItem

        KeyboardShortcuts.onKeyUp(for: .scenarioNextStep) { [self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + keyHandlingDelay) {
                self.nextStep()
            }
        }

        KeyboardShortcuts.onKeyUp(for: .scenarioPrevStep) { [self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + keyHandlingDelay) {
                self.previousStep()
            }
        }

        coordinator.start()
    }

    @objc func nextStep() {
        coordinator.nextStep()
    }

    @objc func previousStep() {
        coordinator.previousStep()
    }

    @objc func restart() {
        coordinator.restart()
    }

    @objc func disableActions() {
        coordinator.disableActions()
    }

    @objc func enableActions() {
        coordinator.enableActions()
    }

    @objc func loadScenario() {
        coordinator.loadScenario()
    }

    @objc func quit() {
        coordinator.showExitDialog()
    }
}
