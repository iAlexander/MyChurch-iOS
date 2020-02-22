// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

extension UIViewController {

    func addController(_ childController: UIViewController, at parentView: UIView? = nil) {
        childController.didMove(toParent: self)
        addChild(childController)
        guard let parentView = parentView != nil ? parentView! : view else { return }
        parentView.addSubview(childController.view)
    }

    func addControllers(_ childControllers: [UIViewController]) {
        for childController in childControllers {
            childController.didMove(toParent: self)
            addChild(childController)
            view.addSubview(childController.view)
        }
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
