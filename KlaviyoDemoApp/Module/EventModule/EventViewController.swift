//
//  EventViewController.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import UIKit

class EventViewController: UIViewController {

    var viewModule: EventViewModeling?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func event1Pressed(button: UIButton) {

        let event = button.titleLabel?.text ?? "Test"
        self.viewModule?.buttonEvent(event: event)
        
    }
    
}
