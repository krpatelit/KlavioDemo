//
//  ViewController.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/9/22.
//

import UIKit

class ViewController: UIViewController, UINavigationBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.navigationController?.navigationBar.delegate = self
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

}

