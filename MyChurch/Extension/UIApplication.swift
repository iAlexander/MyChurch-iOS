//
//  UIApplication.swift
//  MyChurch
//
//  Created by Taras Tanskiy on 23.09.2021.
//  Copyright © 2021 Oleksandr Lohozinskyi. All rights reserved.
//

import Foundation

extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
