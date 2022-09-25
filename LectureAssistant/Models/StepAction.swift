//
//  StepAction.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 23.09.2022.
//

import Foundation

protocol StepActionParams: Decodable {
    func buildAction() -> StepAction
}

enum StepAction {
    case moveToCommit(id: String, repo: Int)
    case showXCodeSymbol(name: String)
    case activateApp(name: String)
}

struct EncodedStepActions: Decodable {

    let moveToCommit: MoveToCommitParams?
    let showXCodeSymbol: String?
    let activateApp: String?

    func toActions() -> [StepAction] {
        var actions = [StepAction]()

        if let params = moveToCommit {
            actions.append(params.buildAction())
        }

        if let symbol = showXCodeSymbol {
            actions.append(.showXCodeSymbol(name: symbol))
        }

        if let app = activateApp {
            actions.append(.activateApp(name: app))
        }

        return actions
    }
}

struct MoveToCommitParams: StepActionParams {
    let id: String
    let repo: Int?

    func buildAction() -> StepAction {
        .moveToCommit(id: id, repo: repo ?? 0)
    }
}
