//
//  KeyboardShortcuts.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 25.09.2022.
//

import Foundation

import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let scenarioNextStep = Self("scenarioNextStep", default: .init(.f2, modifiers: [.command, .shift]))
    static let scenarioPrevStep = Self("scenarioPrevStep", default: .init(.f1, modifiers: [.command, .shift]))
}
