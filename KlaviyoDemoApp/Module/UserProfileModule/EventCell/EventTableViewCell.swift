//
//  EventTableViewCell.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/11/22.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblItem: UILabel!
    @IBOutlet weak var lblItemValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(event: EventCellViewModel) {
        self.lblEvent.text = event.event
        self.lblDate.text = event.date
        let itemNane = event.item ?? ""
        let price = event.price ?? ""
        if !itemNane.isEmpty {
            self.lblItem.text = "Item:"
            self.lblItemValue.text = itemNane + " - " + price
        } else {
            self.lblItem.text = ""
            self.lblItemValue.text = ""
        }
    }
    
}
