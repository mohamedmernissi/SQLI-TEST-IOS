//
//  BaseCoordinator.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import RxSwift
import Foundation

protocol Coordinator: AnyObject {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
