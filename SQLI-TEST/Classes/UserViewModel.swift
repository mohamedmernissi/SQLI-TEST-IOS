//
//  UserModelView.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 5/11/2022.
//

import Foundation

struct UserViewModel {
    let fullName: String
    let avatar: URL?
    let email: String

    init(user: UserData) {
        self.fullName = "\(user.firstName) \(user.lastName)"
        self.avatar = URL(string: user.avatar)
        self.email = user.email
    }
}
