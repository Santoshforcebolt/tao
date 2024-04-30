//
//  LeaderBoardDetailViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 02/07/22.
//

import Foundation

class LeaderBoardDetailViewCell: UICollectionViewCell {
    
    var leftLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var rightLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let horizontalStackView = UIStackView(frame: .zero)
  
        horizontalStackView.axis = .horizontal
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.addArrangedSubview(self.leftLabel)
        horizontalStackView.addArrangedSubview(self.rightLabel)
        
        self.rightLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        self.contentView.addSubview(horizontalStackView)
        
        horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        horizontalStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    func setupData(leftText: String, rightText: String) {
        self.leftLabel.text = leftText
        self.rightLabel.text = rightText
        self.leftLabel.underline()
    }
    
}
