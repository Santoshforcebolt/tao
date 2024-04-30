//
//  TransactionView.swift
//  tao
//
//  Created by Mayank Khursija on 28/06/22.
//

import Foundation

class TransactionViewCell: UICollectionViewCell {
    
    var transactionDetailView: UserInfoView?
    
    var transactionAmountView: NudgeView
    
    private var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.textColor = .black
        return label
    } ()
    
    private var showCounter = false
    
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
        
        let horizontalStackView = UIStackView(frame: .zero)
  
        horizontalStackView.axis = .horizontal
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false

        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        self.contentView.addSubview(horizontalStackView)
        
        if self.showCounter {
            horizontalStackView.addArrangedSubview(self.textLabel)
            self.textLabel.setContentHuggingPriority(.required, for: .horizontal)
            self.textLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true
        }
        
        if let transactionDetailView = transactionDetailView {
            transactionDetailView.isUserInteractionEnabled = false
            horizontalStackView.addArrangedSubview(transactionDetailView)
            horizontalStackView.setCustomSpacing(16, after: transactionDetailView)
            transactionDetailView.setContentCompressionResistancePriority(.required,
                                                                          for: .horizontal)
        }
        
        horizontalStackView.addArrangedSubview(self.transactionAmountView)

        self.transactionAmountView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3).isActive = true

        horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        horizontalStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }
    
    func setupData(title: String, image: Image, info: String?, subInfo: String?) {
        if subInfo != nil {
            if info != nil {
                let renderData = UserInfoView.RenderData(imageHeight: 48,
                                                         imageWidth: 48,
                                                         subtitleNumberOfLines: 3,
                                                         textColor: .black,
                                                         titleFont: UIFont(name: "Poppins-Bold", size: 14)!,
                                                         subtitleFont: UIFont(name: "Poppins", size: 10)!,
                                                         textAlignment: .left,
                                                         isRoundedImage: false,
                                                         showRightIcon: false,
                                                         showMobileNumber: true)
                
                self.transactionDetailView = UserInfoView(renderData: renderData)
                self.transactionDetailView?.translatesAutoresizingMaskIntoConstraints = false
                
                self.transactionDetailView?.setupData(name: title,
                                                     image: image,
                                                     info: info,
                                                     subInfo: subInfo)
            } else {
                let renderData = UserInfoView.RenderData(imageHeight: 48,
                                                         imageWidth: 48,
                                                         subtitleNumberOfLines: 3,
                                                         textColor: .black,
                                                         titleFont: UIFont(name: "Poppins-Bold", size: 14)!,
                                                         subtitleFont: UIFont(name: "Poppins", size: 12)!,
                                                         textAlignment: .left,
                                                         isRoundedImage: false,
                                                         showRightIcon: false,
                                                         showMobileNumber: false)
                
                self.transactionDetailView = UserInfoView(renderData: renderData)
                self.transactionDetailView?.translatesAutoresizingMaskIntoConstraints = false
                
                self.transactionDetailView?.setupData(name: title,
                                                     image: image,
                                                     info: subInfo)
            }
        } else {
            let renderData = UserInfoView.RenderData(imageHeight: 48,
                                                     imageWidth: 48,
                                                     subtitleNumberOfLines: 3,
                                                     textColor: .black,
                                                     titleFont: UIFont(name: "Poppins-Bold", size: 14)!,
                                                     subtitleFont: UIFont(name: "Poppins", size: 10)!,
                                                     textAlignment: .left,
                                                     isRoundedImage: false,
                                                     showRightIcon: false,
                                                     showMobileNumber: false)
            
            self.transactionDetailView = UserInfoView(renderData: renderData)
            self.transactionDetailView?.translatesAutoresizingMaskIntoConstraints = false

            self.transactionDetailView?.setupData(name: title,
                                                  image: image,
                                                  info: info)
        }
        
        self.setupView()
    }
    
    func updateNudgeType(type: NudgeView.ViewType) {
        self.transactionAmountView.updateType(type: type)
        self.setupView()
    }
    
    func updateTextColor(color: UIColor) {
        self.transactionAmountView.updateTextColor(color: color)
    }
    
    func showCounter(text: String) {
        self.showCounter = true
        self.textLabel.text = text
        self.setupView()
    }
}
