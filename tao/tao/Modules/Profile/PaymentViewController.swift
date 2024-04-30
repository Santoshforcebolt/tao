//
//  PaymentViewController.swift
//  tao
//
//  Created by Mayank Khursija on 17/07/22.
//

import Foundation
import Razorpay

class PaymentViewController: BaseViewController<PaymentViewModel> {
    
    var navigationBar: UINavigationBar?
    var razorpay: RazorpayCheckout?
    
    var planView: SubscriptionView = {
        let currentPlanView = SubscriptionView(frame: .zero)
        currentPlanView.translatesAutoresizingMaskIntoConstraints = false
        currentPlanView.backgroundColor = .systemBlue
        currentPlanView.cornerRadius = 12
        return currentPlanView
    }()
    
    var amountPayableLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    } ()
    
    var payUsingTaoButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var payUsingRazorpayButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var payUsingCashOption: ProfileOptionView = {
        let renderData = ProfileOptionView.RenderData(height: 40, showRightIcon: false)
        let payUsingCashOption = ProfileOptionView(renderData: renderData)
        payUsingCashOption.translatesAutoresizingMaskIntoConstraints = false
        return payUsingCashOption
    }()
    
    var payUsingTaoOption: ProfileOptionView = {
        let renderData = ProfileOptionView.RenderData(height: 40, showRightIcon: false)
        let payUsingCashOption = ProfileOptionView(renderData: renderData)
        payUsingCashOption.translatesAutoresizingMaskIntoConstraints = false
        return payUsingCashOption
    }()
    
    var enableAutoSubscribeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
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
    
    override init(_ viewModel: PaymentViewModel) {
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
        
        self.planView.setup(title: self.viewModel.planDetails.name ?? "",
                            price: "₹\(self.viewModel.planDetails.discountedPrice ?? 0)",
                            discountedPrice: "₹\(self.viewModel.planDetails.price ?? 0)",
                            validity: "Eligible for \(self.viewModel.planDetails.durationDays ?? 0) days")
        
        self.amountPayableLabel.text = "Amount Payable: ₹\(self.viewModel.planDetails.discountedPrice ?? 0)"
        self.payUsingRazorpayButton.setTitle("Pay ₹\(self.viewModel.planDetails.discountedPrice ?? 0)", for: .normal)
        self.payUsingCashOption.setupData(image: .withImage(UIImage(systemName: "creditcard")!), text: "Pay Using UPI/Cards")
        self.payUsingTaoOption.setupData(image: .withImage(UIImage(systemName: "wallet.pass")!), text: "Pay Using Tao Cash")
        self.payUsingTaoButton.setTitle("Pay ₹\(self.viewModel.planDetails.discountedPrice ?? 0)", for: .normal)
        self.enableAutoSubscribeButton.setTitle("Enable Auto Subcscibe", for: .normal)
        
        self.payUsingTaoButton.addTarget(self, action: #selector(payUsingTaoCashTapped), for: .touchUpInside)
        self.payUsingRazorpayButton.addTarget(self, action: #selector(payUsingRazorpayButtonTapped), for: .touchUpInside)
        self.infoView.setupData(image: .withImage(UIImage(systemName: "info.circle.fill")!), text: "Info")
        self.instructionLabel.text = "If payment is done and subscription is not active. Please contact support to start subscription or get money back to your account."
    }
    
    @objc func payUsingRazorpayButtonTapped() {
        self.viewModel.payWithRazorpayTapped(completion: {
            self.razorpay = RazorpayCheckout.initWithKey(self.viewModel.inTransitOrder?.partnerKeyId ?? "", andDelegate: self)
            let options: [String:Any] = [
                "amount": "\(self.viewModel.planDetails.discountedPrice ?? 0 * 100)", //This is in currency subunits. 100 = 100 paise= INR 1.
                "order_id": "\(self.viewModel.inTransitOrder?.partnerOrderId ?? "")",
                "name": "Tao",
                "currency": "INR",
                "key": self.viewModel.inTransitOrder?.partnerKeyId ?? ""
            ]
            self.razorpay?.open(options)
        })
    }
    
    @objc func payUsingTaoCashTapped() {
        self.viewModel.payWithTaoCashTapped()
    }
    
    func setupView() {
        self.containerView.addSubview(self.planView)
        self.containerView.addSubview(self.amountPayableLabel)
        
        self.planView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.containerView.topAnchor,
                                           constant: 8).isActive = true
        self.planView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        self.planView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        self.planView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.amountPayableLabel.topAnchor.constraint(equalTo: self.planView.bottomAnchor,
                                           constant: 8).isActive = true
        self.amountPayableLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        self.amountPayableLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        
        let payUsingCashView = UIView(frame: .zero)
        payUsingCashView.translatesAutoresizingMaskIntoConstraints = false
        payUsingCashView.backgroundColor = .grayBackground
        payUsingCashView.cornerRadius = 12
        
        payUsingCashView.addSubview(self.payUsingCashOption)
        payUsingCashView.addSubview(self.payUsingRazorpayButton)
        
        self.payUsingCashOption.leftAnchor.constraint(equalTo: payUsingCashView.leftAnchor, constant: 16).isActive = true
        self.payUsingCashOption.rightAnchor.constraint(equalTo: payUsingCashView.rightAnchor, constant: -16).isActive = true
        self.payUsingCashOption.topAnchor.constraint(equalTo: payUsingCashView.topAnchor, constant: 8).isActive = true
        self.payUsingCashOption.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.payUsingRazorpayButton.topAnchor.constraint(equalTo: self.payUsingCashOption.bottomAnchor, constant: 8).isActive = true
        self.payUsingRazorpayButton.leftAnchor.constraint(equalTo: payUsingCashView.leftAnchor, constant: 16).isActive = true
        self.payUsingRazorpayButton.rightAnchor.constraint(equalTo: payUsingCashView.rightAnchor, constant: -16).isActive = true
        self.payUsingRazorpayButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        self.containerView.addSubview(payUsingCashView)
        
        payUsingCashView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        payUsingCashView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        payUsingCashView.topAnchor.constraint(equalTo: self.amountPayableLabel.bottomAnchor,
                                              constant: 16).isActive = true
        payUsingCashView.heightAnchor.constraint(equalToConstant: 116).isActive = true
        
        let payUsingTaoView = UIView(frame: .zero)
        payUsingTaoView.translatesAutoresizingMaskIntoConstraints = false
        payUsingTaoView.backgroundColor = .grayBackground
        payUsingTaoView.cornerRadius = 12
        
        payUsingTaoView.addSubview(self.payUsingTaoOption)
        payUsingTaoView.addSubview(self.enableAutoSubscribeButton)
        payUsingTaoView.addSubview(self.payUsingTaoButton)
        
        self.payUsingTaoOption.leftAnchor.constraint(equalTo: payUsingTaoView.leftAnchor, constant: 16).isActive = true
        self.payUsingTaoOption.rightAnchor.constraint(equalTo: payUsingTaoView.rightAnchor, constant: -16).isActive = true
        self.payUsingTaoOption.topAnchor.constraint(equalTo: payUsingTaoView.topAnchor, constant: 8).isActive = true
        self.payUsingTaoOption.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.enableAutoSubscribeButton.topAnchor.constraint(equalTo: self.payUsingTaoOption.bottomAnchor, constant: 8).isActive = true
        self.enableAutoSubscribeButton.leftAnchor.constraint(equalTo: payUsingTaoView.leftAnchor, constant: 16).isActive = true
        self.enableAutoSubscribeButton.rightAnchor.constraint(equalTo: payUsingTaoView.rightAnchor, constant: -16).isActive = true
        self.enableAutoSubscribeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.payUsingTaoButton.topAnchor.constraint(equalTo: self.enableAutoSubscribeButton.bottomAnchor, constant: 8).isActive = true
        self.payUsingTaoButton.leftAnchor.constraint(equalTo: payUsingTaoView.leftAnchor, constant: 16).isActive = true
        self.payUsingTaoButton.rightAnchor.constraint(equalTo: payUsingTaoView.rightAnchor, constant: -16).isActive = true
        self.payUsingTaoButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        self.containerView.addSubview(payUsingTaoView)
        
        payUsingTaoView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        payUsingTaoView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        payUsingTaoView.topAnchor.constraint(equalTo: payUsingCashView.bottomAnchor,
                                              constant: 16).isActive = true
        payUsingTaoView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
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
        
        informationView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        informationView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        informationView.topAnchor.constraint(equalTo: payUsingTaoView.bottomAnchor, constant: 32).isActive = true
        
        informationView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16).isActive = true
        
    }
    
    override func backAction() {
        super.backAction()
        self.viewModel.backButtonTapped()
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
        
        //MARK: For IQKeyboardManager we need to add it to container view instead view itself.
        self.containerView.addSubview(navigationBar)
        
        navigationBar.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let navigationItem = UINavigationItem(title: "Payment")
        
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

extension PaymentViewController: RazorpayPaymentCompletionProtocol {
    func onPaymentError(_ code: Int32, description str: String) {
        print("Error \(code)")
        print(description)
        self.viewModel.paymentFailedWithRazorpay()
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("Success Payment")
        print(payment_id)
        self.viewModel.paymentCompletedWithRazorpay(paymentId: payment_id)
    }
}
