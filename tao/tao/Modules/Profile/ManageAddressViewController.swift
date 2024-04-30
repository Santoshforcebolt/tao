//
//  ManageAddressViewController.swift
//  tao
//
//  Created by Mayank Khursija on 26/06/22.
//

import Foundation

class ManageAddressViewController: BaseViewController<ManageAddressViewModel> {
    
    var addressCollectionView: UICollectionView
    var navigationBar: UINavigationBar?
    
    var addNewAddress: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    override init(_ viewModel: ManageAddressViewModel) {
        let addressCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        addressCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addressCollectionViewLayout.scrollDirection = .vertical

        self.addressCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: addressCollectionViewLayout)
        self.addressCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.addressCollectionView.delegate = self
        self.addressCollectionView.dataSource = self
        self.addressCollectionView.showsHorizontalScrollIndicator = false
        self.addressCollectionView.register(AddressViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addressCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        self.addressCollectionView.showsVerticalScrollIndicator = false
        
        self.addNewAddress.setTitle("Add a new Address", for: .normal)
    }
    
    func setupView() {
        self.view.addSubview(self.addressCollectionView)
        
        self.addressCollectionView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
                                                         constant: 8).isActive = true
        self.addressCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                         constant: 8).isActive = true
        self.addressCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                         constant: -8).isActive = true
        self.addressCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                         constant: -8).isActive = true
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
        
        let navigationItem = UINavigationItem(title: "Manage Addresses")
        
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
    
    @objc func addNewAddressTapped() {
        self.viewModel.addNewAddressTapped()
    }
    
    override func reloadView() {
        super.reloadView()
        self.addressCollectionView.reloadData()
    }
    
    override func backAction() {
        super.backAction()
        self.viewModel.backButtonTapped()
    }
}

extension ManageAddressViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfAddresses
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AddressViewCell ?? AddressViewCell(frame: .zero)
        cell.manageDelegate = self
        if let address = self.viewModel.getAddress(at: indexPath.row) {
            cell.setupView(cellType: .manage)
            cell.setup(address: address)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.addressCollectionView {
            return CGSize(width: self.addressCollectionView.frame.size.width - 26, height: 220)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.addressCollectionView, kind == UICollectionView.elementKindSectionHeader {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath)
            footerView.addSubview(self.addNewAddress)
            self.addNewAddress.topAnchor.constraint(equalTo: footerView.topAnchor,
                                                  constant: 8).isActive = true
            self.addNewAddress.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 8).isActive = true
            self.addNewAddress.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -8).isActive = true
            self.addNewAddress.heightAnchor.constraint(equalToConstant: 44).isActive = true
            self.addNewAddress.addTarget(self, action: #selector(addNewAddressTapped), for: .touchUpInside)
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.size.width, height: 50)
        }
        return .zero
    }
}

extension ManageAddressViewController: ManageAddressViewCellDelegate {
    func editTapped(address: Address?) {
        if let address = address {
            self.viewModel.editAddress(address: address)
        }
    }
    
    func deleteTapped(address: Address?) {
        if let address = address {
            self.viewModel.deleteAddress(address: address)
        }
    }
}
