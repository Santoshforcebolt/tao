//
//  QuizTableViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

class QuizTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setupView() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.backgroundColor = .grayBackground
        
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    func setData(text: String) {
        self.titleLabel.text = text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.cornerRadius = 8
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
}
