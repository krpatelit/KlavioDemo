//
//  Coordinator.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import Foundation
import  UIKit

protocol Coordinator: AnyObject {
    var parent: Coordinator? { get set }
    var children: [Coordinator] { get set }
    func start()
    func childDidFinish(_ child: Coordinator?)
}

