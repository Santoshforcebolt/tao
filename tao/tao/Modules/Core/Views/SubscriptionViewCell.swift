//
//  SubscriptionViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 16/07/22.
//

import Foundation
import UIKit

class SubscriptionViewCell: UICollectionViewCell {
    
    var subscriptionView: SubscriptionView = {
        let view = SubscriptionView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.subscriptionView)
        self.subscriptionView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.subscriptionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        self.subscriptionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8).isActive = true
        self.subscriptionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    func setup(title: String, price: String, discountedPrice: String, validity: String) {
        self.subscriptionView.setup(title: title, price: price, discountedPrice: discountedPrice, validity: validity)
    }
}
