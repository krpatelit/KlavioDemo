//
//  EventViewController.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import UIKit

struct EventInfo {
    let event: String
    let item: String
    let value: Int
}

class EventViewController: UIViewController {

    var viewModule: EventViewModeling?
    @IBOutlet weak var tfEvent1: UITextField!
    @IBOutlet weak var tfItem1: UITextField!
    @IBOutlet weak var tfPrice1: UITextField!

    @IBOutlet weak var tfEvent2: UITextField!
    @IBOutlet weak var tfItem2: UITextField!
    @IBOutlet weak var tfPrice2: UITextField!

    @IBOutlet weak var lblEmail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblEmail.text = Global.user.emailId
    }

    @IBAction func event1Pressed(button: UIButton) {

        let event = tfEvent1.text ?? ""
        let item = tfItem1.text ?? ""
        let price = Int(tfPrice1.text ?? "") ?? -1
        guard !event.isEmpty, !item.isEmpty, price > 0 else {
            //Show Error here
            return
        }
        let eventInfo = EventInfo(event: event, item: item, value: price)
        self.viewModule?.postEvent(event: eventInfo)
    }

    @IBAction func event2Pressed(button: UIButton) {
        let event = tfEvent2.text ?? ""
        let item = tfItem2.text ?? ""
        let price = Int(tfPrice2.text ?? "") ?? -1
        guard !event.isEmpty, !item.isEmpty, price > 0 else {
            //Show Error here
            return
        }
        let eventInfo = EventInfo(event: event, item: item, value: price)
        self.viewModule?.postEvent(event: eventInfo)
    }

    @IBAction func updateProfile(button: UIButton) {
        self.showInputDialog(title: "Update Email Id",
                             subtitle: "",
                             textValue: Global.user.emailId,
                             actionHandler:  { text in
            Global.user.emailId = text ?? ""
            Global.user.userId = ""
            self.lblEmail.text = Global.user.emailId
        })
    }
}

extension EventViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
