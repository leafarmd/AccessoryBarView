import Foundation
import InputProgress


public protocol AccessoryDelegate: class {
    func accessoryDidContinue()
}

open class AccessoryBarView: UIView {
    
    open var buttomContinue = UIButton()
    open var inputProgress: InputProgress?
    open var hideAccessoryView: Bool = false
    open var accessoryView: UIToolbar?
    open var accessoryDelegate: AccessoryDelegate?
    
    public init() {
        super.init(frame: UIScreen.main.bounds)
        setupContinueButton()
        setupAccessoryView()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setAccessoryViewBackGroundColor(_ color: UIColor) {
        self.accessoryView?.barTintColor = color
    }
    
    public func setProgressBarColor(_ color: UIColor) {
        inputProgress?.progressBarColor = color
    }
    
    public func setButtomTitle(_ title: String) {
        buttomContinue.setTitle(title, for: .normal)
    }
    
    public func setButtomAttributedTitle(_ attributedTitle: NSAttributedString) {
        buttomContinue.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    public func setButtonTitleFont(_ font: UIFont) {
        buttomContinue.titleLabel?.font = font
    }
    
    public func setButtonTitleColor(_ color: UIColor) {
        buttomContinue.titleLabel?.textColor = color
    }
    
    public func setButtonTitleEdgeInsets(_ titleEdgeInsets: UIEdgeInsets) {
        buttomContinue.titleEdgeInsets = titleEdgeInsets
    }
    
    public func setButtomImage(_ image: UIImage?) {
        buttomContinue.setImage(image, for: .normal)
        buttomContinue.setImage(image, for: .selected)
    }
    
    public func setButtomImageEdgeInsets(_ imageEdgeInsets: UIEdgeInsets) {
        buttomContinue.imageEdgeInsets = imageEdgeInsets
    }
    
    private func setupAccessoryView() {
        accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 56))
        accessoryView?.isTranslucent = false
        accessoryView?.isOpaque = true
        accessoryView?.barTintColor = #colorLiteral(red: 0.1607843137, green: 0.5019607843, blue: 0.7254901961, alpha: 1)
        let continueBarButton = UIBarButtonItem(customView: buttomContinue)
        let flexibleBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        accessoryView?.setItems([flexibleBarButton, continueBarButton], animated: true)
    }
    
    private func setupContinueButton() {
        buttomContinue.addTarget(self, action: #selector(self.buttomContinueTouched(_:)), for: .touchUpInside)
        buttomContinue.setTitle("Next ", for: .normal)
        buttomContinue.contentHorizontalAlignment = .right
        buttomContinue.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 56)
        buttomContinue.backgroundColor = .clear
    }
    
    public func setupAccessoryBarView(presentedView: UIView, textFields: [UITextField], progress: CGFloat = 0.0, progressBarHeight: CGFloat = 8.0, shouldDisplayBottomViewBar: Bool = true, shouldHideAccessoryView: Bool = false) {
        textFields.forEach{
            $0.inputAccessoryView = accessoryView
        }
        inputProgress = InputProgress(presentingView: presentedView, textFields: textFields)
        inputProgress?.progressBarColor = #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        inputProgress?.progressBarHeight = 8.0
        inputProgress?.progress = progress
        inputProgress?.shouldDisplayBottomViewBar = shouldDisplayBottomViewBar
        self.hideAccessoryView = shouldHideAccessoryView
    }
    
    // MARK: IBActions
    
    @objc func buttomContinueTouched(_ sender: UIButton) {
        accessoryDelegate?.accessoryDidContinue()
    }
}


