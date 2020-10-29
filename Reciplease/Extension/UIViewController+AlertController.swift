//
//  UIViewController+AlertController`.swift
//  Reciplease
//
//  Created by mickael ruzel on 20/10/2020.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAlertAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
