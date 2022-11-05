//
//  UsersListCoordinator.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import Foundation
import RxSwift

class UsersListCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let viewModel = UsersListViewModel(userService: ApiService())
        let viewController = UsersListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)

        viewController.viewModel = viewModel


        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return Observable.never()
    }

}
