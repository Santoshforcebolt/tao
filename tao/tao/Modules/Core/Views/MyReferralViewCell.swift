//
//  MyReferralViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 14/08/22.
//

import Foundation

class MyReferralViewCell: UICollectionViewCell {
    var transactionAmountView: NudgeView
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var subTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    init(type: NudgeView.ViewType) {
        self.transactionAmountView = NudgeView()
        super.init(frame: .zero)
        self.setupView()
    }
    
    override init(frame: CGRect) {
        self.transactionAmountView = NudgeView()
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        let verticalStackView = UIStackView(frame: .zero)
        verticalStackView.axis = .vertical
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStackView.addArrangedSubview(self.titleLabel)
        verticalStackView.addArrangedSubview(self.subTitleLabel)
        
        self.subTitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let horizontalStackView = UIStackView(frame: .zero)
        horizontalStackView.axis = .horizontal
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(self.transactionAmountView)
        self.transactionAmountView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        verticalStackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        self.transactionAmountView.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: 0.3).isActive = true
        
        self.contentView.addSubview(horizontalStackView)
        
        horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        horizontalStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    func setupData(title: String, subTitle: String, type: NudgeView.ViewType, subTitleColor: UIColor) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        self.transactionAmountView.updateType(type: type)
        self.subTitleLabel.textColor = subTitleColor
    }
}
