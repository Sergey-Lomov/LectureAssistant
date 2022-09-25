//
//  NibInstantiable.swift
//  LectureAssistant
//
//  Created by serhii.lomov on 24.09.2022.
//

import AppKit

protocol NibInstantiable {
    static var nibName : String { get }
}

extension NibInstantiable where Self : NSViewController {

    static func instantiate() -> Self {
        let storyboard = NSStoryboard(name: nibName, bundle: nil)
        let instance = storyboard.instantiateInitialController()
        guard let instance = instance as? Self else {
            fatalError("Can't instantiate \(Self.self) from storyboard named \(nibName)")
        }
        return instance
    }

}
