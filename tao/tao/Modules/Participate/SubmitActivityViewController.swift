//
//  SubmitActivityViewController.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

class SubmitActivityViewController: BaseViewController<SubmitActivityViewModel> {
    
    var contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        return contentView
    } ()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var instructionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var submitButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        return button
    }()

    
    override init(_ viewModel: SubmitActivityViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        switch self.viewModel.competition {
        case .extraCurricular:
            self.view.backgroundColor = .newDarkBlueBackground
            self.submitButton.backgroundColor = .newDarkBlueBackground
            self.titleLabel.text = "Congratulations"
            self.instructionLabel.text = "Your entry has been submitted!"
            self.submitButton.setTitle("Go to Home", for: .normal)
        case .academic:
            self.view.backgroundColor = .blueBackground
            self.submitButton.backgroundColor = .blueBackground
            self.titleLabel.text = "Congratulations"
            self.instructionLabel.text = "Your Quiz is now complete"
            self.submitButton.setTitle("Submit", for: .normal)
        }
        self.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    func setupView() {
        self.containerView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.instructionLabel)
        self.contentView.addSubview(self.submitButton)
        
        self.contentView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 50).isActive = true
        self.contentView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                              constant: -50).isActive = true
        self.contentView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.contentView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                 constant: -16).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                              constant: 8).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        
        self.instructionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                              constant: 8).isActive = true
        self.instructionLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.instructionLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        
        self.submitButton.topAnchor.constraint(equalTo: self.instructionLabel.bottomAnchor,
                                              constant: 72).isActive = true
        self.submitButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 32).isActive = true
        self.submitButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -32).isActive = true
        self.submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.submitButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                                     constant: -24).isActive = true
    }
    
    @objc func submitButtonTapped() {
        self.viewModel.submitButtonTapped()
    }
}
