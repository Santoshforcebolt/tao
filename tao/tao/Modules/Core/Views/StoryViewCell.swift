//
//  StoryViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 08/06/22.
//

import Foundation
import AVKit

class StoryViewCell: UICollectionViewCell {
    
    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var vm: StoryCellViewModel?
    
    var moreButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "more"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var forwardButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrowshape.turn.up.forward"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    var likeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var viewsCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var userInfoView: UserInfoView = {
        let renderData = UserInfoView.RenderData(titleFont: UIFont(name: "Poppins-Bold", size: 14)!,
                                                 subtitleFont: UIFont(name: "Poppins-Bold", size: 12)!)
        let userInfoView = UserInfoView(renderData: renderData)
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        return userInfoView
    }()
    
    var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "clear"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.contentView.addSubview(self.moreButton)
        self.contentView.addSubview(self.forwardButton)
        self.contentView.addSubview(self.likeButton)
        self.contentView.addSubview(self.likesLabel)
        self.contentView.addSubview(self.userInfoView)
        self.contentView.addSubview(self.closeButton)
        self.contentView.addSubview(self.titleLabel)
        
        self.moreButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                               constant: -16).isActive = true
        self.moreButton.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor,
                                                constant: -32).isActive = true
        self.moreButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.moreButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        self.forwardButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                               constant: -16).isActive = true
        self.forwardButton.bottomAnchor.constraint(equalTo: self.moreButton.topAnchor,
                                                constant: -16).isActive = true
        self.forwardButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.forwardButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        let playImageView = UIImageView(frame: .zero)
        playImageView.translatesAutoresizingMaskIntoConstraints = false
        playImageView.image = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysTemplate)
        playImageView.tintColor = .white
        
        self.contentView.addSubview(self.viewsCountLabel)
        self.contentView.addSubview(playImageView)
        
        self.viewsCountLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
        self.viewsCountLabel.bottomAnchor.constraint(equalTo: self.forwardButton.topAnchor, constant: -12).isActive = true
        self.viewsCountLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
        self.viewsCountLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        playImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                               constant: -16).isActive = true
        playImageView.bottomAnchor.constraint(equalTo: self.viewsCountLabel.topAnchor,
                                                constant: -4).isActive = true
        playImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        playImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.likesLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
        self.likesLabel.bottomAnchor.constraint(equalTo: playImageView.topAnchor, constant: -12).isActive = true
        self.likesLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
        self.likesLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.likeButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                               constant: -16).isActive = true
        self.likeButton.bottomAnchor.constraint(equalTo: self.likesLabel.topAnchor,
                                                constant: -4).isActive = true
        self.likeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.likeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.userInfoView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                  constant: -48).isActive = true
        self.userInfoView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                                  constant: 16).isActive = true
        self.userInfoView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                                 constant: -44).isActive = true
        self.userInfoView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.userInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileTapped)))
        
        
        self.closeButton.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor,
                                              constant: 16).isActive = true
        self.closeButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                              constant: 16).isActive = true
        self.closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.closeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor,
                                              constant: 16).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.closeButton.rightAnchor,
                                              constant: 16).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                               constant: -16).isActive = true
        
        self.closeButton.addTarget(self, action: #selector(closeClicked), for: .touchUpInside)
        self.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        self.forwardButton.addTarget(self, action: #selector(forwardButtonClicked), for: .touchUpInside)
        self.moreButton.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: self.avPlayer?.currentItem)
    }
    
    
    func stopPlayback(){
        self.avPlayer?.pause()
    }

    func startPlayback(){
        self.avPlayer?.play()
    }

    @objc func profileTapped() {
        self.avPlayer?.pause()
        self.vm?.profileTapped()
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero, completionHandler: nil)
    }
    
    func setup(vm: StoryCellViewModel) {
        self.vm = vm
        self.avPlayerLayer?.removeFromSuperlayer()
        self.avPlayer = nil
        self.avPlayerLayer = nil
        vm.trackView()
        
        let videoURL = URL(string: vm.resourceUrl)
        if let videoURL = videoURL {
            let player = AVPlayer(url: videoURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.videoGravity = .resizeAspect
            playerLayer.frame = self.contentView.bounds
            self.contentView.layer.addSublayer(playerLayer)
            self.avPlayer = player
            self.avPlayerLayer = playerLayer
            self.setupView()
            if let imageUrlString = TaoHelper.userProfile?.userDetails?.imageUrl,
               let imageUrl = URL(string: imageUrlString) {
                self.userInfoView.setupData(name: vm.participationName,
                                            image: .withURL(imageUrl),
                                            info: vm.description)
            } else {
                //FIXME: Change default image
                self.userInfoView.setupData(name: vm.participationName,
                                            image: .withImage(UIImage(systemName: "defaultLeaderboardPicture")!),
                                            info: vm.description)
            }
            self.titleLabel.text = vm.competitionName
            let image = vm.userLiked ? UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate) : UIImage(systemName: "heart")
            self.likeButton.setImage(image, for: .normal)
            self.likeButton.tintColor = vm.userLiked ? .red : .white
            self.likesLabel.text = vm.likesText
            self.viewsCountLabel.text = vm.viewCount
        }
    }
    
    override func prepareForReuse() {
        self.avPlayerLayer?.removeFromSuperlayer()
        self.avPlayer = nil
        self.avPlayerLayer = nil
        super.prepareForReuse()
    }
    
    @objc func closeClicked() {
        
        self.avPlayer?.pause()//Fix for media played even after closing screen
        self.avPlayer = nil
        self.avPlayerLayer = nil
        
        self.vm?.closeClicked()
    }
    
    @objc func likeButtonClicked() {
        
        self.vm?.likeButtonClicked(completion: { userLiked in
            let image = userLiked ? UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate) : UIImage(systemName: "heart")
            self.likeButton.setImage(image, for: .normal)
            self.likeButton.tintColor = userLiked ? .red : .white
            self.likesLabel.text = "\((self.vm?.mediaEntry.likes ?? 0) + 1)"
        })
    }
    
    @objc func forwardButtonClicked() {
        self.vm?.shareButtonClicked()
    }
    
    @objc func moreButtonClicked() {
        self.vm?.moreButtonClicked()
    }
}
