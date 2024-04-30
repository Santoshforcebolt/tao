//
//  NudgeView.swift
//  tao
//
//  Created by Mayank Khursija on 28/06/22.
//

import Foundation

class NudgeView: UIView {
    enum ViewType {
        case money(String)
        case coin(String)
    }
    
    struct RenderData {
        var font: UIFont? = UIFont(name: "Poppins", size: 18)
        var textColor: UIColor = .black
        var distanceBetweenLabelAndImage: CGFloat = 4
        var imageWidth: CGFloat = 18
        var image: UIImage? = UIImage(named: "twemoji_coin")
    }
    
    private var type: ViewType = .coin("0")
    private var renderData: RenderData
    
    init(renderData: RenderData = RenderData()) {
        self.renderData = renderData
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        return imageView
    }()
    
    private var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private func setupView() {
        
        //PrepareForReuse Solution
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.textLabel.font = self.renderData.font
        self.textLabel.textColor = self.renderData.textColor
        
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        
        switch self.type {
        case .money(let money):
            self.textLabel.text = "₹\(money)"
            
            view.addSubview(self.textLabel)
            self.textLabel.translatesAutoresizingMaskIntoConstraints = false
            self.textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.textLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            self.textLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        case .coin(let coins):
            self.textLabel.text = coins
            self.imageView.image = self.renderData.image
            self.imageView.contentMode = .scaleAspectFit
            self.textLabel.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(self.textLabel)
            view.addSubview(self.imageView)
            
            self.imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            self.imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.imageView.widthAnchor.constraint(equalToConstant: self.renderData.imageWidth).isActive = true
            self.imageView.heightAnchor.constraint(equalToConstant: self.renderData.imageWidth).isActive = true
            
            self.textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.textLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            self.textLabel.rightAnchor.constraint(equalTo: self.imageView.leftAnchor,
                                                  constant: -self.renderData.distanceBetweenLabelAndImage).isActive = true
            
        }
        view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        view.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor,
                                    constant: -8).isActive = true
    }
    
    func updateTextColor(color: UIColor) {
        self.textLabel.textColor = color
    }
    
    func updateType(type: ViewType) {
        self.type = type
        self.setupView()
    }
    
    func updatePictureForCoin(image: UIImage?) {
        switch self.type {
        case .money(_):
            break
        case .coin(_):
            self.renderData.image = image
            self.setupView()
        }
    }
}
