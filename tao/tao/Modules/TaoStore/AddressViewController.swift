//
//  AddressViewController.swift
//  tao
//
//  Created by Mayank Khursija on 07/06/22.
//

import Foundation

class AddressViewController: BaseViewController<AddressViewModel> {
    
    var navigationBar: UINavigationBar?
    
    var houseNoTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 12)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        return textField
    }()
    
    var colonyNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 12)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        return textField
    }()
    
    var districtTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 12)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        return textField
    }()
    
    var pinCodeTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 12)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.keyboardType = .numberPad
        return textField
    }()
    
    var stateTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 12)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        return textField
    }()
    
    var phoneNumberTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 12)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.keyboardType = .numberPad
        return textField
    }()
    
    var countryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var addNewAddress: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var houseNo = ""
    var street = ""
    var district = ""
    var pinCode = ""
    var state = ""
    var phoneNumber = ""
    var country = "India"
    
    override init(_ viewModel: AddressViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.enableScrollView = false //IQKeyboardManager having problem with scrollView
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setupNavigationBar()
        self.setupView()
        
        self.houseNoTextField.setLeftIcon(UIImage(systemName: "house")!, size: 16)
        self.colonyNameTextField.setLeftIcon(UIImage(named: "calendar")!, size: 16)
        self.districtTextField.setLeftIcon(UIImage(named: "calendar")!, size: 16)
        self.pinCodeTextField.setLeftIcon(UIImage(named: "calendar")!, size: 16)
        self.stateTextField.setLeftIcon(UIImage(named: "calendar")!, size: 16)
        self.phoneNumberTextField.setLeftIcon(UIImage(systemName: "phone")!, size: 16)
        self.countryLabel.text = "Country: India"
        
        switch self.viewModel.action {
        case .add:
            self.addNewAddress.setTitle("Add Address", for: .normal)
        case .edit(_):
            self.addNewAddress.setTitle("Update Address", for: .normal)
        }
        
        self.addNewAddress.addTarget(self, action: #selector(addNewAddressTapped), for: .touchUpInside)
        
        
        self.houseNoTextField.placeholder = self.viewModel.address?.house ?? "House/Building no."
        self.colonyNameTextField.placeholder = self.viewModel.address?.street ?? "Road name, Area, Colony"
        self.districtTextField.placeholder = self.viewModel.address?.district ?? "District"
        if let pinCode = self.viewModel.address?.pin {
            self.pinCodeTextField.placeholder = "\(pinCode)"
        } else {
            self.pinCodeTextField.placeholder = "Pin"
        }
        self.stateTextField.placeholder = self.viewModel.address?.state ?? "State"
        self.phoneNumberTextField.placeholder = self.viewModel.address?.phone ?? "Phone Number"
        
        
        self.houseNo = self.viewModel.address?.house ?? ""
        self.street = self.viewModel.address?.street ?? ""
        self.district = self.viewModel.address?.district ?? ""
        if let pinCode = self.viewModel.address?.pin {
            self.pinCode = "\(pinCode)"
        }
        self.state = self.viewModel.address?.state ?? ""
        self.phoneNumber = self.viewModel.address?.phone ?? ""
        
        self.houseNoTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        self.colonyNameTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        self.districtTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        self.pinCodeTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        self.stateTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        self.phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
    }
    
    func setupView() {
        self.view.addSubview(self.houseNoTextField)
        self.view.addSubview(self.colonyNameTextField)
        self.view.addSubview(self.districtTextField)
        self.view.addSubview(self.pinCodeTextField)
        self.view.addSubview(self.stateTextField)
        self.view.addSubview(self.phoneNumberTextField)
        self.view.addSubview(self.countryLabel)
        self.view.addSubview(self.addNewAddress)
        
        self.houseNoTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        self.houseNoTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        self.houseNoTextField.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor, constant: 16).isActive = true
        self.houseNoTextField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        self.colonyNameTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                       constant: 16).isActive = true
        self.colonyNameTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                        constant: -16).isActive = true
        self.colonyNameTextField.topAnchor.constraint(equalTo: self.houseNoTextField.bottomAnchor,
                                                      constant: 16).isActive = true
        self.colonyNameTextField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        
        self.districtTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                       constant: 16).isActive = true
        self.districtTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                        constant: -16).isActive = true
        self.districtTextField.topAnchor.constraint(equalTo: self.colonyNameTextField.bottomAnchor,
                                                      constant: 16).isActive = true
        self.districtTextField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        self.pinCodeTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                       constant: 16).isActive = true
        self.pinCodeTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                        constant: -16).isActive = true
        self.pinCodeTextField.topAnchor.constraint(equalTo: self.districtTextField.bottomAnchor,
                                                      constant: 16).isActive = true
        self.pinCodeTextField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        let countryImageView = UIImageView(frame: .zero)
        countryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        countryImageView.image = UIImage(named: "calendar")
        self.view.addSubview(countryImageView)
        
        countryImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24).isActive = true
        countryImageView.topAnchor.constraint(equalTo: self.pinCodeTextField.bottomAnchor, constant: 20).isActive = true
        countryImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        countryImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        self.countryLabel.leftAnchor.constraint(equalTo: countryImageView.rightAnchor,
                                                       constant: 16).isActive = true
        self.countryLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                        constant: -16).isActive = true
        self.countryLabel.topAnchor.constraint(equalTo: self.pinCodeTextField.bottomAnchor,
                                                      constant: 16).isActive = true
        
        self.stateTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                       constant: 16).isActive = true
        self.stateTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                        constant: -16).isActive = true
        self.stateTextField.topAnchor.constraint(equalTo: countryImageView.bottomAnchor,
                                                      constant: 16).isActive = true
        self.stateTextField.heightAnchor.constraint(equalToConstant: 52).isActive = true

        self.phoneNumberTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                       constant: 16).isActive = true
        self.phoneNumberTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                        constant: -16).isActive = true
        self.phoneNumberTextField.topAnchor.constraint(equalTo: self.stateTextField.bottomAnchor,
                                                      constant: 16).isActive = true
        self.phoneNumberTextField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        self.addNewAddress.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        self.addNewAddress.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        self.addNewAddress.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        self.addNewAddress.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc func addNewAddressTapped() {
        if self.phoneNumber.isEmpty || self.houseNo.isEmpty || self.street.isEmpty || self.district.isEmpty || self.state.isEmpty || self.country.isEmpty || self.pinCode.isEmpty {
            
        } else {
            let id: String
            switch self.viewModel.action {
            case .add:
                id = ""
            case .edit(let address):
                id = address.id ?? ""
            }
            let address = Address(country: self.country,
                                  district: self.district,
                                  house: self.houseNo,
                                  id: id,
                                  phone: self.phoneNumber,
                                  pin: Int(self.pinCode) ?? 0,
                                  state: self.state,
                                  street: self.street)
            self.viewModel.addNewAddressTapped(address: address)
        }
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
        
        let title: String
        switch self.viewModel.action {
        case .add:
            title = "Add Address"
        case .edit(_):
            title = "Edit Address"
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
    
    @objc func textFieldDidChange(sender: UITextField) {
        if sender == self.houseNoTextField {
            self.houseNo = sender.text ?? ""
        } else if sender == self.colonyNameTextField {
            self.street = sender.text ?? ""
        } else if sender == self.districtTextField {
            self.district = sender.text ?? ""
        } else if sender == self.stateTextField {
            self.state = sender.text ?? ""
        } else if sender == self.pinCodeTextField {
            self.pinCode = sender.text ?? ""
        } else if sender == self.phoneNumberTextField {
            self.phoneNumber = sender.text ?? ""
        }
    }
}
