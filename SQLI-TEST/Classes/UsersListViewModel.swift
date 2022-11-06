//
//  UsersListViewModel.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import RxSwift
import RxRelay

protocol UsersListViewModel: AnyObject {
    // Input
    var didScrollToTheBottom: PublishRelay<Void> { get }

    // Output
    var users: BehaviorRelay<[UserViewModel]> { get }
}

class UsersListViewModelImplementation: UsersListViewModel {

    // MARK: - Inputs

    let didScrollToTheBottom = PublishRelay<Void>()

    // MARK: - Outputs

    let users = BehaviorRelay<[UserViewModel]>(value: [])
    let alertMessage = PublishRelay<String>()

    // MARK: - Private properties
    private let pageNumber = BehaviorRelay<Int>(value: 1)
    private var totalPages: Int?
    private var userService: Service
    private let disposeBag = DisposeBag()

    init(userService: Service) {
        self.userService = userService
        bindPageNumber()
        bindOnDidScrollToBottom()
    }

    func getUsers() {
        if let totalPages = totalPages {
            guard pageNumber.value <= totalPages else {
                return
            }
        }
        userService.getUsers(byPage: pageNumber.value)
            .do(onNext: { response in
                self.totalPages = response.totalPages
            })
            .map({ response in
                return response.data.map(UserViewModel.init)
            })
            .flatMap({ [unowned self] (users) -> Observable<[UserViewModel]> in
                
                var usersArray: [UserViewModel] = []

                let existingUsers = self.users.value
                if !existingUsers.isEmpty {
                    usersArray.append(contentsOf: existingUsers)
                }

                usersArray.append(contentsOf: users)

                return Observable.just(usersArray)
            })

            .bind(to: users)
            .disposed(by: disposeBag)
    }

    private func bindPageNumber() {
        pageNumber
            .subscribe(onNext: { [weak self] _ in
                self?.getUsers()
            })
            .disposed(by: disposeBag)
    }

    private func bindOnDidScrollToBottom() {
        didScrollToTheBottom
            .flatMap({ [unowned self] _ -> Observable<Int> in
                let newPageNumber = self.pageNumber.value + 1
                return Observable.just(newPageNumber)
            })
            .bind(to: pageNumber)
            .disposed(by: disposeBag)
    }
}
