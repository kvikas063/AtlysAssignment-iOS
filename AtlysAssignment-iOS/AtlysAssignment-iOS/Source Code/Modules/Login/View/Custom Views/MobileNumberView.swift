//
//  MobileNumberView.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 30/10/24.
//
import UIKit

protocol MobileNumberKeyboardDelegate {
    func keyboardWillShow()
    func keyboardWillHide()
}

protocol MobileNumberDelegate {
    func didContinueTapped(with number: String)
}

class MobileNumberView: UIView {
    
    // MARK: - UI Properties
    private var holderStackView: UIStackView = {
        let stackView          = UIStackView()
        stackView.axis         = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let mobileNumberHolderView: UIView = {
        let view = UIView(frame: .zero)
        view.applyRoundedCorner(of: 12)
        view.applyBorder(width: 1, color: .lightGray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var continueButton: UIButton = .zero.constraintsReady
    
    private var mobileNumber: String = AppString.EmptyString {
        didSet {
            continueButton.isEnabled = mobileNumber.count == 10
        }
    }
    
    // MARK: - Delegates
    var delegate: MobileNumberDelegate
    var keyboardDelegate: MobileNumberKeyboardDelegate
    
    // MARK: - Init Methods
    init(
        delegate: MobileNumberDelegate,
        keyboardDelegate: MobileNumberKeyboardDelegate
    ) {
        self.delegate = delegate
        self.keyboardDelegate = keyboardDelegate
        super.init(frame: .zero)
        
        setupUI()
        keyboardObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObservers()
    }
}

// MARK: - Private Keyboard Oberserver Methods
private extension MobileNumberView {
    
    func keyboardObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        keyboardDelegate.keyboardWillShow()
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        keyboardDelegate.keyboardWillHide()
    }
    
    @objc func continueTapped() {
        delegate.didContinueTapped(with: mobileNumber)
    }
}

// MARK: - Private Setup UI Methods
private extension MobileNumberView {
    
    func setupUI() {
        setupHolderView()
        setupMobileHolderView()
        setupMobileNumberView()
        setupButtonView()
    }
    
    func setupHolderView() {
        addSubview(holderStackView)
        
        NSLayoutConstraint.activate([
            holderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            holderStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            holderStackView.topAnchor.constraint(equalTo: topAnchor),
            holderStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupMobileHolderView() {
        holderStackView.addArrangedSubview(mobileNumberHolderView)
        holderStackView.setCustomSpacing(12, after: mobileNumberHolderView)
        mobileNumberHolderView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupMobileNumberView() {
        let countryImageview: UIImageView = .zero.constraintsReady
        countryImageview.image            = AppImage.Login.india
        
        let codeLabel: UILabel = .zero.constraintsReady
        codeLabel.text         = AppString.Login.CountryCodeText
        codeLabel.font         = AppFont.Login.CountryCode
        
        let downImageview: UIImageView = .zero.constraintsReady
        downImageview.image            = AppImage.Login.dropDown
        downImageview.tintColor        = AppColor.Login.black
        
        let mobileTextfield: UITextField = .zero.constraintsReady
        mobileTextfield.placeholder      = AppString.Login.MobileFieldPlaceholderText
        mobileTextfield.font             = AppFont.Login.MobileNumberField
        mobileTextfield.keyboardType     = .numberPad
        mobileTextfield.delegate         = self
        mobileTextfield.addDoneButtonOnKeyboard()
        
        let mobileStackView: UIStackView = .zero.constraintsReady
        mobileStackView.axis             = .horizontal
        mobileStackView.alignment        = .center
        mobileStackView.addArrangeSub(views: [countryImageview, codeLabel, downImageview, mobileTextfield])
        mobileStackView.setCustomSpacing(4, after: countryImageview)
        mobileStackView.setCustomSpacing(8, after: downImageview)
        
        mobileNumberHolderView.addSubview(mobileStackView)
        
        NSLayoutConstraint.activate([
            mobileStackView.leadingAnchor.constraint(equalTo: mobileNumberHolderView.leadingAnchor, constant: 12),
            mobileStackView.trailingAnchor.constraint(equalTo: mobileNumberHolderView.trailingAnchor, constant: -12),
            mobileStackView.topAnchor.constraint(equalTo: mobileNumberHolderView.topAnchor, constant: 8),
            mobileStackView.bottomAnchor.constraint(equalTo: mobileNumberHolderView.bottomAnchor, constant: -8),
            
            codeLabel.widthAnchor.constraint(equalToConstant: 30),
            countryImageview.widthAnchor.constraint(equalToConstant: 24),
            downImageview.widthAnchor.constraint(equalToConstant: 12),
            downImageview.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setupButtonView() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = AppColor.Login.purple
        configuration.baseForegroundColor = AppColor.Login.white
        
        var container  = AttributeContainer()
        container.font = AppFont.Login.ContinueButton
        let attributedTitle = AttributedString(AppString.Login.ContinueButtonText, attributes: container)
        configuration.attributedTitle = attributedTitle
        
        continueButton.configuration = configuration
        continueButton.applyRoundedCorner(of: 12)
        continueButton.isEnabled = false
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
        
        holderStackView.addArrangedSubview(continueButton)
        continueButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}

// MARK: - TextField Delegate Methods
extension MobileNumberView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mobileNumber = textField.nonEmptyText
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let text = textField.nonEmptyText + string
        mobileNumber = text
        return text.count <= 10
    }
}
