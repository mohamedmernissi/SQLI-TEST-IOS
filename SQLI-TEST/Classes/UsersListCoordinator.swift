//
//  UsersListCoordinator.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import Foundation
import UIKit

protocol UsersListCoordinator: AnyObject { }

class UsersListCoordinatorImplementation: Coordinator {
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = UsersListViewModelImplementation(userService: ApiService()
                                                         ,coordinator: self)
        let viewController = UsersListViewController()
        viewController.viewModel = viewModel
        navigationController
            .pushViewController(viewController, animated: true)
    }
}

extension UsersListCoordinatorImplementation: UsersListCoordinator {}
