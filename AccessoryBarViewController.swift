//
//  AccessoryBarViewController.swift
//  AccessoryBarView
//
//  Created by Rafael Damasceno on 24/05/18.
//

import Foundation

import Foundation
import InputProgress


public protocol AccessoryDelegate: class {
    func accessoryDidContinue()
    func textFieldDidBeginEditing(_ selectedTextField: UITextField)
}

open class AccessoryBarViewController: UIViewController {



    private var hideAccessoryView: Bool = false
    open var accessoryView: UIToolbar?
    open var accessoryDelegate: AccessoryDelegate?
    open var inputProgress: InputProgress?
    open var buttomContinue = UIButton()

    open override func viewDidLoad() {
        setupAccessoryView()
        setupContinueButton()
    }

    private func setupAccessoryView() {
        accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 56))
        accessoryView?.isTranslucent = false
        accessoryView?.isOpaque = true
        accessoryView?.barTintColor = UIColor.lightGray
        let continueBarButton = UIBarButtonItem(customView: buttomContinue)
        accessoryView?.setItems([continueBarButton], animated: true)
    }

    private func setupContinueButton() {
        buttomContinue.addTarget(self, action: #selector(self.buttomContinueTouched(_:)), for: .touchUpInside)
        buttomContinue.setTitle("Continue", for: .normal)
        buttomContinue.contentHorizontalAlignment = .right
        buttomContinue.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        buttomContinue.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 56)
        buttomContinue.backgroundColor = .clear
    }

    open func setupProgressBar(presentedView: UIView, textFields: [UITextField], progress: CGFloat, shouldHideKeyboard: Bool = false, shouldHideAccessoryView: Bool = false, textFieldDelegate: UITextFieldDelegate) {
        textFields.forEach{
            $0.delegate = textFieldDelegate
            $0.inputAccessoryView = accessoryView
        }
        inputProgress = InputProgress(presentingView: presentedView, textFields: textFields)
        inputProgress?.progressBarColor = UIColor.green
        inputProgress?.progressBarHeight = 8.0
        inputProgress?.progress = progress
        inputProgress?.shouldDisplayBottomViewBar = true
        self.hideAccessoryView = shouldHideAccessoryView
        if shouldHideKeyboard {
            hideKeyboardWhenTappedAround()
        }
    }

    open func setButtomTitle(_ title: String) {
        buttomContinue.setTitle(title, for: .normal)
    }

    open override var canBecomeFirstResponder: Bool {
        return !hideAccessoryView
    }

    open override var inputAccessoryView: UIView {
        get {
            return self.accessoryView!
        }
    }

    // MARK: IBActions

    @objc func buttomContinueTouched(_ sender: UIButton) {
        accessoryDelegate?.accessoryDidContinue()
    }
}


public extension AccessoryBarViewController {

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =  UITapGestureRecognizer(target: self, action:  #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AccessoryBarViewController: UITextFieldDelegate {

    open func textFieldDidBeginEditing(_ textField: UITextField) {
        accessoryDelegate?.textFieldDidBeginEditing(textField)
    }
}
