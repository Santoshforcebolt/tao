//
//  CompetitionDetailOverviewCell.swift
//  tao
//
//  Created by Mayank Khursija on 07/08/22.
//

import Foundation

class CompetitionDetailOverviewCell: UICollectionViewCell {
    
    private var rulesText: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont(name: "Poppins", size: 12)
        label.textColor = .black
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.rulesText)
        self.rulesText.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.rulesText.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.rulesText.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    }
    
    func setupData(rules: String) {
        self.rulesText.text = rules
    }
}
