//
//  MediaViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 11/06/22.
//

import Foundation

class MediaViewCell: UICollectionViewCell {
    
    
    var mediaView: MediaView = {
        let mediaView = MediaView(frame: .zero)
        mediaView.translatesAutoresizingMaskIntoConstraints = false
        return mediaView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.mediaView)
        
        self.mediaView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.mediaView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.mediaView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.mediaView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    func setup(urlString: String, count: String) {
        self.mediaView.loadView(img: urlString, count: count)
    }
}
