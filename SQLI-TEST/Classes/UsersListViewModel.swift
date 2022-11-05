//
//  UsersListViewModel.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import Foundation
import RxSwift

class UsersListViewModel {

    // MARK: - Inputs

    // MARK: - Outputs

    /// Emits an array of fetched users.
    let users: Observable<[UserViewModel]>

    /// Emits an error messages to be shown.
    let alertMessage: Observable<String>

    init(userService: Service) {

        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()

        self.users = Observable.just(())
            .flatMapLatest({
                userService.getUsers(byPage: 1)
                    .catch { error in
                        _alertMessage.onNext(error.localizedDescription)
                        return Observable.empty()
                    }
            }).map({ user in
                user.data.map(UserViewModel.init)
            })
    }
}
