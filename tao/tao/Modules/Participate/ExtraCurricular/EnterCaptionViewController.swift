//
//  EnterCaptionViewController.swift
//  tao
//
//  Created by Mayank Khursija on 01/06/22.
//

import Foundation
import UIKit

class EnterCaptionViewController: BaseViewController<EnterCaptionViewModel> {
    
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
    
    var captionTextField: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.font = UIFont(name: "Poppins", size: 12)
        textView.borderWidth = 2
        textView.borderColor = .lightGray
        return textView
    }()
    
    var submitVideoButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .newDarkBlueBackground
        return button
    }()
    
    override init(_ viewModel: EnterCaptionViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .newDarkBlueBackground
        
        self.setupView()
        
        self.bannerImageView.image = UIImage(systemName: "clock")!
        self.titleLabel.text = "Add a Caption"
        self.submitVideoButton.setTitle("Submit", for: .normal)
        self.submitVideoButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableBackButtonNavigationBar()
    }
    
    func setupView() {
        self.containerView.addSubview(self.contentView)
        
        self.contentView.addSubview(self.bannerImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.captionTextField)
        self.contentView.addSubview(self.submitVideoButton)
                
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
        
        self.captionTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                              constant: 24).isActive = true
        self.captionTextField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 8).isActive = true
        self.captionTextField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -8).isActive = true
        self.captionTextField.heightAnchor.constraint(equalToConstant: 132).isActive = true
        
        self.submitVideoButton.topAnchor.constraint(equalTo: self.captionTextField.bottomAnchor,
                                              constant: 24).isActive = true
        self.submitVideoButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                               constant: 32).isActive = true
        self.submitVideoButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                              constant: -32).isActive = true
        self.submitVideoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.submitVideoButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -24).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
    }
    
    @objc func submitButtonTapped() {
        self.viewModel.submitButtonTapped(text: self.captionTextField.text)
    }
    
    override func backAction() {
        super.backAction()
        self.viewModel.backButtonTapped()
    }
}
