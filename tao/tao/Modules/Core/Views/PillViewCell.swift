//
//  PillViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 14/06/22.
//

import Foundation

class PillViewCell: UICollectionViewCell {
    
    private var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Poppins", size: 12)
        label.textColor = .white
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.textLabel)
        
        self.textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.textLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        self.textLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
    }
    
    func setup(text: String) {
        self.textLabel.text = text
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.itemSelected()
            } else {
                self.itemDeselected()
            }
        }
    }
    
    func itemSelected() {
        self.contentView.backgroundColor = .blueBackground
    }
    
    func itemDeselected() {
        self.contentView.backgroundColor = .grayBackground
    }
}
