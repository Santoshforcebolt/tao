//
//  UserBlockedViewController.swift
//  tao
//
//  Created by Mayank Khursija on 13/07/22.
//

import Foundation

class UserBlockedViewController: BaseViewController<UserBlockedViewModel> {
    
    var blockTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var unblockButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var navigationBar: UINavigationBar?
    
    override init(_ viewModel: UserBlockedViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.enableScrollView = false
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNavigationBar()
        self.setupView()
        
        self.blockTitleLabel.text = "You have blocked this user!"
        self.unblockButton.setTitle("Unblock", for: .normal)
        self.unblockButton.addTarget(self, action: #selector(unblockTapped), for: .touchUpInside)
    }
    
    @objc func unblockTapped() {
        self.viewModel.unBlockTapped()
    }
    
    func setupView() {
        self.view.addSubview(self.blockTitleLabel)
        self.view.addSubview(self.unblockButton)
        
        self.blockTitleLabel.topAnchor.constraint(
            equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
            constant: 32).isActive = true
        self.blockTitleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        self.blockTitleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        
        self.unblockButton.topAnchor.constraint(equalTo: self.blockTitleLabel.bottomAnchor,
                                                constant: 32).isActive = true
        self.unblockButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        self.unblockButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        self.unblockButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
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
        
        self.view.addSubview(navigationBar)
        
        navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let navigationItem = UINavigationItem(title: "Profile")
        
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
