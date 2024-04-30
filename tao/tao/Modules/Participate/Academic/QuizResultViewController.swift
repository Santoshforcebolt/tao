//
//  QuizResultViewController.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

class QuizResultViewController: BaseViewController<QuizResultViewModel> {
    
    var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        return contentView
    } ()
    
    var timeScroreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var questionScoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var timeScroreValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var questionScoreValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var totalScoreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var totalScroreValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var totalQuestionsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var totalQuestionsValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var correctAnswerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var correctAnswerValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var browseOtherButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var goToLeaderboardButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    override init(_ viewModel: QuizResultViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blueBackground
        self.setupView()
        
        self.timeScroreLabel.text = "Time Score"
        self.questionScoreLabel.text = "Question Score"
        
        self.totalScoreLabel.text = "Total Score"
        
        self.totalQuestionsLabel.text = "Total Questions"
        self.totalQuestionsValueLabel.text = "8"
        
        self.correctAnswerLabel.text = "Correct Answers"
        self.correctAnswerValueLabel.text = "8"
        
        self.browseOtherButton.setTitle("Go to Home", for: .normal)
        self.goToLeaderboardButton.setTitle("Go To Leaderboard", for: .normal)
        
        self.goToLeaderboardButton.addTarget(self, action: #selector(goToLeaderBoardTapped), for: .touchUpInside)
        self.browseOtherButton.addTarget(self, action: #selector(browseOtherCompetitionsTapped), for: .touchUpInside)
        
    }
    
    @objc func goToLeaderBoardTapped() {
        self.viewModel.goToLeaderBoardTapped()
    }
    
    @objc func browseOtherCompetitionsTapped() {
        self.viewModel.goToHomeTapped()
    }
    
    override func reloadView() {
        super.reloadView()
        self.timeScroreValueLabel.text = "\(round(self.viewModel.evaluation?.body?.timeScore ?? 0))"
        self.questionScoreValueLabel.text = "\(round(self.viewModel.evaluation?.body?.responseScore ?? 0))"
        self.totalScroreValueLabel.text = "\(round(self.viewModel.evaluation?.body?.totalScore ?? 0))"
        self.totalQuestionsValueLabel.text = ""
    }
    
    func setupView() {
        self.containerView.addSubview(self.contentView)
        self.contentView.addSubview(self.browseOtherButton)
        self.contentView.addSubview(self.goToLeaderboardButton)
        
        
        self.contentView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 30).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                              constant: -30).isActive = true
        self.contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                 constant: -16).isActive = true
        
        let horizontalStackView = UIStackView(frame: .zero)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        
        let verticalStackView = UIStackView(frame: .zero)
        verticalStackView.axis = .vertical
        
        let verticalStackView2 = UIStackView(frame: .zero)
        verticalStackView2.axis = .vertical
        
        verticalStackView.addArrangedSubview(self.timeScroreLabel)
        verticalStackView.addArrangedSubview(self.timeScroreValueLabel)
        
        self.timeScroreLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        verticalStackView2.addArrangedSubview(self.questionScoreLabel)
        verticalStackView2.addArrangedSubview(self.questionScoreValueLabel)
        
        self.questionScoreLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(verticalStackView2)
        
        self.contentView.addSubview(horizontalStackView)
        self.contentView.addSubview(self.totalScoreLabel)
        self.contentView.addSubview(self.totalScroreValueLabel)
        
        horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        horizontalStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8).isActive = true
        horizontalStackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.totalScoreLabel.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 8).isActive = true
        self.totalScoreLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        self.totalScoreLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 8).isActive = true
        
        self.totalScroreValueLabel.topAnchor.constraint(equalTo: self.totalScoreLabel.bottomAnchor).isActive = true
        self.totalScroreValueLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        self.totalScroreValueLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: 8).isActive = true
        
        let horizontalStackView2 = UIStackView(frame: .zero)
        horizontalStackView2.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView2.axis = .horizontal
        horizontalStackView2.distribution = .fill
        
        
        let verticalStackView3 = UIStackView(frame: .zero)
        verticalStackView3.axis = .vertical
        
        let verticalStackView4 = UIStackView(frame: .zero)
        verticalStackView4.axis = .vertical
        
        verticalStackView3.addArrangedSubview(self.totalQuestionsLabel)
        verticalStackView3.addArrangedSubview(self.totalQuestionsValueLabel)
        
        self.totalQuestionsLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        verticalStackView4.addArrangedSubview(self.correctAnswerLabel)
        verticalStackView4.addArrangedSubview(self.correctAnswerValueLabel)
        
        self.correctAnswerLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = .black
        
        horizontalStackView2.addArrangedSubview(verticalStackView3)
        horizontalStackView2.addArrangedSubview(separator)
        horizontalStackView2.addArrangedSubview(verticalStackView4)
        
        
        self.contentView.addSubview(horizontalStackView2)
        
        horizontalStackView2.topAnchor.constraint(equalTo: self.totalScroreValueLabel.bottomAnchor, constant: 16).isActive = true
        horizontalStackView2.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        horizontalStackView2.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8).isActive = true
        horizontalStackView2.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.browseOtherButton.topAnchor.constraint(equalTo: horizontalStackView2.bottomAnchor, constant: 24).isActive = true
        self.browseOtherButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.browseOtherButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        self.browseOtherButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.goToLeaderboardButton.topAnchor.constraint(equalTo: self.browseOtherButton.bottomAnchor, constant: 8).isActive = true
        self.goToLeaderboardButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.goToLeaderboardButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        self.goToLeaderboardButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.goToLeaderboardButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                     constant: -24).isActive = true
    }
}
