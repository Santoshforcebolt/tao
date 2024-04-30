//
//  OrderDetailsView.swift
//  tao
//
//  Created by Mayank Khursija on 04/06/22.
//

import Foundation
import UIKit

class OrderDetailsView: UIView {
    
    struct RenderData {
        var imageHeight: CGFloat = 112
        var imageWidth: CGFloat = 107
        var titleFont: UIFont? = UIFont(name: "Poppins", size: 10)
        var titleColor: UIColor = .black
        var subtitleFont: UIFont? = UIFont(name: "Poppins", size: 10)
        var subTitleColor: UIColor = .black
        var spacingBetweentitleAndPrice: CGFloat = 8
        var spacingBetweenPriceAndSubtitle: CGFloat = 8
        var showViewDetailsView: Bool = true
        var showDiscountedPrice: Bool = true
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    } ()
    
    var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var discountedPriceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var instructionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var coinImageViewPriceLabel: UIImageView?
    var coinImageViewDiscountedPriceLabel: UIImageView?
    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        self.backgroundColor = .lightGrayBackground
//        self.setupView()
//    }
    private var renderData: RenderData
    
    init(renderData: RenderData = RenderData()) {
        self.renderData = renderData
        super.init(frame: .zero)
        self.backgroundColor = .lightGrayBackground
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.instructionLabel)
        
        self.titleLabel.font = self.renderData.titleFont
        self.instructionLabel.font = self.renderData.subtitleFont
        self.titleLabel.textColor = self.renderData.titleColor
        self.instructionLabel.textColor = self.renderData.subTitleColor
        self.layer.cornerRadius = 16
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: self.renderData.imageWidth).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.renderData.imageHeight).isActive = true
        
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 16
        
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 12).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        
        let stackView: UIStackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        let coinImageViewPriceLabel = UIImageView(frame: .zero)
        self.coinImageViewPriceLabel = coinImageViewPriceLabel
        coinImageViewPriceLabel.image = UIImage(named: "twemoji_coin")
        coinImageViewPriceLabel.contentMode = .scaleAspectFit
        
        let coinImageViewDiscountedPriceLabel = UIImageView(frame: .zero)
        self.coinImageViewDiscountedPriceLabel = coinImageViewDiscountedPriceLabel
        coinImageViewDiscountedPriceLabel.image = UIImage(named: "twemoji_coin")
        coinImageViewDiscountedPriceLabel.contentMode = .scaleAspectFit
        
        
        stackView.addArrangedSubview(coinImageViewPriceLabel)
        stackView.addArrangedSubview(self.priceLabel)
        if self.renderData.showDiscountedPrice {
            stackView.addArrangedSubview(coinImageViewDiscountedPriceLabel)
            stackView.addArrangedSubview(self.discountedPriceLabel)
            coinImageViewDiscountedPriceLabel.frame.size.width = 12
            coinImageViewDiscountedPriceLabel.frame.size.height = 12
            coinImageViewDiscountedPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            stackView.setCustomSpacing(16, after: self.priceLabel)
        }
        
        coinImageViewPriceLabel.frame.size.width = 18
        coinImageViewPriceLabel.frame.size.height = 18
        
        coinImageViewPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        

        self.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                       constant: self.renderData.spacingBetweentitleAndPrice).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 12).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.instructionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                                   constant: self.renderData.spacingBetweentitleAndPrice).isActive = true
        self.instructionLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 12).isActive = true
        self.instructionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        

        if self.renderData.showViewDetailsView {
            let horizontalStackView = UIStackView(frame: .zero)
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView.axis = .horizontal
            
            let viewDetailsLabel = UILabel(frame: .zero)
            viewDetailsLabel.text = "View Details"
            viewDetailsLabel.font = UIFont(name: "Poppins", size: 12)
            viewDetailsLabel.textColor = .darkGrayBackground
            
            let button = UIButton(frame: .zero)
            button.backgroundColor = .darkGrayBackground
            button.layer.cornerRadius = 5
            button.setImage(UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = .white
            
            horizontalStackView.addArrangedSubview(viewDetailsLabel)
            horizontalStackView.addArrangedSubview(button)
            
            button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            button.frame.size.width = 40
            self.addSubview(horizontalStackView)
            
            horizontalStackView.topAnchor.constraint(equalTo: self.instructionLabel.bottomAnchor, constant: 8).isActive = true
            horizontalStackView.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 12).isActive = true
            horizontalStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
            horizontalStackView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        }
    }
    
    func setup(product: Product, flow: OrderFlow = .store) {
        if let url = URL(string: product.image ?? "") {
            self.imageView.sd_setImage(with: url)
        }
        if TaoHelper.userProfile?.userDetails?.isPremiumUser ?? false {
            switch flow {
            case .store:
                self.priceLabel.text = "\(product.coinsDiscount ?? 0)"
                let discount: Int = Int(((product.coinsDiscount ?? 0)/(product.coinsAmount ?? 0)) * 100)
                self.instructionLabel.text = "You save \(discount)%"
            case .myOrders:
                self.priceLabel.text = "\(product.coinsAmount ?? 0)"
                self.instructionLabel.isHidden = true
            }
        } else {
            self.priceLabel.text = "\(product.coinsAmount ?? 0)"
            self.instructionLabel.isHidden = true
        }
        self.discountedPriceLabel.text = "\(product.coinsAmount ?? 0)"
        self.coinImageViewDiscountedPriceLabel?.removeFromSuperview()
        self.discountedPriceLabel.removeFromSuperview()

        self.titleLabel.text = product.name
    }
    
    func setup(image: Image, title: String, price: String, subtitle: String) {
        switch image {
        case .withURL(let uRL):
            self.imageView.sd_setImage(with: uRL)
        case .withImage(let uIImage):
            self.imageView.image = uIImage
        }
        
        self.priceLabel.text = price
        self.titleLabel.text = title
        self.instructionLabel.text = subtitle
    }
    
    func setup(image: Image,
               title: String,
               price: String,
               maxLines: Int,
               attributedString: NSAttributedString) {
        switch image {
        case .withURL(let uRL):
            self.imageView.sd_setImage(with: uRL)
        case .withImage(let uIImage):
            self.imageView.image = uIImage
        }
        
        self.priceLabel.text = price
        self.titleLabel.text = title
        self.instructionLabel.attributedText = attributedString
        self.instructionLabel.numberOfLines = maxLines
    }
    
    func updateSubtitleColor(color: UIColor) {
        self.instructionLabel.textColor = color
    }
    
    func showCoinView(_ show: Bool) {
        if show == false {
            self.coinImageViewPriceLabel?.removeFromSuperview()
        }
    }
}
