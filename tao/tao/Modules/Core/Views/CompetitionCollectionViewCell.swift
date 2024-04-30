//
//  CompetitionCollectionViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 20/08/22.
//

import Foundation

class CompetitionCollectionViewCell: UICollectionViewCell {
    
    private var sponsorImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var compImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var winLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var timeRemainingView: ProfileOptionView = {
        let infoView = ProfileOptionView(renderData: ProfileOptionView.RenderData(
            imageWidth: 16,
            leftSpacing: 8,
            rightSpacing: 8,
            font: UIFont(name: "Poppins", size: 10),
            customSpacing: 8,
            height: 36,
            showRightIcon: false))
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.cornerRadius = 8
        infoView.backgroundColor = .systemGreen
        return infoView
    }()
    
    private var nudgeView: NudgeView = NudgeView()
    
    private var endDate: Date?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(self.sponsorImageView)
        self.contentView.addSubview(self.compImageView)
        self.contentView.addSubview(self.timeRemainingView)
        let winView = UIStackView(frame: .zero)
        winView.axis = .vertical
        winView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(winView)
        winView.addArrangedSubview(self.winLabel)
        self.winLabel.text = "Win"
        winView.addArrangedSubview(self.nudgeView)
        
        self.compImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
        self.compImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -32).isActive = true
        self.compImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        self.compImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        self.sponsorImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16).isActive = true
        self.sponsorImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        self.sponsorImageView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.sponsorImageView.widthAnchor.constraint(equalToConstant: 36).isActive = true

        winView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        winView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
        winView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.timeRemainingView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        self.timeRemainingView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        self.timeRemainingView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
    func setupData(compImage: Image, sponsorImage: String?, nudgeType: NudgeView.ViewType, daysRemaining: TextType) {
        self.nudgeView.updateType(type: nudgeType)
        switch compImage {
        case .withURL(let uRL):
            self.compImageView.sd_setImage(with: uRL)
        case .withImage(let uIImage):
            self.compImageView.image = uIImage
        }
        if let sponsorImage = sponsorImage {
            self.sponsorImageView.sd_setImage(with: URL(string: sponsorImage))
        }
        switch daysRemaining {
        case .plain(let string):
            self.timeRemainingView.setupData(image: .withImage(UIImage(systemName: "clock")!), text: "\(string) days remaining")
        case .clock(let date):
            self.endDate = date
            self.runCountdown()
        }
    }
}

//MARK: Timer Implementation
extension CompetitionCollectionViewCell {
    private var countdown: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: self.endDate ?? Date())
    }
    
    @objc private func updateTime() {
        let countdown = self.countdown
        let hours = countdown.hour!
        let minutes = countdown.minute!
        
        var time = ""
        
        if hours != 0 {
            time.append(contentsOf: "\(hours) hours ")
        }
        
        if minutes != 0 {
           time.append(contentsOf: "\(minutes) minutes ")
        }
        self.timeRemainingView.setupData(image: .withImage(UIImage(systemName: "clock")!), text: "\(time) days remaining")
    }

    private func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
}
