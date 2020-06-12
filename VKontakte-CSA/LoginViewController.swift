//
//  LoginViewController.swift
//  VKontakte-CSA
//
//  Created by Ирина Семячкина on 12.06.2020.
//  Copyright © 2020 Ирина Семячкина. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var scroll: UIScrollView?
    @IBOutlet private weak var logo: UIImageView?
    @IBOutlet private weak var loginTextField: UITextField? {
        didSet {
            loginTextField?.borderStyle = .none
            loginTextField?.clipsToBounds = true
            loginTextField?.layer.cornerRadius = 9
            loginTextField?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            loginTextField?.layer.borderWidth = 0.4
            loginTextField?.layer.borderColor = UIColor.lightGray.cgColor
            loginTextField?.placeholder = " Email или телефон"
        }
    }
    @IBOutlet private weak var passwordTextField: UITextField? {
        didSet {
            passwordTextField?.borderStyle = .none
            passwordTextField?.clipsToBounds = true
            passwordTextField?.layer.cornerRadius = 9
            passwordTextField?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            passwordTextField?.layer.borderWidth = 0.4
            passwordTextField?.layer.borderColor = UIColor.lightGray.cgColor
            passwordTextField?.placeholder = " Пароль"
        }
    }
    @IBOutlet private(set) weak var loginButton: UIButton? {
        didSet {
            loginButton?.titleLabel?.font = .boldSystemFont(ofSize: 20)
            loginButton?.setTitle("Войти", for: .normal)
            loginButton?.tintColor = .white
            loginButton?.backgroundColor = UIColor(red: 70 / 255, green: 128 / 255, blue: 194 / 255, alpha: 1)
            loginButton?.layer.cornerRadius = 9
        }
    }
    @IBOutlet private weak var forgotPasswordButton: UIButton? {
        didSet {
            forgotPasswordButton?.setTitle("Забыли пароль?", for: .normal)
            forgotPasswordButton?.tintColor = UIColor(red: 70 / 255, green: 128 / 255, blue: 194 / 255, alpha: 1)
            forgotPasswordButton?.titleLabel?.font = .boldSystemFont(ofSize: 17)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }


    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.addNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        self.addNotifications()
    }
    
    deinit {
        self.removeNotifications()
    }
    
    
    // MARK: - Notifications
    
    private func addNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWasShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo as NSDictionary? else {
            return
        }
        
        guard let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
            return
        }
        
        let keyboardHeight = keyboardFrame.cgRectValue.size.height
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: keyboardHeight,
                                         right: 0.0)
        
        self.scroll?.contentInset = contentInsets
        self.scroll?.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        
        let contentInsets = UIEdgeInsets.zero
        
        self.scroll?.contentInset = contentInsets
        self.scroll?.scrollIndicatorInsets = contentInsets
    }
    
    
    // MARK: - Actions
    
    @IBAction func loginButtonAction() {
        print("loginButtonAction")
    }
    
    
    @IBAction func forgotPasswordButtonAction() {
        print("forgotPasswordButtonAction")
    }
    
    
    @IBAction func closeKeyboardAction() {
        self.view.endEditing(true)
    }
}
