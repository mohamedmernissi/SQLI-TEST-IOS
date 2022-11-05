//
//  AppCoordinator.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let usersListCoordinator = UsersListCoordinator(window: window)
        return coordinate(to: usersListCoordinator)
    }
}
