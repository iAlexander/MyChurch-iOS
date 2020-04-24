//
//  BelieverView.swift
//  MyChurch
//
//  Created by Zhekon on 25.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class BelieverView: UIView {
    
    let scrollView = UIScrollView()
    private let nameLabel = UILabel()
    let nameTextField = UITextField()
    private let nameGrayLine = UIView()
    private let serNameLabel = UILabel()
    let serNameTextField = UITextField()
    private let serNameGrayLine = UIView()
    private let birthdayLabel = UILabel()
    let birthdayDate = UIDatePicker()
    private let numberPhoneLabel = UILabel()
    let phoneTextField = UITextField()
    private let phoneGrayLine = UIView()
    private let emailLabel = UILabel()
    let emailTextField = UITextField()
    private let emailGrayLine = UIView()
    private let statusTextLabel = UILabel()
    let chooseStatusButton = UIButton()
    private let statusBackView = UIView()
    let statusLabel = UILabel()
    private let arrowImage = UIImageView()
    let believerButton = UIButton()
    let believerLabel = UILabel()
    let chlenParafRaduButton = UIButton()
    let chlenParafRaduLabel = UILabel()
    let hramLabel = UILabel()
    
    let chooseHramButton = UIButton()
    private let hramBackView = UIView()
    let hramLabelButton = UILabel()
    private let hramArrowImage = UIImageView()
    
    private let eparhiyaTitle = UILabel()
    private let eparhiyaBackView = UIView()
    let eparhiyaLabel = UILabel()
    private let eparhiyaImage = UIImageView()
    let eparhiyaButton = UIButton()
    
    let saveButton = UIButton()
    let saveLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.keyboardDismissMode = .onDrag

        scrollView.addSubview(nameLabel)
        nameLabel.text = "Ім’я"
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        scrollView.addSubview(nameTextField)
        nameTextField.autocorrectionType = .no
        
        scrollView.addSubview(nameGrayLine)
        nameGrayLine.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        scrollView.addSubview(serNameLabel)
        serNameLabel.text = "Прiзвище"
        serNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        serNameLabel.textAlignment = .left
        serNameLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        scrollView.addSubview(serNameTextField)
        serNameTextField.autocorrectionType = .no

        scrollView.addSubview(serNameGrayLine)
        serNameGrayLine.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        scrollView.addSubview(birthdayLabel)
        birthdayLabel.text = "День Народження"
        birthdayLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        birthdayLabel.textAlignment = .left
        birthdayLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        scrollView.addSubview(birthdayDate)
        birthdayDate.datePickerMode = .date
        birthdayDate.locale = Locale(identifier: "uk")
        
        scrollView.addSubview(numberPhoneLabel)
        numberPhoneLabel.text = "Номер телефону"
        numberPhoneLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        numberPhoneLabel.textAlignment = .left
        numberPhoneLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        scrollView.addSubview(phoneTextField)
        phoneTextField.keyboardType = .numberPad
        phoneTextField.placeholder = "Введiть номер у форматi 380..."
        
        scrollView.addSubview(phoneGrayLine)
        phoneGrayLine.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        scrollView.addSubview(emailLabel)
        emailLabel.text = "Ел. пошта"
        emailLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        emailLabel.textAlignment = .left
        emailLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        scrollView.addSubview(emailTextField)
        emailTextField.placeholder = "Введiть email латиницею..."
        emailTextField.autocorrectionType = .no

        scrollView.addSubview(emailGrayLine)
        emailGrayLine.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        scrollView.addSubview(statusTextLabel)
        statusTextLabel.text = "Статус"
        statusTextLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusTextLabel.textAlignment = .left
        statusTextLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        scrollView.addSubview(statusBackView)
        statusBackView.layer.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1).cgColor
        statusBackView.layer.cornerRadius = 10
        
        statusBackView.addSubview(statusLabel)
        statusLabel.text = "Вірянин"
        statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        statusLabel.textAlignment = .left
        statusLabel.textColor = .black
        
        statusBackView.addSubview(arrowImage)
        arrowImage.image = UIImage(named: "downArrow")
        arrowImage.contentMode = .scaleAspectFill
        
        statusBackView.addSubview(chooseStatusButton)
        
        scrollView.addSubview(hramBackView)
        hramBackView.layer.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1).cgColor
        hramBackView.layer.cornerRadius = 10
        
        hramBackView.addSubview(hramLabelButton)
        hramLabelButton.text = "Оберіть свій Храм"
        hramLabelButton.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        hramLabelButton.textAlignment = .left
        hramLabelButton.textColor = .black
        
        hramBackView.addSubview(hramArrowImage)
        hramArrowImage.image = UIImage(named: "searchIcon")
        hramArrowImage.contentMode = .scaleAspectFill
        
        hramBackView.addSubview(chooseHramButton)
        
        scrollView.addSubview(believerButton)
        believerButton.layer.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1).cgColor
        statusBackView.layer.cornerRadius = 10
        
        believerButton.addSubview(believerLabel)
        believerLabel.text = "Вірянин"
        believerLabel.textAlignment = .center
        believerLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        scrollView.addSubview(chlenParafRaduButton)
        chlenParafRaduButton.layer.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1).cgColor
        chlenParafRaduButton.layer.cornerRadius = 10
        
        chlenParafRaduButton.addSubview(chlenParafRaduLabel)
        chlenParafRaduLabel.text = "Член парафіяльної ради"
        chlenParafRaduLabel.textAlignment = .center
        chlenParafRaduLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        scrollView.addSubview(hramLabel)
        hramLabel.text = "Храм"
        hramLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        hramLabel.textAlignment = .left
        hramLabel.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        scrollView.addSubview(eparhiyaTitle)
        eparhiyaTitle.text = "Єпархія"
        eparhiyaTitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        eparhiyaTitle.textAlignment = .left
        eparhiyaTitle.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        
        scrollView.addSubview(eparhiyaBackView)
        eparhiyaBackView.layer.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1).cgColor
        eparhiyaBackView.layer.cornerRadius = 10
        
        eparhiyaBackView.addSubview(eparhiyaLabel)
        eparhiyaLabel.text = "Оберіть свою єпархію"
        eparhiyaLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        eparhiyaLabel.textAlignment = .left
        eparhiyaLabel.textColor = .black
        
        eparhiyaBackView.addSubview(eparhiyaImage)
        eparhiyaImage.image = UIImage(named: "searchIcon")
        eparhiyaImage.contentMode = .scaleAspectFill
        
        eparhiyaBackView.addSubview(eparhiyaButton)
        
        scrollView.addSubview(saveButton)
        saveButton.backgroundColor = UIColor(red: 0.878, green: 0.878, blue: 0.878, alpha: 1)
        
        saveButton.addSubview(saveLabel)
        saveLabel.text = "Зареєструватися"
        saveLabel.textAlignment = .center
        saveLabel.textColor = .white
        saveLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let currentWidth = UIScreen.main.bounds.size.width
        scrollView.pin.all()
        nameLabel.pin.top(35).horizontally(15).height(20)
        nameTextField.pin.below(of: nameLabel).marginTop(5).horizontally(15).height(20)
        nameGrayLine.pin.below(of: nameTextField).horizontally(15).height(1.5)
        serNameLabel.pin.below(of: nameGrayLine).horizontally(15).height(20).marginTop(30)
        serNameTextField.pin.below(of: serNameLabel).marginTop(5).horizontally(15).height(20)
        serNameGrayLine.pin.below(of: serNameTextField).horizontally(15).height(1.5)
        birthdayLabel.pin.below(of: serNameGrayLine).horizontally(15).height(20).marginTop(30)
        birthdayDate.pin.below(of: birthdayLabel).marginTop(10).horizontally(0).height(175)
        numberPhoneLabel.pin.below(of: birthdayDate).horizontally(15).height(20).marginTop(30)
        phoneTextField.pin.below(of: numberPhoneLabel).marginTop(5).horizontally(15).height(20)
        phoneGrayLine.pin.below(of: phoneTextField).horizontally(15).height(1.5)
        emailLabel.pin.below(of: phoneGrayLine).horizontally(15).height(20).marginTop(40)
        emailTextField.pin.below(of: emailLabel).marginTop(5).horizontally(15).height(20)
        emailGrayLine.pin.below(of: emailTextField).horizontally(15).height(1.5)
        statusTextLabel.pin.below(of: emailGrayLine).horizontally(15).height(20).marginTop(30)
        
        statusBackView.pin.below(of: statusTextLabel).marginTop(5).horizontally(15).height(50)
        chooseStatusButton.pin.all()
        statusLabel.pin.left(15).vertically(13).right(75)
        arrowImage.pin.right(15).vertically(20).width(16)
        
        believerButton.pin.below(of: statusBackView).horizontally(15).height(40).marginTop(5)
        believerLabel.pin.all()
        chlenParafRaduButton.pin.below(of: believerButton).marginTop(5).horizontally(15).height(40)
        chlenParafRaduLabel.pin.all()
        hramLabel.pin.below(of: statusBackView).horizontally(15).height(20).marginTop(30)
        
        hramBackView.pin.below(of: hramLabel).marginTop(5).horizontally(15).height(50)
        chooseHramButton.pin.all()
        hramLabelButton.pin.left(15).vertically(13).right(75)
        hramArrowImage.pin.right(15).vertically(15).width(20)
        
        eparhiyaTitle.pin.below(of: hramBackView).horizontally(15).height(20).marginTop(30)
        eparhiyaBackView.pin.below(of: eparhiyaTitle).marginTop(5).horizontally(15).height(50)
        eparhiyaLabel.pin.left(15).vertically(13).right(75)
        eparhiyaImage.pin.right(15).vertically(15).width(20)
        eparhiyaButton.pin.all()
        
        saveButton.pin.below(of: eparhiyaBackView).marginTop(35).horizontally().height(45)
        saveLabel.pin.all()
        scrollView.contentSize = CGSize(width: currentWidth, height: saveButton.frame.maxY + 113)
    }
}
