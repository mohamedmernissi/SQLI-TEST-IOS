//
//  UsersListViewController.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import UIKit
import SnapKit
import RxSwift

class UsersListViewController: UIViewController {

    private let CELL_IDENTIFIER = "UserCell"
    
    var viewModel: UsersListViewModel!
    private let disposeBag = DisposeBag()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
        setupBindings()
    }

    private func setUpViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupBindings() {

        // View Model outputs to the View Controller

        viewModel.users
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: CELL_IDENTIFIER, cellType: UserCell.self)) { (_, user, cell) in
                cell.setupViews()
                cell.bind(user: user)
            }
            .disposed(by: disposeBag)

        viewModel.alertMessage
            .subscribe(onNext: { [weak self] in self?.presentAlert(message: $0) })
            .disposed(by: disposeBag)
    }

    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
