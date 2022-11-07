//
//  Tools.swift
//  SQLI-TEST
//
//  Created by mohamed mernissi on 7/11/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok".localized, style: .default, handler: { _ in
        })
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
