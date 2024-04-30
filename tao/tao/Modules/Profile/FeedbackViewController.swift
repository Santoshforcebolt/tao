//
//  FeedbackViewController.swift
//  tao
//
//  Created by Mayank Khursija on 12/08/22.
//

import Foundation

class FeedbackViewController: BaseViewController<FeedbackViewModel> {
    var navigationBar: UINavigationBar?
    
    var stateImageView: UIImageView = {
        let uiImageView = UIImageView(frame: .zero)
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    } ()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    } ()
    
    var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    } ()
    
    var feedbackTextField: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.font = UIFont(name: "Poppins", size: 12)
        textView.borderWidth = 2
        textView.borderColor = .lightGray
        return textView
    }()
    
    var submitButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    override init(_ viewModel: FeedbackViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNavigationBar()
        self.setupView()
        
        self.stateImageView.image = UIImage(named: "feedback_")
        self.titleLabel.text = "Please provide feedback"
        
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.setTitleColor(.black, for: .normal)
        self.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    @objc func submitButtonTapped() {
        self.viewModel.submitButtonTapped(text: self.feedbackTextField.text)
    }
    
    func setupView() {
        self.containerView.addSubview(self.stateImageView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.feedbackTextField)
        
        self.stateImageView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.containerView.topAnchor,
                                              constant: 32).isActive = true
        self.stateImageView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 32).isActive = true
        self.stateImageView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                              constant: -32).isActive = true
        self.stateImageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.stateImageView.bottomAnchor, constant: 24).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true

        self.feedbackTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16).isActive = true
        self.feedbackTextField.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        self.feedbackTextField.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        self.feedbackTextField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        self.containerView.addSubview(self.submitButton)
        self.submitButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.submitButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.submitButton.topAnchor.constraint(equalTo: self.feedbackTextField.bottomAnchor,
                                               constant: 30).isActive = true
        self.submitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.submitButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                    constant: -16).isActive = true
        
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: .zero)
        self.navigationBar = navigationBar
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        
        
        navigationBar.layer.masksToBounds = false
        navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationBar.layer.shadowOpacity = 0.8
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.layer.shadowRadius = 2
        
        
        navigationBar.titleTextAttributes = [.font : UIFont(name: "Poppins-Medium", size: 18)!]
        
        self.containerView.addSubview(navigationBar)
        
        navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let navigationItem = UINavigationItem(title: "Feedback")
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backbutton.backgroundColor = .lightBlueBackground
        backbutton.layer.cornerRadius = 8
        backbutton.tintColor = .black
        backbutton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        backbutton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func backAction() {
        super.backAction()
        self.viewModel.backButtonTapped()
    }
}