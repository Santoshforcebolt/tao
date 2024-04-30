//
//  SupportViewController.swift
//  tao
//
//  Created by Mayank Khursija on 12/08/22.
//

import Foundation

class SupportViewController: BaseViewController<SupportViewModel> {
    var navigationBar: UINavigationBar?
    
    var stateImageView: UIImageView = {
        let uiImageView = UIImageView(frame: .zero)
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    } ()
    
    override init(_ viewModel: SupportViewModel) {
        super.init(viewModel)
    }
    
    var whatsappButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemGreen
        return button
    }()
    
    var emailButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var phoneButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNavigationBar()
        self.setupView()

        self.stateImageView.image = UIImage(named: "customer_support")
        self.whatsappButton.setTitle("Whatsapp", for: .normal)
        self.whatsappButton.addTarget(self, action: #selector(whatsappTapped), for: .touchUpInside)
        
        self.emailButton.setTitle("support@tao.live", for: .normal)
        self.emailButton.addTarget(self, action: #selector(emailTapped), for: .touchUpInside)
        self.emailButton.setImage(UIImage(systemName: "mail")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.emailButton.tintColor = .white
        self.emailButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        
        self.phoneButton.setTitle("8095563666", for: .normal)
        self.phoneButton.addTarget(self, action: #selector(phoneTapped), for: .touchUpInside)
        self.phoneButton.setImage(UIImage(systemName: "phone")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.phoneButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        self.phoneButton.tintColor = .white
    }
    
    @objc func whatsappTapped() {
        self.viewModel.openWhatsapp()
    }

    @objc func emailTapped() {
        self.viewModel.openEmail()
    }
    
    @objc func phoneTapped() {
        self.viewModel.openPhone()
    }
    
    func setupView() {
        self.containerView.addSubview(self.stateImageView)
        self.containerView.addSubview(self.whatsappButton)
        self.containerView.addSubview(self.emailButton)
        self.containerView.addSubview(self.phoneButton)
        
        self.stateImageView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.containerView.topAnchor,
                                              constant: 32).isActive = true
        self.stateImageView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 32).isActive = true
        self.stateImageView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                              constant: -32).isActive = true
        self.stateImageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        self.whatsappButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.whatsappButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.whatsappButton.topAnchor.constraint(equalTo: self.stateImageView.bottomAnchor,
                                               constant: 30).isActive = true
        self.whatsappButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.emailButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.emailButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.emailButton.topAnchor.constraint(equalTo: self.whatsappButton.bottomAnchor,
                                               constant: 30).isActive = true
        self.emailButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.phoneButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.phoneButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.phoneButton.topAnchor.constraint(equalTo: self.emailButton.bottomAnchor,
                                               constant: 30).isActive = true
        self.phoneButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.phoneButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
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
        
        let navigationItem = UINavigationItem(title: "Support")
        
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
