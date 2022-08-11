//
//  UserProfileViewController.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var viewModele: UserProfileViewModeling?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModele?.updateUI = { [weak self] in
            self?.tblView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModele?.fetchList()
    }
}

extension UserProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModele?.eventList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let event = self.viewModele?.eventList[indexPath.row]
        cell.textLabel?.text = event?.event_name
        cell.detailTextLabel?.text = event?.datetime
        return cell
    }

}

