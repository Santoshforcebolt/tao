//
//  BannerViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 03/06/22.
//

import Foundation

class BannerViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(self.imageView)
        
        self.imageView.layer.masksToBounds = true
        self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: self.contentView.frame.width).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.contentView.frame.height).isActive = true
        
        self.imageView.layer.cornerRadius = 16
    }
    
    func setupImage(image: Image) {
        switch image {
        case .withURL(let uRL):
            self.imageView.sd_setImage(with: uRL)
        case .withImage(let uIImage):
            self.imageView.image = uIImage
        }
    }
}
