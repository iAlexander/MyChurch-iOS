//
//  TechnicalSupportVC.swift
//  MyChurch
//
//  Created by Taras Tanskiy on 14.07.2021.
//  Copyright © 2021 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class TechnicalSupportVC: UIViewController, UITextViewDelegate {
    
    let mainView = TechnicalSupportView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.tintColor = .white
        self.title = "Зворотний зв’язок"
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
}
