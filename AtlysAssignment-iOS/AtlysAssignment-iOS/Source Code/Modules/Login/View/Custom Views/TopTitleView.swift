//
//  TopTitleView.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 30/10/24.
//
import UIKit

class TopTitleView: UIView {
    
    // MARK: - UI Properties
    private let holderStackView: UIStackView = .zero.constraintsReady
    
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
private extension TopTitleView {
    
    func setupUI() {
        setupHolderStackView()
        setupTitleLabel()
        setupSubTitleLabel()
    }
    
    func setupHolderStackView() {
        holderStackView.axis = .vertical
        addSubview(holderStackView)
        
        NSLayoutConstraint.activate([
            holderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            holderStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            holderStackView.topAnchor.constraint(equalTo: topAnchor),
            holderStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupTitleLabel() {
        let titleLabel: UILabel  = .zero.constraintsReady
        titleLabel.text          = AppString.Login.AppTitleText
        titleLabel.font          = AppFont.Login.TopTitle
        titleLabel.textAlignment = .center

        holderStackView.addArrangedSubview(titleLabel)
    }
    
    func setupSubTitleLabel() {
        let subtitleLabel: UILabel  = .zero.constraintsReady
        subtitleLabel.text          = AppString.Login.AppSubTitleText
        subtitleLabel.font          = AppFont.Login.TopSubTitle
        subtitleLabel.textColor     = AppColor.Login.purple
        subtitleLabel.textAlignment = .center
        
        holderStackView.addArrangedSubview(subtitleLabel)
    }
}
