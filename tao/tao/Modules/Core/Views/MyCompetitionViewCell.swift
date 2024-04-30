//
//  MyCompetitionViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 11/08/22.
//

import Foundation
import Foundation

class MyCompetitionViewCell: UICollectionViewCell {
    
    var userInfoView: UserInfoView = {
        let renderData = UserInfoView.RenderData(textColor: .black, showRightIcon: false)
        let userInfoView = UserInfoView(renderData: renderData)
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        userInfoView.isUserInteractionEnabled = false
        return userInfoView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(self.userInfoView)
        
        self.userInfoView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.userInfoView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.userInfoView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.userInfoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    func setupData(name: String, image: Image, info: String) {
        self.userInfoView.setupData(name: name, image: image, info: info)
    }
}
