//
//  UserProfileViewController.swift
//  KlaviyoDemoApp
//
//  Created by Kiran Patel on 8/10/22.
//

import UIKit
import Combine

class UserProfileViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var viewModele: UserProfileViewModeling?
    var isDataLoaded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModele?.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.tblView.reloadData()
            }
        }
        self.viewModele?.loadMoreData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(profileChange),
                                               name: .profileChange,
                                               object: nil)


    }

    @objc func profileChange() {
        self.isDataLoaded = false
        self.viewModele?.resetData()
        self.viewModele?.loadMoreData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isDataLoaded {
            self.viewModele?.loadNewData()
        }
        isDataLoaded = true
    }
}

extension UserProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModele?.eventList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")

        let event = self.viewModele?.eventList[indexPath.row]
        cell.textLabel?.text = event?.event_name
        cell.detailTextLabel?.text = event?.datetime


        let count = self.viewModele?.eventList.count ?? 0
        if count - 3 == indexPath.row {
            self.viewModele?.loadMoreData()
        }

        return cell
    }
}

