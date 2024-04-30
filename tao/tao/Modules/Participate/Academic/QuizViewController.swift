//
//  QuizViewController.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

//FIXME: For Smaller Screen Sizes, Change View Arch (Add StackView to Containerview and use that)
class QuizViewController: BaseViewController<QuizViewModel> {
    
    var countDown = 0
    var timeLimit = 0
    var timer: Timer?
    
    override init(_ viewModel: QuizViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var questionNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    } ()
    
    var marksLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    } ()
    
    var clockImageView: UIImageView = {
        let uiImageView = UIImageView(frame: .zero)
        uiImageView.image = UIImage(systemName: "clock")
        return uiImageView
    }()
    
    var timerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    } ()
    
    var instructionStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        return contentView
    } ()
    
    var questionImageView: UIImageView = {
        let uiImageView = UIImageView(frame: .zero)
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    } ()
    
    var questionTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var quizOptionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blueBackground
        
        self.quizOptionsTableView.delegate = self
        self.quizOptionsTableView.dataSource = self
        self.quizOptionsTableView.separatorStyle = .none
        self.quizOptionsTableView.register(QuizTableViewCell.self, forCellReuseIdentifier: "quizCell")
        self.quizOptionsTableView.rowHeight = 80
        self.quizOptionsTableView.estimatedRowHeight = 100
        
        self.setupView()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.titleLabel.text = ""
        self.questionNumberLabel.text = "Question \(self.viewModel.questionNumber + 1) of \(self.viewModel.questions.count)"
        self.marksLabel.text = "Marks: \(self.viewModel.currentQuestion.maxPoints ?? 0)"
        self.timerLabel.text = "\(self.viewModel.currentQuestion.timeLimit ?? 0)"
        self.questionTitleLabel.text = self.viewModel.currentQuestion.questionText
        if let urlString = self.viewModel.currentQuestion.imageURL,
           let url = URL(string: urlString) {
            self.questionImageView.sd_setImage(with: url)
        }
        self.timer?.invalidate()
        self.runCountdown()
    }
    
    func setupView() {
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.instructionStackView)
        self.containerView.addSubview(self.contentView)
        
        
        self.contentView.addSubview(self.questionImageView)
        self.contentView.addSubview(self.questionTitleLabel)
        self.contentView.addSubview(self.quizOptionsTableView)
        
        self.titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true

        self.instructionStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24).isActive = true
        self.instructionStackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 50).isActive = true
        self.instructionStackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -50).isActive = true

        let verticalStackView = UIStackView(frame: .zero)
        verticalStackView.axis = .vertical
        verticalStackView.addArrangedSubview(self.questionNumberLabel)
        verticalStackView.addArrangedSubview(self.marksLabel)
        self.questionNumberLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        let emptyView = UIView(frame: .zero)
        emptyView.widthAnchor.constraint(equalToConstant: 40).isActive = true

        let horizantalStackView = UIStackView(frame: .zero)
        horizantalStackView.axis = .horizontal
        horizantalStackView.addArrangedSubview(emptyView)
        horizantalStackView.addArrangedSubview(self.clockImageView)
        horizantalStackView.addArrangedSubview(self.timerLabel)
        horizantalStackView.spacing = 8


        self.clockImageView.widthAnchor.constraint(equalToConstant: 46).isActive = true
        self.clockImageView.heightAnchor.constraint(equalToConstant: 46).isActive = true

        self.instructionStackView.addArrangedSubview(verticalStackView)
        self.instructionStackView.addArrangedSubview(horizantalStackView)
        
        self.contentView.topAnchor.constraint(equalTo: self.instructionStackView.bottomAnchor,
                                              constant: 16).isActive = true
        self.contentView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 50).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                              constant: -50).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                 constant: -16).isActive = true
        

        self.questionImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                              constant: 8).isActive = true
        self.questionImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.questionImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        self.questionImageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        self.questionTitleLabel.topAnchor.constraint(equalTo: self.self.questionImageView.bottomAnchor,
                                              constant: 8).isActive = true
        self.questionTitleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.questionTitleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        self.questionTitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        self.quizOptionsTableView.topAnchor.constraint(equalTo: self.questionTitleLabel.bottomAnchor,
                                                       constant: 8).isActive = true
        self.quizOptionsTableView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.quizOptionsTableView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        self.quizOptionsTableView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        
        self.quizOptionsTableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                     constant: -8).isActive = true
    }
    
    override func reloadView() {
        super.reloadView()
        
        self.titleLabel.text = ""
        self.questionNumberLabel.text = "Question \(self.viewModel.questionNumber + 1) of \(self.viewModel.questions.count)"
        self.marksLabel.text = "Marks: \(self.viewModel.currentQuestion.maxPoints ?? 0)"
        self.timerLabel.text = "\(self.viewModel.currentQuestion.timeLimit ?? 0)"
        self.questionTitleLabel.text = self.viewModel.currentQuestion.questionText
        if let urlString = self.viewModel.currentQuestion.imageURL,
           let url = URL(string: urlString) {
            self.questionImageView.sd_setImage(with: url)
        }
        self.quizOptionsTableView.reloadData()
        self.countDown = 0
        self.timer?.invalidate()
        self.runCountdown()
    }
}

extension QuizViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.questions[self.viewModel.questionNumber].mcqOptions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell") as? QuizTableViewCell ?? QuizTableViewCell()
        cell.selectionStyle = .blue
        cell.setData(text: self.viewModel.currentQuestion.mcqOptions?[indexPath.row].text ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.answerSelected(index: indexPath.row)
    }
}

extension QuizViewController {
    
    @objc private func updateTime() {
        if self.countDown == self.viewModel.currentQuestion.timeLimit ?? 0 {
            self.viewModel.timeLimitExceeded()
        }
        self.countDown += 1
        let timeRemaining = (self.viewModel.currentQuestion.timeLimit ?? 0) - self.countDown
        self.timerLabel.text = "\(timeRemaining)"
    }

    private func runCountdown() {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
}
