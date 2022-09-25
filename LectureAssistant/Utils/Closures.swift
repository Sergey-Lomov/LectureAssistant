//
//  Closures.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 23.09.2022.
//

import Foundation

typealias Action = () -> Void
typealias Handler<T> = (T) -> Void
typealias BoolHandler = Handler<Bool>
typealias StringHandler = Handler<String>
