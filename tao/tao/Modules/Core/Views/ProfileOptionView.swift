//
//  ProfileOptionView.swift
//  tao
//
//  Created by Mayank Khursija on 19/06/22.
//

import Foundation

//MARK: Can we use UserInfoView instead of this?
class ProfileOptionView: UIView {
    
    struct RenderData {
        var imageWidth: CGFloat = 20
        var leftSpacing: CGFloat = 0
        var rightSpacing: CGFloat = 0
        var font: UIFont? = UIFont(name: "Poppins", size: 12)
        var customSpacing: CGFloat = 24
        var height: CGFloat = 20
        var showRightIcon: Bool = true
        var showLeftIcon: Bool = true
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    
    private var renderData: RenderData
    
    init(renderData: RenderData = RenderData()) {
        self.renderData = renderData
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        let horizontalStackView = UIStackView(frame: .zero)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        
        self.addSubview(horizontalStackView)
        
        
        self.textLabel.font = self.renderData.font
        
        if self.renderData.showLeftIcon {
            horizontalStackView.addArrangedSubview(self.imageView)
            horizontalStackView.setCustomSpacing(self.renderData.customSpacing, after: self.imageView)
            self.imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            self.imageView.widthAnchor.constraint(equalToConstant: self.renderData.imageWidth).isActive = true
            self.imageView.contentMode = .scaleAspectFit
        }
        horizontalStackView.addArrangedSubview(self.textLabel)
        
        
        if self.renderData.showRightIcon {
            let button = UIButton(frame: .zero)
            button.backgroundColor = .white
            button.layer.cornerRadius = 5
            button.setImage(UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = .black
            button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            horizontalStackView.addArrangedSubview(button)
        }
        
        self.textLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        horizontalStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.renderData.leftSpacing).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.renderData.rightSpacing).isActive = true
        horizontalStackView.heightAnchor.constraint(equalToConstant: self.renderData.height).isActive = true
        horizontalStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setupData(image: Image?, text: String) {
        switch image {
        case .withURL(let uRL):
            self.imageView.sd_setImage(with: uRL)
        case .withImage(let uIImage):
            self.imageView.image = uIImage
        case .none:
            break
        }
        self.textLabel.text = text
    }
}
