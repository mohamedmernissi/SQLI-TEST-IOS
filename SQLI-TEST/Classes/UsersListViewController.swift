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
        return tableView
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
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
            .bind(to: tableView.rx.items(cellIdentifier: CELL_IDENTIFIER, cellType: UserCell.self)) { (_, user, cell) in
                cell.setupViews()
                cell.bind(user: user)
            }
            .disposed(by: disposeBag)

        tableView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.tableView.contentOffset.y
            let contentHeight = self.tableView.contentSize.height

            if offSetY > (contentHeight - self.tableView.frame.size.height - 100) {
                self.viewModel.didScrollToTheBottom.accept(())
            }
        }
        .disposed(by: disposeBag)

    }

    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}
