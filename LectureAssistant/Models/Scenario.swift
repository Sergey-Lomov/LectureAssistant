//
//  Scenario.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 22.09.2022.
//

import Foundation

struct ScenarioStep: Decodable {
    let title: String?
    let hint: String?
    let splash: String?
    let actions: [StepAction]
    let runNextAfter: Double?

    enum CodingKeys: CodingKey {
        case title, hint, splash, actions, runNextAfter
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try? container.decode(String.self, forKey: .title)
        hint = try? container.decode(String.self, forKey: .hint)
        splash = try? container.decode(String.self, forKey: .splash)
        runNextAfter = try? container.decode(Double.self, forKey: .runNextAfter)

        let encodedActions = try? container.decode(EncodedStepActions.self, forKey: .actions)
        actions = encodedActions?.toActions() ?? []
    }
}

struct Scenario: Decodable {
    let title: String
    let steps: [ScenarioStep]
    let env: ActionsEnvironment?
}
