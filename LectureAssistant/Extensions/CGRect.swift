//
//  CGRect.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 24.09.2022.
//

import Foundation

extension CGRect {
    func centeredIn(_ size: CGSize) -> CGRect {
        let x = (size.width - width) / 2
        let y = (size.height - height) / 2
        return CGRect(x: x, y: y, width: width, height: height)
    }
}
