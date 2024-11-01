//
//  BottomSocialView.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 30/10/24.
//
import UIKit

class BottomSocialView: UIView {
    
    // MARK: - UI Properties
    private var socialStackView: UIStackView = {
        let stackView       = UIStackView()
        stackView.axis      = .horizontal
        stackView.alignment = .center
        stackView.spacing   = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI Methods
private extension BottomSocialView {
    
    func setupUI() {
        setupHolderStackview()
        setupSocialButtonsView()
    }
    
    func setupHolderStackview() {
        let holderStackView: UIStackView = .zero.constraintsReady
        holderStackView.axis             = .vertical
        holderStackView.alignment        = .center
        addSubview(holderStackView)
        holderStackView.addArrangedSubview(socialStackView)
        
        NSLayoutConstraint.activate([
            holderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            holderStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            holderStackView.topAnchor.constraint(equalTo: topAnchor),
            holderStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupSocialButtonsView() {
        SocialButtonType.allCases.forEach { type in
            let socialButtonView = SocialButtonView(type: type)
            socialStackView.addArrangedSubview(socialButtonView)
        }
    }
}
