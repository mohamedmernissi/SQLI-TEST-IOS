//
//  UsersService.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol Service {
    func getUsers(byPage page: Int) -> Observable<User>
}

enum ServiceError: Error {
    case cannotParse
}

class ApiService: Service {

    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func getUsers(byPage page: Int) -> Observable<User> {
        let urlRequest = URLRequest(url: URL(string: "https://reqres.in/api/users?page=\(page)")!)
        return session.rx
            .data(request: urlRequest)
            .flatMap { data throws -> Observable<User> in
                guard
                    let decodedResponse = try? JSONDecoder().decode(User.self, from: data)
                else { return Observable.error(ServiceError.cannotParse) }

                return Observable.just(decodedResponse)
            }
    }
}
