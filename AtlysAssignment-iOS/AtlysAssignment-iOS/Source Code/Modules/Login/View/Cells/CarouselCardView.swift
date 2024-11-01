//
//  CarouselCardView.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 30/10/24.
//
import UIKit

class CarouselCardView: UIView {
    
    // MARK: - UI Properties
    private let countryLabel: UILabel      = .zero.constraintsReady
    private let visaLabel: UILabel         = .zero.constraintsReady
    private let cityImageView: UIImageView = .zero.constraintsReady
    
    // MARK: - Init Methods
    init(cardModel: Carousel) {
        super.init(frame: .zero)
        setupUI()

        countryLabel.text = cardModel.country
        visaLabel.text = cardModel.visa
        cityImageView.image = UIImage(named: cardModel.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI Methods
private extension CarouselCardView {
    
    func setupUI() {
        setupCityCardView()
        setupTickView()
        setupVisaLabel()
        setupCountryLabel()
    }
    
    func setupCityCardView() {
        // add a view with rounded corners be the "visible frame"
        let cardView: UIView = .zero.constraintsReady
        cardView.applyRoundedCorner(of: 12)
        cityImageView.applyRoundedCorner(of: 12)
        
        // let's give it a very light shadow
        cardView.applyShadow(radius: 10, opacity: 0.5)
        cardView.addSubview(cityImageView)
        addSubview(cardView)
        
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            
            cityImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            cityImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            cityImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            cityImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
        ])
    }
    
    func setupTickView() {
        let tickView: UIView = .zero.constraintsReady
        tickView.backgroundColor = AppColor.Login.white
        tickView.applyRoundedCorner(of: 18)
        
        let tickImageView: UIImageView = .zero.constraintsReady
        tickImageView.image = AppImage.Login.tick
        tickView.addSubview(tickImageView)
        
        cityImageView.addSubview(tickView)
        
        NSLayoutConstraint.activate([
            tickView.topAnchor.constraint(equalTo: cityImageView.topAnchor, constant: 12),
            tickView.trailingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: -12),
            tickView.widthAnchor.constraint(equalToConstant: 36),
            tickView.heightAnchor.constraint(equalToConstant: 36),
            
            tickImageView.centerXAnchor.constraint(equalTo: tickView.centerXAnchor),
            tickImageView.centerYAnchor.constraint(equalTo: tickView.centerYAnchor),
            tickImageView.widthAnchor.constraint(equalToConstant: 20),
            tickImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupCountryLabel() {
        countryLabel.font          = AppFont.Login.CardTitle
        countryLabel.textColor     = AppColor.Login.white
        cityImageView.addSubview(countryLabel)
        
        NSLayoutConstraint.activate([
            countryLabel.leadingAnchor.constraint(equalTo: cityImageView.leadingAnchor, constant: 8),
            countryLabel.trailingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: -8),
            countryLabel.bottomAnchor.constraint(equalTo: visaLabel.topAnchor, constant: -5)
        ])
    }
    
    func setupVisaLabel() {
        visaLabel.font            = AppFont.Login.CardSubTitle
        visaLabel.textColor       = AppColor.Login.white
        visaLabel.backgroundColor = AppColor.Login.purple
        visaLabel.textAlignment   = .center
        visaLabel.labelCornerRadius()
        cityImageView.addSubview(visaLabel)

        NSLayoutConstraint.activate([
            visaLabel.leadingAnchor.constraint(equalTo: cityImageView.leadingAnchor),
            visaLabel.bottomAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: -24),
            visaLabel.widthAnchor.constraint(equalToConstant: 140),
            visaLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
