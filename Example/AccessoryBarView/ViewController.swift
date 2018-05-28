//
//  AccessoryBarViewController.swift
//  PJ-Utils
//
//  Created by Rafael Damasceno on 22/05/18.
//
import UIKit
import Foundation
import AccessoryBarView

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textfieldSecond: UITextField!
    
    var accessoryBarView: AccessoryBarView = AccessoryBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accessoryBarView.accessoryDelegate = self
        accessoryBarView.setupAccessoryBarView(presentedView: self.view, textFields: [textField, textfieldSecond], progress: 0.5, shouldHideAccessoryView: true)
        accessoryBarView.setButtomImage(UIImage(named: "arrow")!)
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =  UITapGestureRecognizer(target: self, action:  #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override var canBecomeFirstResponder: Bool {
        return false
    }
    
    override var inputAccessoryView: UIView {
        get {
            return accessoryBarView.accessoryView!
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ selectedTextField: UITextField) {
        switch selectedTextField {
        case textField:
            accessoryBarView.setButtomTitle("Next")
        case textfieldSecond:
            accessoryBarView.setButtomTitle("Continue")
        default:
            break
        }
    }
}
extension ViewController: AccessoryDelegate {

    func accessoryDidContinue() {
        if textField.isFirstResponder {
            textfieldSecond.becomeFirstResponder()
        } else {
            print("It Works!")
        }
    }
    
    
}
