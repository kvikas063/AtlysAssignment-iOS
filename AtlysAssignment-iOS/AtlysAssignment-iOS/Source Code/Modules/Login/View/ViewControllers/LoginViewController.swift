//
//  LoginViewController.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 30/10/24.
//
import UIKit

class LoginViewController: UIViewController {

    // MARK: - UI Properties
    private var scrollView: UIScrollView        = .zero.constraintsReady
    private var contentView: UIStackView        = .zero.constraintsReady
    private var topHolderStackView: UIStackView = .zero.constraintsReady
    private var bottomSpaceHeightConstraint: NSLayoutConstraint!
    
    // MARK: - ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = AppColor.Login.background
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Handle Spacing between views to keep social view in the bottom
        bottomSpaceHeightConstraint.constant = max(0, scrollView.frame.height - contentView.frame.height)
    }
}

// MARK: - Setup UI Methods
private extension LoginViewController {
    
    func setupUI() {
        createScrollView()
        createContentView()
        setupTopHolderView()
        setupTopTitleView()
        setupCarouselView()
        setupMiddleVisaLabel()
        setupMobileNumberView()
        setupBottomSpaceView()
        setupORLineView()
        setupBottomSocialView()
        setupTermsAndPrivacyLabel()
    }
    
    private func createScrollView() {
        contentView.backgroundColor = AppColor.Login.white
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createContentView() {
        contentView.axis = .vertical
        contentView.isLayoutMarginsRelativeArrangement = true
        contentView.directionalLayoutMargins = .init(top: 0, leading: 0, bottom: 30, trailing: 0)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupTopHolderView() {
        topHolderStackView.axis = .vertical
        contentView.addArrangedSubview(topHolderStackView)
    }
    
    func setupTopTitleView() {
        let topView: TopTitleView = .zero.constraintsReady
        topHolderStackView.addArrangedSubview(topView)
        topHolderStackView.setCustomSpacing(40, after: topView)
    }
    
    func setupCarouselView() {
        let carouselData = Carousel.datasource()
        var views: [Int:UIView] = [:]
        
        for (index, model) in carouselData.enumerated() {
            let cardView = CarouselCardView(cardModel: model)
            views[index] = cardView
        }

        let topCarouselView = TopCarouselView(with: views)
        topHolderStackView.addArrangedSubview(topCarouselView)
        topHolderStackView.setCustomSpacing(15, after: topCarouselView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            topCarouselView.scrollCard(to: 1)
        }
    }
    
    func setupMiddleVisaLabel() {
        let middleLabel: UILabel  = .zero.constraintsReady
        middleLabel.text          = AppString.Login.GetVisasOnTimeText
        middleLabel.font          = AppFont.Login.GetVisasOnTime
        middleLabel.textAlignment = .center
        middleLabel.numberOfLines = 2
        
        topHolderStackView.addArrangedSubview(middleLabel)
        topHolderStackView.setCustomSpacing(15, after: middleLabel)
    }
    
    func setupMobileNumberView() {
        let mobileView = MobileNumberView(delegate: self, keyboardDelegate: self)
        mobileView.translatesAutoresizingMaskIntoConstraints = false
        topHolderStackView.addArrangedSubview(mobileView)
        topHolderStackView.setCustomSpacing(20, after: mobileView)
        
        mobileView.widthAnchor.constraint(equalTo: topHolderStackView.widthAnchor).isActive = true
    }
    
    func setupBottomSpaceView() {
        let stackview: UIStackView = .zero.constraintsReady
        topHolderStackView.addArrangedSubview(stackview)
        bottomSpaceHeightConstraint = stackview.heightAnchor.constraint(equalToConstant: 10)
        bottomSpaceHeightConstraint.isActive = true
    }
    
    func setupORLineView() {
        let orLabel: UILabel = .zero.constraintsReady
        orLabel.text         = AppString.Login.OrLabelText
        orLabel.textColor    = AppColor.Login.gray
        orLabel.font         = AppFont.Login.TermsAndPrivacy
        
        let line1View: UIView     = .zero.constraintsReady
        line1View.backgroundColor = AppColor.Login.lightGray
        
        let line2View: UIView     = .zero.constraintsReady
        line2View.backgroundColor = AppColor.Login.lightGray

        let stackView: UIStackView = .zero.constraintsReady
        stackView.axis             = .horizontal
        stackView.alignment        = .center
        stackView.spacing          = 10
        stackView.distribution     = .fill
        
        stackView.addArrangeSub(views: [line1View, orLabel, line2View])
        
        let verticalStackView: UIStackView = .zero.constraintsReady
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        verticalStackView.addArrangedSubview(stackView)
        topHolderStackView.addArrangedSubview(verticalStackView)
        topHolderStackView.setCustomSpacing(20, after: verticalStackView)
        
        NSLayoutConstraint.activate([
            orLabel.widthAnchor.constraint(equalToConstant: 16),
            line1View.heightAnchor.constraint(equalToConstant: 1),
            line2View.heightAnchor.constraint(equalToConstant: 1),
            line1View.widthAnchor.constraint(equalTo: line2View.widthAnchor),
            stackView.widthAnchor.constraint(equalTo: topHolderStackView.widthAnchor, constant: -80)
        ])
    }
    
    func setupBottomSocialView() {
        let socialView: BottomSocialView = .zero.constraintsReady
        topHolderStackView.addArrangedSubview(socialView)
        topHolderStackView.setCustomSpacing(20, after: socialView)
    }
    
    func setupTermsAndPrivacyLabel() {
        let termsLabel: UILabel  = .zero.constraintsReady
        termsLabel.font          = AppFont.Login.TermsAndPrivacy
        termsLabel.textColor     = AppColor.Login.black
        termsLabel.textAlignment = .center
        termsLabel.adjustsFontSizeToFitWidth = true
        
        let termsAndPrivacyText = AppString.Login.TermsAndPrivacyText
        let termsRange = NSString(string: termsAndPrivacyText).range(of: AppString.Login.TermsText)
        let privacyRange = NSString(string: termsAndPrivacyText).range(of: AppString.Login.PrivacyText)
        
        let attributedString = NSMutableAttributedString(string: termsAndPrivacyText)
        let attributeDictionary: [NSAttributedString.Key : Any] = [.underlineColor : AppColor.Login.purple,
                                                                   .underlineStyle: NSUnderlineStyle.single.rawValue]
        attributedString.addAttributes(attributeDictionary, range: termsRange)
        attributedString.addAttributes(attributeDictionary, range: privacyRange)
        
        termsLabel.attributedText = attributedString
        
        let verticalStackview: UIStackView = .zero.constraintsReady
        verticalStackview.axis = .vertical
        verticalStackview.alignment = .center
        verticalStackview.addArrangedSubview(termsLabel)
        topHolderStackView.addArrangedSubview(verticalStackview)
        
        termsLabel.widthAnchor.constraint(equalTo: topHolderStackView.widthAnchor, constant: -40).isActive = true
    }
}
