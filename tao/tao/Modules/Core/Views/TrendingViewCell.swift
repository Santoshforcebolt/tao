//
//  TrendingViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 03/06/22.
//

import Foundation

class TrendingViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var companyNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    } ()
    
    var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var discountedPriceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 8)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var instructionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 6)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.companyNameLabel)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.instructionLabel)
        
        self.imageView.layer.masksToBounds = true
        self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.imageView.layer.cornerRadius = 16
        
        self.companyNameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 8).isActive = true
        self.companyNameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.companyNameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.companyNameLabel.bottomAnchor).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        
        let stackView: UIStackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        let coinImageViewPriceLabel = UIImageView(frame: .zero)
        coinImageViewPriceLabel.contentMode = .scaleAspectFit
        coinImageViewPriceLabel.image = UIImage(named: "twemoji_coin")
        
        let coinImageViewDiscountedPriceLabel = UIImageView(frame: .zero)
        coinImageViewDiscountedPriceLabel.contentMode = .scaleAspectFit
        coinImageViewDiscountedPriceLabel.image = UIImage(named: "twemoji_coin")
        
        coinImageViewPriceLabel.frame.size.width = 12
        coinImageViewPriceLabel.frame.size.height = 12
        coinImageViewDiscountedPriceLabel.frame.size.width = 8
        coinImageViewDiscountedPriceLabel.frame.size.height = 8
        
        stackView.addArrangedSubview(coinImageViewPriceLabel)
        stackView.addArrangedSubview(self.priceLabel)
        stackView.addArrangedSubview(coinImageViewDiscountedPriceLabel)
        stackView.addArrangedSubview(self.discountedPriceLabel)
        coinImageViewPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        coinImageViewDiscountedPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        self.contentView.addSubview(stackView)
        
        stackView.setCustomSpacing(16, after: self.priceLabel)
        
        stackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.instructionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                                   constant: 8).isActive = true
        self.instructionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.instructionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        
    }
    
    func setup(product: Product) {
        if let url = URL(string: product.image ?? "") {
            self.imageView.sd_setImage(with: url)
        }
        
        self.companyNameLabel.text = product.brand
        self.titleLabel.text = product.name
        self.priceLabel.text = String(product.coinsDiscount ?? 0.0)
        
        let attributedText = NSAttributedString(
            string: String(product.coinsAmount ?? 0.0),
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        
        self.discountedPriceLabel.attributedText = attributedText
        let discount: Int = Int(((product.coinsDiscount ?? 0)/(product.coinsAmount ?? 0)) * 100)
        self.instructionLabel.text = "\(discount)% premium memeber discount"
    }
    
}
