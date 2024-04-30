//
//  ManageSubscriptionViewController.swift
//  tao
//
//  Created by Mayank Khursija on 16/07/22.
//

import Foundation

class ManageSubscriptionViewController: BaseViewController<ManageSubscriptionViewModel> {
    
    var navigationBar: UINavigationBar?
    var trendingCollectionView: UICollectionView
    
    var instructionImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var enableAutoSubscribeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .lightBlueBackground
        return button
    }()
    
    var cancelSubscribeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .lightBlueBackground
        return button
    }()
    
    override init(_ viewModel: ManageSubscriptionViewModel) {
        let trendingCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        trendingCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        trendingCollectionViewLayout.scrollDirection = .vertical

        self.trendingCollectionView = UICollectionView(frame: .zero,
                                                         collectionViewLayout: trendingCollectionViewLayout)
        self.trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.trendingCollectionView.delegate = self
        self.trendingCollectionView.dataSource = self
        self.trendingCollectionView.showsHorizontalScrollIndicator = false
        self.trendingCollectionView.register(SubscriptionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.trendingCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        self.trendingCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerCell")
        
        self.trendingCollectionView.showsVerticalScrollIndicator = false
        
        self.instructionImageView.sd_setImage(with: URL(string: ImagesData.premiumImage))
        self.titleLabel.text = "Select a Plan to Proceed"
        
        self.cancelSubscribeButton.setTitle("Cancel Subscription", for: .normal)
        self.cancelSubscribeButton.addTarget(self, action: #selector(cancelSubscriptionTapped), for: .touchUpInside)
        self.enableAutoSubscribeButton.setTitleColor(.black, for: .normal)
        self.cancelSubscribeButton.setTitleColor(.black, for: .normal)
        
        
        self.enableAutoSubscribeButton.addTarget(self, action: #selector(enableAutoSubcribeButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelSubscriptionTapped() {
        self.viewModel.cancelSubscriptionTapped()
    }
    
    @objc func enableAutoSubcribeButtonTapped() {
        self.viewModel.autoSubscibeTapped()
    }
    
    func setupView() {
        self.view.addSubview(self.trendingCollectionView)
        
        
        self.trendingCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                           constant: 60).isActive = true
        self.trendingCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                            constant: 16).isActive = true
        self.trendingCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                             constant: -16).isActive = true
        self.trendingCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                            constant: -16).isActive = true
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
        self.view.addSubview(navigationBar)
        
        navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let navigationItem = UINavigationItem(title: "Manage Subcription")
        
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
        self.viewModel.backActionTapped()
    }
    
    override func reloadView() {
        super.reloadView()
        self.trendingCollectionView.reloadData()
    }
}

extension ManageSubscriptionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.planDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SubscriptionViewCell ?? SubscriptionViewCell(frame: .zero)
        cell.backgroundColor = .blueBackground
        cell.cornerRadius = 12
        if let planDetail = self.viewModel.planDetails?[indexPath.row] {
            cell.setup(title: planDetail.name ?? "",
                       price: "₹\(planDetail.discountedPrice ?? 0)",
                       discountedPrice: "₹\(planDetail.price ?? 0)",
                       validity: "Applicable for \(planDetail.durationDays ?? 0) days")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(TaoHelper.userProfile?.userDetails?.isPremiumUser ?? false) {
            self.viewModel.itemTapped(index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath)
            
            headerView.subviews.forEach({ $0.removeFromSuperview() })
            
            headerView.addSubview(self.instructionImageView)
            headerView.addSubview(self.titleLabel)
            
            if TaoHelper.userProfile?.userDetails?.isPremiumUser ?? false {
                let currentPlanView = SubscriptionView(frame: .zero)
                currentPlanView.translatesAutoresizingMaskIntoConstraints = false
                currentPlanView.backgroundColor = .systemBlue
                currentPlanView.cornerRadius = 12
                currentPlanView.setup(title: TaoHelper.userProfile?.userSubscriptionDetails?.planDetails?.name ?? "",
                                      price: "₹\(TaoHelper.userProfile?.userSubscriptionDetails?.planDetails?.discountedPrice ?? 0)",
                                      discountedPrice: "₹\(TaoHelper.userProfile?.userSubscriptionDetails?.planDetails?.price ?? 0)",
                                      validity: "Valid till \(TaoHelper.userProfile?.userSubscriptionDetails?.planDetails?.durationDays ?? 0)")
                
                headerView.addSubview(currentPlanView)
                headerView.addSubview(self.enableAutoSubscribeButton)
                
                self.instructionImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8).isActive = true
                self.instructionImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8).isActive = true
                self.instructionImageView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8).isActive = true
                self.instructionImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
                
                currentPlanView.topAnchor.constraint(equalTo: self.instructionImageView.bottomAnchor, constant: 8).isActive = true
                currentPlanView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8).isActive = true
                currentPlanView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8).isActive = true
                currentPlanView.heightAnchor.constraint(equalToConstant: 120).isActive = true
                
                self.enableAutoSubscribeButton.topAnchor.constraint(equalTo: currentPlanView.bottomAnchor, constant: 8).isActive = true
                self.enableAutoSubscribeButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8).isActive = true
                self.enableAutoSubscribeButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8).isActive = true
                self.enableAutoSubscribeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
                
                if TaoHelper.userProfile?.userSubscriptionDetails?.autoSubscribed ?? false {
                    self.enableAutoSubscribeButton.setTitle("Disable Auto Subscibe", for: .normal)
                } else {
                    self.enableAutoSubscribeButton.setTitle("Enable Auto Subscibe", for: .normal)
                }
                
                self.titleLabel.topAnchor.constraint(equalTo: self.enableAutoSubscribeButton.bottomAnchor, constant: 16).isActive = true
                self.titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8).isActive = true
                self.titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8).isActive = true

                
            } else {
                self.instructionImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8).isActive = true
                self.instructionImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8).isActive = true
                self.instructionImageView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8).isActive = true
                self.instructionImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
                
                self.titleLabel.topAnchor.constraint(equalTo: self.instructionImageView.bottomAnchor, constant: 16).isActive = true
                self.titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8).isActive = true
                self.titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8).isActive = true
            }
            
            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "footerCell",
                                                                             for: indexPath)
            if (TaoHelper.userProfile?.userDetails?.isPremiumUser ?? false) {
                footerView.addSubview(self.cancelSubscribeButton)
                
                self.cancelSubscribeButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 8).isActive = true
                self.cancelSubscribeButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 8).isActive = true
                self.cancelSubscribeButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -8).isActive = true
                self.cancelSubscribeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            }
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if TaoHelper.userProfile?.userDetails?.isPremiumUser ?? false {
            return CGSize(width: collectionView.frame.width, height: 352)
        } else {
            return CGSize(width: collectionView.frame.width, height: 180)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if (TaoHelper.userProfile?.userDetails?.isPremiumUser ?? false) {
            return CGSize(width: collectionView.frame.width, height: 60)
        }
        return .zero
    }
}
