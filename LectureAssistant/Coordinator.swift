//
//  Coordinator.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 23.09.2022.
//

import Foundation
import AppKit

class Coordinator {

    private let hint = HintManager()
    private let splash = SplashMessageManager()
    private let instructions = InstructionsManager()
    private let scenario = ScenarioManager()
    private let actions = ActionsManager()

    func start() {
        hint.setup()
        splash.setup()
        instructions.setup()

        scenario.onHintVisibilitySet = { [weak self] visibility in
            self?.hint.setVisibility(visibility)
        }
        scenario.onHintSet = { [weak self] hint in
            self?.hint.setHint(hint)
        }
        scenario.onSplashShow = { [weak self] message in
            self?.splash.showMessage(message)
        }
        scenario.onEnvironmentSet = { [weak self] env in
            self?.actions.environment = env
        }
        scenario.onActionExecute = { [weak self] action in
            self?.actions.execute(action)
        }
        scenario.onInstructionsShow = { [weak self] strings in
            self?.instructions.showInstructions(strings)
            let testHint = "Test hint for panel positioning and resizing".localized
            self?.hint.setHint(testHint)
            self?.hint.setVisibility(true)
        }

        actions.onProblemReport = { [weak self] message in
            DispatchQueue.main.async {
                self?.showActionFailAlert(message)
            }
        }

        instructions.onDone = { [weak self] in
            self?.scenario.nextStep()
        }
    }

    func nextStep() {
        scenario.nextStep()
    }

    func previousStep() {
        scenario.previousStep()
    }

    func restart() {
        scenario.restart()
    }

    func disableActions() {
        actions.isEnabled = false
    }

    func enableActions() {
        actions.isEnabled = true
    }

    func loadScenario() {
        NSOpenPanel.runOpenJsonPanel {
            guard let url = $0.url else { return }
            scenario.loadScenario(url)
        }
    }

    func showExitDialog() {
        let alert = NSAlert()
        alert.messageText = "Are you really want to quit the assistant".localized
        alert.alertStyle = .critical
        alert.addButton(withTitle: "Cancel".localized)
        alert.addButton(withTitle: "Quit".localized)
        if alert.runModal() == .alertSecondButtonReturn {
            NSApplication.shared.terminate(self)
        }
    }

    func showActionFailAlert(_ message: String) {
        let alert = NSAlert()
        alert.messageText = "Action failed".localized
        alert.informativeText = message
        alert.alertStyle = .critical
        alert.addButton(withTitle: "Ok".localized)
        alert.runModal()
    }
}
