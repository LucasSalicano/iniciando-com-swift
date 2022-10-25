import UIKit

class Alert {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(title: String, message: String, titleButton: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: titleButton, style: .cancel)
        
        alert.addAction(button)
        controller.present(alert, animated: true, completion: nil)
    }
}
