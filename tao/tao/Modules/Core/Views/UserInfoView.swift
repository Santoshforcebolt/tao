//
//  UserInfoView.swift
//  tao
//
//  Created by Mayank Khursija on 10/06/22.
//

import Foundation

class UserInfoView: UICollectionViewCell {
    
    struct RenderData {
        var imageHeight: CGFloat = 68.0
        var imageWidth: CGFloat = 68.0
        var subtitleNumberOfLines = 0
        var distanceBetweenImageAndLabel: CGFloat = 16.0
        var textColor: UIColor = .white
        var titleFont: UIFont = UIFont(name: "Poppins", size: 14)!
        var subtitleFont: UIFont = UIFont(name: "Poppins", size: 12)!
        var mobileNumberFont: UIFont = UIFont(name: "Poppins", size: 12)!
        var textAlignment: NSTextAlignment = .left
        var isRoundedImage: Bool = true
        var showRightIcon: Bool = false
        var showMobileNumber: Bool = false
    }
    
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    } ()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private var mobileNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    } ()
    
    private var renderData: RenderData
    
    init(renderData: RenderData = RenderData()) {
        self.renderData = renderData
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        // Solution for PrepareForReuse
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let centerView = UIView(frame: .zero)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(centerView)
        
        
        centerView.addSubview(self.textLabel)
        centerView.addSubview(self.subtitleLabel)
        
        self.imageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: self.renderData.imageWidth).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.renderData.imageHeight).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        
        centerView.leftAnchor.constraint(equalTo: self.imageView.rightAnchor,
                                         constant: self.renderData.distanceBetweenImageAndLabel).isActive = true
        centerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        centerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true

        
        self.textLabel.textColor = self.renderData.textColor
        self.textLabel.font = self.renderData.titleFont
        self.textLabel.textAlignment = self.renderData.textAlignment
        
        self.subtitleLabel.textColor = self.renderData.textColor
        self.subtitleLabel.font = self.renderData.subtitleFont
        self.subtitleLabel.textAlignment = self.renderData.textAlignment
        self.subtitleLabel.numberOfLines = self.renderData.subtitleNumberOfLines
        
        if self.renderData.isRoundedImage {
            self.imageView.cornerRadius = self.renderData.imageHeight/2
        }

        self.textLabel.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
        self.subtitleLabel.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
        
        self.textLabel.topAnchor.constraint(equalTo: centerView.topAnchor).isActive = true
        self.subtitleLabel.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor,
                                                constant: 8).isActive = true
        self.textLabel.rightAnchor.constraint(equalTo: centerView.rightAnchor).isActive = true
        self.subtitleLabel.rightAnchor.constraint(equalTo: centerView.rightAnchor).isActive = true

        if self.renderData.showMobileNumber {
            self.mobileNumberLabel.font = self.renderData.mobileNumberFont
            self.mobileNumberLabel.textAlignment = self.renderData.textAlignment
            self.mobileNumberLabel.textColor = self.renderData.textColor
            
            centerView.addSubview(self.mobileNumberLabel)
            self.mobileNumberLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor,
                                                    constant: 8).isActive = true
            self.mobileNumberLabel.leftAnchor.constraint(equalTo: centerView.leftAnchor).isActive = true
            self.mobileNumberLabel.rightAnchor.constraint(equalTo: centerView.rightAnchor).isActive = true
            self.mobileNumberLabel.bottomAnchor.constraint(equalTo: centerView.bottomAnchor).isActive = true
        } else {
            self.subtitleLabel.bottomAnchor.constraint(equalTo: centerView.bottomAnchor).isActive = true
        }
        
        if self.renderData.showRightIcon {
            let backbutton = UIButton(type: .custom)
            backbutton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            backbutton.backgroundColor = .white
            backbutton.layer.cornerRadius = 8
            backbutton.tintColor = .black
            backbutton.translatesAutoresizingMaskIntoConstraints = false
                        
            self.addSubview(backbutton)
            centerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -44).isActive = true
            
            backbutton.rightAnchor.constraint(equalTo: self.rightAnchor,
                                              constant: -8).isActive = true
            backbutton.heightAnchor.constraint(equalToConstant: 36).isActive = true
            backbutton.widthAnchor.constraint(equalToConstant: 36).isActive = true
            backbutton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
        } else {
            centerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }
        
        self.textLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func setupData(name: String,
                   image: Image,
                   info: String? = TaoHelper.userProfile?.userDetails?.schoolInfo?.schoolName,
                   subInfo: String? = TaoHelper.userProfile?.userDetails?.phone) {
        switch image {
        case .withURL(let url):
            self.imageView.sd_setImage(with: url)
        case .withImage(let image):
            self.imageView.image = image
        }
        self.textLabel.text = name
        self.subtitleLabel.text = info
        self.mobileNumberLabel.text = subInfo
    }
    
    @objc func backAction() {
        
    }
}
