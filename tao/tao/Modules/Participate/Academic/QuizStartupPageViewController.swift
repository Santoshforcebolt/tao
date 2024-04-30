//
//  QuizStartupPageViewController.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

class QuizStartupPageViewController: BaseViewController<QuizStartupPageViewModel> {
    
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
    
    var instructionStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var mcqInstruction: InstructionView = {
        let instruction = InstructionView()
        instruction.backgroundColor = .white
        return instruction
    }()
    
    var clockInstruction: InstructionView = {
        let instruction = InstructionView()
        instruction.backgroundColor = .white
        return instruction
    }()
    
    var playQuizButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    override init(_ viewModel: QuizStartupPageViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blueBackground
        
        self.setupView()
        
        self.bannerImageView.sd_setImage(with: self.viewModel.bannerImageUrl)
        self.bannerImageView.backgroundColor = self.viewModel.bannerBackgroundColor
        self.titleLabel.text = self.viewModel.titleText
        
        let mcqInstructionVM = InstructionViewModel(text: .plain("\(self.viewModel.totalQuestions) Questions"),
                                                    image: .withImage(UIImage(systemName: "clock")!))
        self.mcqInstruction.setVM(viewModel: mcqInstructionVM)
        
        let clockInstructionVM = InstructionViewModel(text: .clock(self.viewModel.endDate ?? Date()),
                                                      image: .withImage(UIImage(systemName: "clock")!))
        self.clockInstruction.setVM(viewModel: clockInstructionVM)
        
        
        self.playQuizButton.setTitle("Play now", for: .normal)
        self.playQuizButton.addTarget(self, action: #selector(playQuizButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableBackButtonNavigationBar()
    }
    
    func setupView() {
        self.containerView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.bannerImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.instructionStackView)
        self.contentView.addSubview(self.playQuizButton)
        
        self.contentView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 50).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                constant: -50).isActive = true
        self.contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        

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
        self.titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.instructionStackView.addArrangedSubview(self.mcqInstruction)
        self.instructionStackView.addArrangedSubview(self.clockInstruction)
        
        self.instructionStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                              constant: 8).isActive = true
        self.instructionStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.instructionStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        self.instructionStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        self.playQuizButton.topAnchor.constraint(equalTo: self.instructionStackView.bottomAnchor,
                                              constant: 24).isActive = true
        self.playQuizButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 32).isActive = true
        self.playQuizButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -32).isActive = true
        self.playQuizButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.playQuizButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                     constant: -24).isActive = true
    }
    
    override func reloadView() {
        super.reloadView()
        let mcqInstructionVM = InstructionViewModel(text: .plain("\(self.viewModel.totalQuestions) Questions"),
                                                    image: .withImage(UIImage(systemName: "clock")!))
        self.mcqInstruction.setVM(viewModel: mcqInstructionVM)
    }
    
    override func backAction() {
        super.backAction()
        self.viewModel.backButtonTapped()
    }
    
    @objc func playQuizButtonTapped() {
        self.viewModel.playQuizButtonTapped()
    }
}
