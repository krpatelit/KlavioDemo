//
//  Storyboardable.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/12/22.
//

import Foundation
import UIKit
/// Storyboard Enum which take ViewController class name as genrics.
/// ViewController is the Genirc declaration.
enum Storyboardable<ViewController> {
    case main

    /// Variable which returns the storyboard name
    var storyboardName: String {
        switch self {
        case .main:
            return Constants.Storyboard.main
        }
    }

    /// Returns the ViewController identifier using the class name generic.
    var identifier: String {
        String(describing: ViewController.self)
    }

    /// Returns the instance of Viewcontroller from storyboard.
    var instantiate: ViewController {
        let storyboard = UIStoryboard(name: self.storyboardName, bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! ViewController
    }

    /// call the block with coder for the instance of Viewcontroller from storyboard.
    func instantiateViewController<ViewController>(_ creator: ((NSCoder) -> ViewController?)? = nil) -> ViewController where ViewController : UIViewController {
            let storyboard = UIStoryboard(name: self.storyboardName, bundle: .main)
            return storyboard.instantiateViewController(identifier: identifier, creator: creator)
    }
}

