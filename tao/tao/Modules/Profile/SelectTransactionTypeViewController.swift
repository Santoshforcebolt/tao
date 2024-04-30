//
//  SelectTransactionTypeViewController.swift
//  tao
//
//  Created by Mayank Khursija on 01/07/22.
//

import Foundation
import UIKit

class SelectTransactionTypeViewController: BaseViewController<SelectTransactionTypeViewModel> {
    
    var navigationBar: UINavigationBar?
    var amazonOptionView: ProfileOptionView = {
        let view = ProfileOptionView(renderData: ProfileOptionView.RenderData(imageWidth: 32,
                                                                              font: UIFont(name: "Poppins", size: 24),
                                                                              customSpacing: 24,
                                                                              height: 40,
                                                                              showRightIcon: false,
                                                                              showLeftIcon: true))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var moneyOptionView: ProfileOptionView = {
        let view = ProfileOptionView(renderData: ProfileOptionView.RenderData(imageWidth: 32,
                                                                              font: UIFont(name: "Poppins", size: 24),
                                                                              customSpacing: 24,
                                                                              height: 40,
                                                                              showRightIcon: false,
                                                                              showLeftIcon: true))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(_ viewModel: SelectTransactionTypeViewModel) {
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
        
        self.amazonOptionView.setupData(image: .withImage(UIImage(systemName: "clock")!), text: "Amazon Voucher")
        self.moneyOptionView.setupData(image: .withImage(UIImage(named: "cash")!), text: "Withdraw Money")
        
        self.amazonOptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(amazonOptionSelected)))
        self.moneyOptionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moneyOptionSelected)))
    }
    
    @objc func amazonOptionSelected() {
        self.viewModel.tapOnItem(transactionType: .amazonCard)
    }
    
    @objc func moneyOptionSelected() {
        self.viewModel.tapOnItem(transactionType: .money)
    }
    
    override func backAction() {
        super.backAction()
        self.viewModel.backButtonTapped()
    }
    
    func setupView() {
//        self.containerView.addSubview(self.amazonOptionView)
        self.containerView.addSubview(self.moneyOptionView)
        
//        self.amazonOptionView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
//                                                   constant: 32).isActive = true
//        self.amazonOptionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
//                                                   constant: 32).isActive = true
//        self.amazonOptionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
//                                                   constant: -32).isActive = true
//        self.amazonOptionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        
        self.moneyOptionView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
                                                   constant: 16).isActive = true
        self.moneyOptionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                   constant: 32).isActive = true
        self.moneyOptionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                   constant: -32).isActive = true
        self.moneyOptionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.moneyOptionView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                     constant: -32).isActive = true
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
        
        let navigationItem = UINavigationItem(title: "Select Transaction Type")
        
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
}
