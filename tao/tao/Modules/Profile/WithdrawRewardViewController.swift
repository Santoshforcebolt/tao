//
//  WithdrawRewardViewController.swift
//  tao
//
//  Created by Mayank Khursija on 28/06/22.
//

import Foundation

class WithdrawRewardViewController: BaseViewController<WithdrawRewardViewModel> {
    var moneyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins-Bold", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var moneyHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var enterAmountTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 12)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.placeholder = "Enter Withdrawl Amount"
        return textField
    }()
    
    var enterUpiIdTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 12)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.placeholder = "Enter UPI ID"
        return textField
    }()
    
    var withdrawButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var infoView: ProfileOptionView = {
        let infoView = ProfileOptionView(renderData: ProfileOptionView.RenderData(
            imageWidth: 24,
            font: UIFont(name: "Poppins", size: 14),
            customSpacing: 12,
            height: 28,
            showRightIcon: false))
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    var instructionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var moneyCardView = UIStackView(frame: .zero)
    var navigationBar: UINavigationBar?
    
    override init(_ viewModel: WithdrawRewardViewModel) {
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
        
        self.moneyHeaderLabel.text = "Scholarships Cash"
        self.moneyLabel.text = "₹ \(self.viewModel.walletDetails.balanceDetails?.rewardsCashBalance ?? 0)"
        
        self.enterAmountTextField.setLeftIcon(UIImage(systemName: "house")!, size: 16)
        self.enterUpiIdTextField.setLeftIcon(UIImage(systemName: "house")!, size: 16)
        
        self.withdrawButton.setTitle("Withdraw", for: .normal)
        self.infoView.setupData(image: .withImage(UIImage(systemName: "info.circle.fill")!), text: "Info")
        self.moneyCardView.cornerRadius = 16
        
        self.instructionLabel.text = "In you face any problems, contact our customer support"
        
        self.withdrawButton.addTarget(self, action: #selector(withdrawButtonTapped), for: .touchUpInside)
    }
    
    @objc func withdrawButtonTapped() {
        self.viewModel.withdrawButtonTapped(vpa: self.enterUpiIdTextField.text ?? "",
                                            amount: Int(self.enterAmountTextField.text ?? "") ?? 0)
    }
    
    func setupView() {
        self.moneyCardView.translatesAutoresizingMaskIntoConstraints = false
        self.moneyCardView.axis = .vertical
        
        self.containerView.addSubview(self.moneyCardView)
        self.moneyCardView.addArrangedSubview(self.moneyHeaderLabel)
        self.moneyCardView.addArrangedSubview(self.moneyLabel)
        
        self.moneyCardView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.containerView.topAnchor,
                                              constant: 24).isActive = true
        self.moneyCardView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 32).isActive = true
        self.moneyCardView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                               constant: -32).isActive = true
        self.moneyCardView.heightAnchor.constraint(equalToConstant: 112).isActive = true
        self.moneyCardView.backgroundColor = .systemGreen

        
        self.moneyCardView.layoutMargins = UIEdgeInsets.init(top: 16, left: 0, bottom: 16, right: 0)
        self.moneyCardView.isLayoutMarginsRelativeArrangement = true

        self.moneyHeaderLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        self.containerView.addSubview(self.enterAmountTextField)
        
        self.enterAmountTextField.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 32).isActive = true
        self.enterAmountTextField.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -32).isActive = true
        self.enterAmountTextField.topAnchor.constraint(equalTo: self.moneyCardView.bottomAnchor, constant: 32).isActive = true
        self.enterAmountTextField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        self.containerView.addSubview(self.enterUpiIdTextField)
        
        self.enterUpiIdTextField.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 32).isActive = true
        self.enterUpiIdTextField.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -32).isActive = true
        self.enterUpiIdTextField.topAnchor.constraint(equalTo: self.enterAmountTextField.bottomAnchor, constant: 16).isActive = true
        self.enterUpiIdTextField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        self.containerView.addSubview(self.withdrawButton)
        
        self.withdrawButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 32).isActive = true
        self.withdrawButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -32).isActive = true
        self.withdrawButton.topAnchor.constraint(equalTo: self.enterUpiIdTextField.bottomAnchor, constant: 32).isActive = true
        self.withdrawButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let informationView = UIStackView(frame: .zero)
        informationView.translatesAutoresizingMaskIntoConstraints = false
        informationView.axis = .vertical
        informationView.backgroundColor = .grayBackground
        informationView.cornerRadius = 16
        
        informationView.layoutMargins = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        informationView.isLayoutMarginsRelativeArrangement = true
        
        self.containerView.addSubview(informationView)
        
        informationView.addArrangedSubview(self.infoView)
        informationView.addArrangedSubview(self.instructionLabel)
        
        informationView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 32).isActive = true
        informationView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -32).isActive = true
        informationView.topAnchor.constraint(equalTo: self.withdrawButton.bottomAnchor, constant: 32).isActive = true
        
        informationView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16).isActive = true
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
        
        let title: String
        switch self.viewModel.transactionType {
        case .amazonCard:
            title = "Amazon Voucher"
        case .money:
            title = "Withdraw Cash"
        }
        let navigationItem = UINavigationItem(title: title)
        
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
