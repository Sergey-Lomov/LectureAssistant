//
//  ScenarioManager.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 22.09.2022.
//

import Foundation

class ScenarioManager {

    private var scenario: Scenario?
    private var currentStep: Int? {
        didSet {
            guard let step = currentStep else { return }
            handleStep(step)
        }
    }
    private var autorunTimer: Timer?

    var onHintSet: StringHandler?
    var onSplashShow: StringHandler?
    var onHintVisibilitySet: BoolHandler?
    var onEnvironmentSet: Handler<ActionsEnvironment?>?
    var onActionExecute: Handler<StepAction>?
    var onInstructionsShow: Handler<[String]>?

    func nextStep() {
        guard let scenario = scenario else { return }
        if let current = currentStep {
            currentStep = min(current + 1, scenario.steps.count - 1)
        } else {
            currentStep = 0
        }
    }

    func previousStep() {
        guard let current = currentStep else { return }
        currentStep = max(current - 1, 0)
    }

    func restart() {
        guard scenario != nil else { return }

        onEnvironmentSet?(scenario?.env)
        if let instructions = scenario?.instructions {
            onInstructionsShow?(instructions)
            currentStep = nil
        } else {
            currentStep = 0
        }
    }

    func loadScenario(_ url: URL) {
        do {
            let data = try Data(contentsOf: url)
            scenario = try JSONDecoder.snakeCaseDecoder.decode(Scenario.self, from: data)
            restart()
        } catch {
            print(error)
            scenario = nil
        }
    }

    private func handleStep(_ index: Int) {
        guard let step = scenario?.steps[index] else { return }
        autorunTimer?.invalidate()

        if let splash = step.splash { onSplashShow?(splash) }
        onHintSet?(step.hint ?? "")
        onHintVisibilitySet?(step.hint != nil)
        step.actions.forEach { onActionExecute?($0) }

        if let nextDelay = step.runNextAfter {
            autorunTimer = Timer.scheduledTimer(withTimeInterval: nextDelay, repeats: false) { [weak self] _ in
                self?.nextStep()
            }
        }
    }
}
