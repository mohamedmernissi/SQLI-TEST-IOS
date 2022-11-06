//
//  AppCoordinator.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import UIKit
import RxSwift

class AppCoordinator: Coordinator {
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        if #available(iOS 13.0, *) {
            navigationController.overrideUserInterfaceStyle = .light
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let usersListCoordinator = UsersListCoordinatorImplementation(navigationController: navigationController)
        coordinate(to: usersListCoordinator)
    }
}
