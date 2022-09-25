//
//  String.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 22.09.2022.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
