//
//  View+Extension.swift
//  AtlysAssignment-iOS
//
//  Created by Vikas Kumar on 30/10/24.
//
import UIKit

protocol InitWithFrame {
    init(frame: CGRect)
}

extension InitWithFrame {
    static var zero: Self { .init(frame: .zero) }
}

extension UIView: InitWithFrame {}

extension UIView {
    
    var constraintsReady: Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}

extension UIView {
    
    func applyRoundedCorner(of radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    
    func applyBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func labelCornerRadius() {
        clipsToBounds = true
        layer.cornerRadius = 12
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func applyShadow(
        radius: CGFloat = 3,
        opacity: Float = 0.3,
        color: UIColor = .black,
        offset: CGSize = .init(width: 0, height: 0)
    ) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}

extension UIStackView {
    
    func addArrangeSub(views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
