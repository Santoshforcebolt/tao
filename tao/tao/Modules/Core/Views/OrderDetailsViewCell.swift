//
//  OrderDetailsViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 28/06/22.
//

import Foundation

class OrderDetailsViewCell: UICollectionViewCell {
    
    var orderDetailView: OrderDetailsView = {
        let renderData = OrderDetailsView.RenderData(titleFont: UIFont(name: "Poppins", size: 12),
                                                     subtitleFont: UIFont(name: "Poppins", size: 12),
                                                     showViewDetailsView: false,
                                                     showDiscountedPrice: false)
        let view = OrderDetailsView(renderData: renderData)
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
        self.contentView.addSubview(self.orderDetailView)
        
        orderDetailView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                              constant: 8).isActive = true
        orderDetailView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 24).isActive = true
        orderDetailView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -24).isActive = true
        orderDetailView.heightAnchor.constraint(greaterThanOrEqualToConstant: 146).isActive = true
        orderDetailView.layer.cornerRadius = 16
    }
    
    func setup(image: Image, title: String, price: String, subtitle: String) {
        self.orderDetailView.setup(image: image,
                                   title: title,
                                   price: price,
                                   subtitle: subtitle)
    }
    
    func setup(image: Image, title: String, price: String, maxLines: Int, attributedText: NSAttributedString) {
        self.orderDetailView.setup(image: image,
                                   title: title,
                                   price: price,
                                   maxLines: maxLines,
                                   attributedString: attributedText)
    }
    
    func updateSubtitleColor(color: UIColor) {
        self.orderDetailView.updateSubtitleColor(color: color)
    }
}
