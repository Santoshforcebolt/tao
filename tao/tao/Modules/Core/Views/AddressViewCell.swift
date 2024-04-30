//
//  AddressViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 05/06/22.
//

import Foundation

protocol AddressViewCellDelegate {
    func claimRewardTapped(address: Address?)
}

protocol ManageAddressViewCellDelegate {
    func editTapped(address: Address?)
    func deleteTapped(address: Address?)
}

enum AddressCellType {
    case order
    case manage
}

class AddressViewCell: UICollectionViewCell {
    
    var delegate: AddressViewCellDelegate?
    var manageDelegate: ManageAddressViewCellDelegate?
    var address: Address?
    
    var radioButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
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
    
    var chooseAddressButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var editAddressButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var deleteAddressButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .white
        button.borderWidth = 1
        button.borderColor = .black
        return button
    }()
    
    var cellType: AddressCellType = .order
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.backgroundColor = .lightGrayBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(cellType: AddressCellType = .order) {
        self.contentView.addSubview(self.radioButton)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.addressLabel)
        let manageAddressView = UIStackView(frame: .zero)
        manageAddressView.translatesAutoresizingMaskIntoConstraints = false
        manageAddressView.axis = .horizontal
        manageAddressView.distribution = .fillEqually
        switch cellType {
        case .order:
            self.contentView.addSubview(self.chooseAddressButton)
        case .manage:
            self.isSelected = true
            self.radioButton.isHidden = true
            self.contentView.addSubview(manageAddressView)
        }
        
        self.contentView.layer.cornerRadius = 16
        
        self.radioButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        self.radioButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.radioButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        self.radioButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.nameLabel.leftAnchor.constraint(equalTo: self.radioButton.rightAnchor,
                                               constant: 8).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                              constant: 8).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                                constant: -8).isActive = true
        
        self.addressLabel.leftAnchor.constraint(equalTo: self.radioButton.rightAnchor,
                                               constant: 8).isActive = true
        self.addressLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,
                                              constant: 8).isActive = true
        self.addressLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                                constant: -8).isActive = true
        switch cellType {
        case .order:
            self.chooseAddressButton.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor,
                                                  constant: 24).isActive = true
            self.chooseAddressButton.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,
                                                   constant: 32).isActive = true
            self.chooseAddressButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,
                                                  constant: -32).isActive = true
            self.chooseAddressButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
     
            self.chooseAddressButton.isEnabled = false
            self.chooseAddressButton.setTitle("Confirm your Reward", for: .normal)
            self.chooseAddressButton.alpha = 0.5
            self.chooseAddressButton.addTarget(self, action: #selector(claimRewardClicked), for: .touchUpInside)
        case .manage:
            manageAddressView.addArrangedSubview(self.editAddressButton)
            manageAddressView.addArrangedSubview(self.deleteAddressButton)
            
            self.editAddressButton.setTitle("Edit", for: .normal)
            self.deleteAddressButton.setTitle("Delete", for: .normal)
            self.deleteAddressButton.setTitleColor(.black, for: .normal)
            manageAddressView.spacing = 16
            
            
            self.editAddressButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
            self.deleteAddressButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
            
            manageAddressView.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor,
                                                  constant: 24).isActive = true
            manageAddressView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
            manageAddressView.widthAnchor.constraint(equalToConstant: 220).isActive = true
            manageAddressView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        self.radioButton.setImage(UIImage(named: "radio-button-uncheked")?.withRenderingMode(.alwaysTemplate),
                                   for: .normal)
        self.radioButton.isUserInteractionEnabled = false
    }
    
    func setup(address: Address) {
        self.address = address
        self.nameLabel.text = "\(TaoHelper.userProfile?.userDetails?.firstName ?? "") \(TaoHelper.userProfile?.userDetails?.lastName ?? "")"
        self.addressLabel.text = address.fullAddress()
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.itemSelected()
            } else {
                switch cellType {
                case .order:
                    self.itemDeselected()
                case .manage:
                    break
                }
            }
        }
    }
    
    func itemSelected() {
        self.radioButton.setImage(UIImage(named: "radio-button-checked")?.withRenderingMode(.alwaysTemplate),
                                   for: .normal)
        self.chooseAddressButton.alpha = 1
        self.chooseAddressButton.isEnabled = true
    }
    
    func itemDeselected() {
        self.radioButton.setImage(UIImage(named: "radio-button-uncheked")?.withRenderingMode(.alwaysTemplate),
                                   for: .normal)
        self.chooseAddressButton.alpha = 0.5
        self.chooseAddressButton.isEnabled = false
    }

    
    @objc func claimRewardClicked() {
        self.delegate?.claimRewardTapped(address: self.address)
    }
    
    @objc func editTapped() {
        self.manageDelegate?.editTapped(address: self.address)
    }
    
    @objc func deleteTapped() {
        self.manageDelegate?.deleteTapped(address: self.address)
    }
}
