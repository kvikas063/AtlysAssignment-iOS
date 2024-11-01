//
//  SocialButtonView.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 30/10/24.
//
import UIKit

//MARK: - Social Button Type Enum
enum SocialButtonType: CaseIterable {
    case google
    case apple
    case email
    
    var image: UIImage? {
        switch self {
            case .google:
                UIImage(resource: .google)
            case .apple:
                UIImage(resource: .apple)
            case .email:
                UIImage(resource: .email)
        }
    }
}

class SocialButtonView: UIView {
    
    // MARK: - UI Properties
    private var socialImage: UIImageView = .zero.constraintsReady
    private var buttonType: SocialButtonType

    // MARK: - Init Methods
    init(type: SocialButtonType) {
        self.buttonType = type
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI Methods
private extension SocialButtonView {
    
    func setupUI() {
        setupButtonView()
    }
    
    func setupButtonView() {
        let backView: UIView     = .zero.constraintsReady
        backView.backgroundColor = AppColor.Login.white
        addSubview(backView)
        backView.applyRoundedCorner(of: 10)
        backView.applyShadow()
        
        socialImage.image = buttonType.image
        backView.addSubview(socialImage)
        
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backView.topAnchor.constraint(equalTo: topAnchor),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backView.widthAnchor.constraint(equalToConstant: 50),
            backView.heightAnchor.constraint(equalToConstant: 50),

            socialImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10),
            socialImage.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            socialImage.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            socialImage.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -10),
        ])
    }
}
