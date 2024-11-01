//
//  TopCarouselView.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 30/10/24.
//
import UIKit

class TopCarouselView: UIView {
    
    // MARK: - UI Properties
    private let pageControl: UIPageControl   = .zero.constraintsReady
    private let scrollView: UIScrollView     = .zero.constraintsReady
    private let holderStackView: UIStackView = .zero.constraintsReady
    
    /// It manages index of the carousel view
    private var currentIndex: Int = 0 {
        didSet {
            resetTransform()
            transformSelectedView()
            pageControl.currentPage = currentIndex
        }
    }
    private var carouselViews: [Int: UIView] = [:]
    
    init(with views: [Int: UIView]) {
        super.init(frame: .zero)
        carouselViews = views
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if holderStackView.bounds.contains(point) {
            return scrollView
        }
        return super.hitTest(point, with: event)
    }
    
    func scrollCard(to index: Int, animated: Bool = false) {
        currentIndex = index
        scrollView.setContentOffset(getScrollPoint(for: index), animated: animated)
    }
}

// MARK: - Private Helper Methods
private extension TopCarouselView {
    
    @objc func pageChanged() {
        scrollCard(to: pageControl.currentPage, animated: true)
    }
    
    func getScrollPoint(for index: Int) -> CGPoint {
        .init(x: scrollView.frame.width * CGFloat(index), y: 0)
    }
    
    func resetTransform() {
        carouselViews.forEach { view in
            view.value.transform = .identity
            view.value.layer.cornerRadius = 0
            self.sendSubviewToBack(view.value)
        }
    }
    
    func transformSelectedView() {
        if let view = carouselViews[currentIndex] {
            view.layer.cornerRadius = 8
            UIView.animate(withDuration: 0.2) {
                view.transform = .init(scaleX: 1.2, y: 1.2)
            }
            self.bringSubviewToFront(view)
            holderStackView.bringSubviewToFront(view)
        }
    }
}

// MARK: - Setup UI Methods
private extension TopCarouselView {
    
    func setupUI() {
        setupScrollView()
        setupHolderStackView()
        setupPageControl()
        setupCardViews()
    }
    
    func setupScrollView() {
        scrollView.delegate        = self
        scrollView.clipsToBounds   = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.50),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.50),
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupHolderStackView() {
        holderStackView.axis         = .horizontal
        holderStackView.spacing      = 0
        holderStackView.alignment    = .fill
        holderStackView.distribution = .fillEqually

        scrollView.addSubview(holderStackView)
        
        let cg = scrollView.contentLayoutGuide
        let fg = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            holderStackView.topAnchor.constraint(equalTo: cg.topAnchor),
            holderStackView.leadingAnchor.constraint(equalTo: cg.leadingAnchor),
            holderStackView.trailingAnchor.constraint(equalTo: cg.trailingAnchor),
            holderStackView.bottomAnchor.constraint(equalTo: cg.bottomAnchor),
            holderStackView.heightAnchor.constraint(equalTo: fg.heightAnchor)
        ])
    }
    
    func setupCardViews() {
        for index in carouselViews.keys.sorted() {
            if let cardView = carouselViews[index] {
                holderStackView.addArrangedSubview(cardView)
                cardView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
            }
        }
    }
    
    func setupPageControl() {
        pageControl.hidesForSinglePage            = true
        pageControl.numberOfPages                 = carouselViews.count
        pageControl.pageIndicatorTintColor        = AppColor.Login.lightGray
        pageControl.currentPageIndicatorTintColor = AppColor.Login.darkGray
        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        addSubview(pageControl)
                
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 25),
            pageControl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            pageControl.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

// MARK: - ScrollView Delegate Methods
extension TopCarouselView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        let index = Int(contentOffset.x / scrollView.frame.width)
        if index != currentIndex {
            currentIndex = index
        }
    }
}
