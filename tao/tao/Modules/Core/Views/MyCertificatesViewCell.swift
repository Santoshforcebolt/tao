//
//  MyCertificatesViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 15/08/22.
//

import Foundation

class MyCertificatesViewCell: UICollectionViewCell {
    var userInfoView: UserInfoView = {
        let renderData = UserInfoView.RenderData(textColor: .black,
                                                 titleFont: UIFont(name: "Poppins-Bold", size: 14)!,
                                                 subtitleFont: UIFont(name: "Poppins", size: 12)!,
                                                 showMobileNumber: true)
        let userInfoView = UserInfoView(renderData: renderData)
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        return userInfoView
    }()
    
    var downloadLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.backgroundColor = .lightBlueBackground
        label.cornerRadius = 8
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.userInfoView)
        self.contentView.addSubview(self.downloadLabel)
        
        self.userInfoView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                                constant: 8).isActive = true
        self.userInfoView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                                 constant: -8).isActive = true
        self.userInfoView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                               constant: 8).isActive = true
        self.userInfoView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.downloadLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                                constant: 24).isActive = true
        self.downloadLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                                 constant: -24).isActive = true
        self.downloadLabel.topAnchor.constraint(equalTo: self.userInfoView.bottomAnchor,
                                               constant: 8).isActive = true
        self.downloadLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        self.downloadLabel.text = "Click to Download"
    }
    
    func setupData(competitionName: String, rank: String, type: String, image: Image) {
        self.userInfoView.setupData(name: competitionName, image: image, info: rank, subInfo: type)
    }
}
