//
//  OrderDetailsViewController.swift
//  tao
//
//  Created by Mayank Khursija on 05/06/22.
//

import Foundation

class OrderDetailsViewController: BaseViewController<OrderDetailsViewModel> {
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var orderDetails: OrderDetailsView = {
        let orderDetails = OrderDetailsView()
        orderDetails.translatesAutoresizingMaskIntoConstraints = false
        return orderDetails
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var cancelRewardButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightBlueBackground
        return button
    }()
    
    var downloadButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var exitButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var navigationBar: UINavigationBar?
    
    override init(_ viewModel: OrderDetailsViewModel) {
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
        
        self.titleLabel.text = self.viewModel.message
        self.orderDetails.setup(product: self.viewModel.product, flow: self.viewModel.flow)
        self.nameLabel.text = "\(TaoHelper.userProfile?.userDetails?.firstName ?? "") \(TaoHelper.userProfile?.userDetails?.lastName ?? "")"
        self.addressLabel.text = self.viewModel.order.orderData?.deliveryAddress
        
        self.cancelRewardButton.setTitle("Cancel Reward", for: .normal)
        self.cancelRewardButton.addTarget(self, action: #selector(cancelRewardButtonTapped), for: .touchUpInside)
        
        self.exitButton.setTitle("Continue Shopping", for: .normal)
        self.exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelRewardButtonTapped() {
        //TODO: Implement
        self.viewModel.cancelButtonTapped()
    }
    
    @objc func exitButtonTapped() {
        self.viewModel.exitButtonTapped()
    }
    
    func setupView() {
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.orderDetails)
        
        self.titleLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 32).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -32).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.containerView.topAnchor, constant: 32).isActive = true
        
        
        self.orderDetails.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                              constant: 24).isActive = true
        self.orderDetails.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 32).isActive = true
        self.orderDetails.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -32).isActive = true
        self.orderDetails.heightAnchor.constraint(equalToConstant: 146).isActive = true
        
        if self.viewModel.isOrderDigital {
            self.containerView.addSubview(self.downloadButton)
            self.downloadButton.setTitle("Download", for: .normal)
            self.downloadButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                    constant: 32).isActive = true
            self.downloadButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                     constant: -32).isActive = true
            self.downloadButton.topAnchor.constraint(equalTo: self.orderDetails.bottomAnchor,
                                                  constant: 32).isActive = true
            self.downloadButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        let addressView = UIView(frame: .zero)
        addressView.translatesAutoresizingMaskIntoConstraints = false
        addressView.backgroundColor = .lightGrayBackground
        addressView.layer.cornerRadius = 16
        
        addressView.addSubview(self.nameLabel)
        addressView.addSubview(self.addressLabel)
        
        self.nameLabel.topAnchor.constraint(equalTo: addressView.topAnchor, constant: 16).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: addressView.leftAnchor, constant: 16).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: addressView.rightAnchor, constant: 16).isActive = true
        
        self.addressLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,
                                               constant: 8).isActive = true
        self.addressLabel.leftAnchor.constraint(equalTo: addressView.leftAnchor, constant: 16).isActive = true
        self.addressLabel.rightAnchor.constraint(equalTo: addressView.rightAnchor, constant: 16).isActive = true
        
        self.containerView.addSubview(addressView)
        
        if self.viewModel.isOrderDigital {
            addressView.topAnchor.constraint(equalTo: self.downloadButton.bottomAnchor,
                                                  constant: 24).isActive = true
            self.downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)

        } else {
            addressView.topAnchor.constraint(equalTo: self.orderDetails.bottomAnchor,
                                                  constant: 24).isActive = true
        }
        addressView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 32).isActive = true
        addressView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -32).isActive = true
        addressView.heightAnchor.constraint(greaterThanOrEqualToConstant: 145).isActive = true
        
        if self.viewModel.order.orderData?.status == "PLACED" {
            self.containerView.addSubview(self.cancelRewardButton)
            
            self.cancelRewardButton.topAnchor.constraint(equalTo: addressView.bottomAnchor,
                                                  constant: 32).isActive = true
            self.cancelRewardButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                    constant: 32).isActive = true
            self.cancelRewardButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                     constant: -32).isActive = true
            self.cancelRewardButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        switch self.viewModel.flow {
        case .store:
            self.containerView.addSubview(self.exitButton)
            
            if self.viewModel.order.orderData?.status == "PLACED" {
                self.exitButton.topAnchor.constraint(equalTo: self.cancelRewardButton.bottomAnchor,
                                                      constant: 16).isActive = true
            } else {
                self.exitButton.topAnchor.constraint(equalTo: addressView.bottomAnchor,
                                                          constant: 16).isActive = true
            }
            self.exitButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                    constant: 32).isActive = true
            self.exitButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                     constant: -32).isActive = true
            self.exitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            self.exitButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true

        case .myOrders:
            if self.viewModel.order.orderData?.status == "PLACED" {
                self.cancelRewardButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
            } else {
                addressView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
            }
        }
    }
    
    @objc func downloadButtonTapped() {
        self.viewModel.downloadButtonTapped()
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: .zero)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        
        self.navigationBar = navigationBar
        
        
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
        
        let navigationItem = UINavigationItem(title: "Order Placed")
        
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
