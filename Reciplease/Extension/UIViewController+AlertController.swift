//
//  UIViewController+AlertController`.swift
//  Reciplease
//
//  Created by mickael ruzel on 20/10/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(for vc: UIViewController, title: String?, message: String?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        ac.addAction(ok)
        
        vc.present(ac, animated: true, completion: nil)
    }
}
