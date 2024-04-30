//
//  ChooseVideoViewController.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation

class ChooseVideoViewController: BaseViewController<ChooseVideoViewModel> {
    
    private var imagePickerCompletion: ImagePickerResult?
    
    override init(_ viewModel: ChooseVideoViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        return contentView
    } ()
    
    var bannerImageView: UIImageView = {
        let uiImageView = UIImageView(frame: .zero)
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    } ()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var clockImageView: UIImageView = {
        let uiImageView = UIImageView(frame: .zero)
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        uiImageView.image = UIImage(systemName: "clock")
        return uiImageView
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var rulesLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 9)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var chooseVideoButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .newDarkBlueBackground
        return button
    }()
    
    var instructionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 9)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var requirementLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 9)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .newDarkBlueBackground
        
        self.setupView()
        
        self.setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableBackButtonNavigationBar()
    }
    
    override func reloadView() {
        super.reloadView()
        self.setupData()
    }
    
    func setupData() {
        self.bannerImageView.sd_setImage(with: self.viewModel.bannerImageUrl)
        self.bannerImageView.backgroundColor = self.viewModel.bannerBackgroundColor
        self.titleLabel.text = self.viewModel.titleText
        self.runCountdown() // For time Label
        self.rulesLabel.text = self.viewModel.rulesText
        self.chooseVideoButton.setTitle("Choose Video", for: .normal)
        self.chooseVideoButton.addTarget(self,
                                         action: #selector(chooseButtonTapped),
                                         for: .touchUpInside)
        self.instructionLabel.text = "Only Verified students can upload the video. Max size is \(self.viewModel.maxSizeOfVideo) MB"
        self.requirementLabel.text = "Needs Camera, Mircophone and Storagge Permission to record/upload video"
    }
    
    func setupView() {
        self.containerView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.bannerImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.clockImageView)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.rulesLabel)
        self.contentView.addSubview(self.chooseVideoButton)
        self.contentView.addSubview(self.instructionLabel)
        
        self.containerView.addSubview(self.requirementLabel)
        
        self.contentView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 50).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                              constant: -50).isActive = true
        self.contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        

        self.bannerImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                              constant: 8).isActive = true
        self.bannerImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.bannerImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        self.bannerImageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.bannerImageView.bottomAnchor,
                                              constant: 8).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        
        self.clockImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                              constant: 8).isActive = true
        self.clockImageView.widthAnchor.constraint(equalToConstant: 54).isActive = true
        self.clockImageView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        self.clockImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        self.timeLabel.topAnchor.constraint(equalTo: self.clockImageView.bottomAnchor,
                                              constant: 8).isActive = true
        self.timeLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.timeLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        
        self.rulesLabel.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor,
                                              constant: 8).isActive = true
        self.rulesLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.rulesLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        
        self.chooseVideoButton.topAnchor.constraint(equalTo: self.rulesLabel.bottomAnchor,
                                              constant: 24).isActive = true
        self.chooseVideoButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 32).isActive = true
        self.chooseVideoButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -32).isActive = true
        self.chooseVideoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
 
        self.instructionLabel.topAnchor.constraint(equalTo: self.chooseVideoButton.bottomAnchor,
                                              constant: 24).isActive = true
        self.instructionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.instructionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        
        self.instructionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                     constant: -8).isActive = true
    
        self.requirementLabel.topAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                              constant: 24).isActive = true
        self.requirementLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 58).isActive = true
        self.requirementLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                              constant: -58).isActive = true
        self.requirementLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        
    }
    
    @objc func chooseButtonTapped() {
        self.viewModel.chooseButtonTapped()
    }
    
    @objc override func backAction() {
        super.backAction()
        self.viewModel.backButtonTapped()
    }
}


//MARK: Timer Implementation
extension ChooseVideoViewController {
    var countdown: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: self.viewModel.endDate ?? Date())
    }
    
    @objc func updateTime() {
        let countdown = self.countdown
        let hours = countdown.hour!
        let minutes = countdown.minute!
        let seconds = countdown.second!
        
        self.timeLabel.text = ""
        
        if hours != 0 {
            self.timeLabel.text?.append(contentsOf: "\(hours) hours ")
        }
        
        if minutes != 0 {
            self.timeLabel.text?.append(contentsOf: "\(minutes) minutes ")
        }
        
        if seconds != 0 {
            self.timeLabel.text?.append(contentsOf: "\(seconds) seconds")
        }
        
    }

    func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
}
