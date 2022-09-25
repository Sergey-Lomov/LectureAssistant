//
//  JSONDecoder.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 23.09.2022.
//

import Foundation

extension JSONDecoder {
    
    static let snakeCaseDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
