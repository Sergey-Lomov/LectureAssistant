//
//  ActionsManager.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 23.09.2022.
//

import Foundation

class ActionsManager {

    var environment: ActionsEnvironment?
    var isEnabled = true
    var onProblemReport: StringHandler?

    func execute(_ action: StepAction) {
        guard isEnabled else { return }
        switch action {
        case .moveToCommit(let id, let repo):
            moveToCommit(id, repoIndex: repo)
        case .showXCodeSymbol(let name):
            showXCodeSymbol(name)
        case .activateApp(let name):
            activateApp(name)
        case .showNextPreview:
            showNextPreview()
        }
    }

    private func moveToCommit(_ id: String, repoIndex: Int) {
        guard let repos = environment?.gitRepos else {
            print("Environment or repositories list missed")
            return
        }

        let repoPath = repos[repoIndex]
        BashService.execute(command: "git", dir: repoPath, with: ["checkout", id, "-f"]) { [weak self] success, output in
            guard !success else { return }
            let message = "Fail to switch to commit \(id) in repo '\(repoPath)'. Details: \(output)"
            self?.onProblemReport?(message)
        }
    }

    private func showXCodeSymbol(_ name: String) {
        AppleScriptService.execute(.showXCodeSymbol(name)) { [weak self] success, output in
            guard !success else { return }
            let message = "Fail to show XCode symbol \(name). Details: \(output)"
            self?.onProblemReport?(message)
        }
    }

    private func activateApp(_ name: String) {
        AppleScriptService.execute(.activateApp(name)) { [weak self] success, output in
            guard !success else { return }
            let message = "Fail to activate app \(name). Details: \(output)"
            self?.onProblemReport?(message)
        }
    }

    private func showNextPreview() {
        AppleScriptService.execute(.showNextPreview()) { [weak self] success, output in
            guard !success else { return }
            let message = "Fail to show next preview. Details: \(output)"
            self?.onProblemReport?(message)
        }
    }
}
