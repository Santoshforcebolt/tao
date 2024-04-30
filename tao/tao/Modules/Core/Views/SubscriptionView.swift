//
//  SubscriptionView.swift
//  tao
//
//  Created by Mayank Khursija on 17/07/22.
//

import Foundation
import UIKit

class SubscriptionView: UIView {
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    } ()
    
    var discountedPriceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    } ()
    
    var offerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    } ()
    
    var diamondImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.offerLabel)
        
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        
        let discountedPriceStackView = UIStackView(frame: .zero)
        discountedPriceStackView.axis = .horizontal
        discountedPriceStackView.translatesAutoresizingMaskIntoConstraints = false
        discountedPriceStackView.spacing = 8
        
        discountedPriceStackView.addArrangedSubview(self.priceLabel)
        discountedPriceStackView.addArrangedSubview(self.discountedPriceLabel)
        self.priceLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        self.addSubview(discountedPriceStackView)
        
        discountedPriceStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        discountedPriceStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        discountedPriceStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        
        self.offerLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 8).isActive = true
        self.offerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        self.offerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
    }
    
    func setup(title: String, price: String, discountedPrice: String, validity: String) {
        self.titleLabel.text = title
        self.priceLabel.text = price
        let attributedText = NSAttributedString(
            string: discountedPrice,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        self.discountedPriceLabel.attributedText = attributedText
        self.offerLabel.text = validity
    }
}
