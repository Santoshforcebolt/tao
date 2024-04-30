//
//  MyReferralViewController.swift
//  tao
//
//  Created by Mayank Khursija on 14/08/22.
//

import Foundation

class MyReferralViewController: BaseViewController<MyReferralViewModel> {
    
    var navigationBar: UINavigationBar?
    var transactionCollectionView: UICollectionView
    
    var stateImageView: UIImageView = {
        let uiImageView = UIImageView(frame: .zero)
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        return uiImageView
    } ()
    
    var referHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 18)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    } ()
    
    var referralButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .lightBlueBackground
        return button
    }()
    
    var shareOnWhatsappButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .systemGreen
        return button
    }()
    
    var myTotalEarningsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    } ()
    
    var nudgeView: NudgeView = {
       let nudge = NudgeView()
        nudge.translatesAutoresizingMaskIntoConstraints = false
        return nudge
    }()
    
    var myReferHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    } ()
    
    override init(_ viewModel: MyReferralViewModel) {
        let transactionCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        transactionCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        transactionCollectionViewLayout.scrollDirection = .vertical
        self.transactionCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: transactionCollectionViewLayout)
        self.transactionCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.transactionCollectionView.delegate = self
        self.transactionCollectionView.dataSource = self
        self.transactionCollectionView.showsHorizontalScrollIndicator = false
        self.transactionCollectionView.register(MyReferralViewCell.self, forCellWithReuseIdentifier: "cell")
        self.transactionCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        self.transactionCollectionView.showsVerticalScrollIndicator = false
        
        self.referralButton.setImage(UIImage(systemName: "doc.on.clipboard")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.referralButton.tintColor = .black
        self.referralButton.setTitleColor(.black, for: .normal)
        self.referralButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        self.referralButton.addTarget(self, action: #selector(referralButtonTapped), for: .touchUpInside)
        
        self.referralButton.setImage(UIImage(systemName: "doc.on.clipboard")?.withRenderingMode(.alwaysTemplate), for: .normal)

        self.shareOnWhatsappButton.setTitle("Share on Whatsapp", for: .normal)
        self.shareOnWhatsappButton.addTarget(self, action: #selector(referralButtonTapped), for: .touchUpInside)
        
        self.myTotalEarningsLabel.text = "My Earnings"
        self.myReferHeaderLabel.text = "My Referrals"
    }
    
    @objc func shareOnWhatsappTapped() {
        self.viewModel.shareOnWhatsappTapped()
    }
    
    @objc func referralButtonTapped() {
        UIPasteboard.general.string = TaoHelper.userProfile?.userDetails?.referralCode ?? ""
        self.viewModel.referralButtonTapped()
    }
    
    func setupView() {
        self.view.addSubview(self.transactionCollectionView)
        
        self.transactionCollectionView.topAnchor.constraint(
            equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
            constant: 16).isActive = true
        self.transactionCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                             constant: 8).isActive = true
        self.transactionCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                              constant: -8).isActive = true
        self.transactionCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
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
        
        let navigationItem = UINavigationItem(title: "My Referrals")
        
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
    
    override func reloadView() {
        super.reloadView()
        self.transactionCollectionView.reloadData()
        if let urlString = self.viewModel.referralsData?.imageUrl,
           let url = URL(string: urlString) {
            self.stateImageView.sd_setImage(with: url)
        }
        self.referHeaderLabel.text = self.viewModel.referralsData?.text
        self.referralButton.setTitle(self.viewModel.referralsData?.code, for: .normal)
    }
}

extension MyReferralViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.referrals?.referrals?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row >= (self.viewModel.referrals?.referrals?.count ?? 0)/2 {
            self.viewModel.loadMoreEntries()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyReferralViewCell ?? MyReferralViewCell()
        if let referral = self.viewModel.referrals?.referrals?[indexPath.row] {
            let status = referral.status ?? 0
            let subtitle: String
            let subtitlColor: UIColor
            switch status {
            case 2:
                subtitle = "Profile Created"
                subtitlColor = .systemBlue
            case 3:
                subtitle = "Participated"
                subtitlColor = .systemYellow
            case 4 :
                subtitle = "KYC"
                subtitlColor = .systemGreen
            default:
                subtitle = "Profile Created"
                subtitlColor = .systemBlue
            }
            cell.setupData(title: referral.name ?? "",
                           subTitle: subtitle,
                           type: .coin("\(referral.coins ?? 0)"),
                           subTitleColor: subtitlColor)
            
            cell.backgroundColor = .lightGrayBackground

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.transactionCollectionView, kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath)
            
            headerView.subviews.forEach({ $0.removeFromSuperview() })
            headerView.addSubview(self.stateImageView)
            headerView.addSubview(self.referHeaderLabel)
            headerView.addSubview(self.referralButton)
            headerView.addSubview(self.shareOnWhatsappButton)
            headerView.addSubview(self.myReferHeaderLabel)
            
            self.stateImageView.topAnchor.constraint(
                equalTo: headerView.topAnchor,
                constant: 16).isActive = true
            self.stateImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                                 constant: 32).isActive = true
            self.stateImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                                  constant: -32).isActive = true
            self.stateImageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
            
            
            self.referHeaderLabel.topAnchor.constraint(
                equalTo: self.stateImageView.bottomAnchor,
                constant: 16).isActive = true
            self.referHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                                 constant: 32).isActive = true
            self.referHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                                  constant: -32).isActive = true
            
            self.referralButton.topAnchor.constraint(
                equalTo: self.referHeaderLabel.bottomAnchor,
                constant: 16).isActive = true
            self.referralButton.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                                 constant: 32).isActive = true
            self.referralButton.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                                  constant: -32).isActive = true
            self.referralButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
   
            self.shareOnWhatsappButton.topAnchor.constraint(
                equalTo: self.referralButton.bottomAnchor,
                constant: 16).isActive = true
            self.shareOnWhatsappButton.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                                 constant: 32).isActive = true
            self.shareOnWhatsappButton.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                                  constant: -32).isActive = true
            self.shareOnWhatsappButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            let stackView = UIStackView(frame: .zero)
            stackView.axis = .horizontal
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(self.myTotalEarningsLabel)
            stackView.addArrangedSubview(self.nudgeView)
            
            self.nudgeView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3).isActive = true
            
            headerView.addSubview(stackView)
            
            stackView.topAnchor.constraint(
                equalTo: self.shareOnWhatsappButton.bottomAnchor,
                constant: 16).isActive = true
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                                 constant: 32).isActive = true
            stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                                  constant: -32).isActive = true
            stackView.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            self.nudgeView.updateType(type: .coin("\(self.viewModel.referrals?.totalCoins ?? 0)"))
            
            self.myReferHeaderLabel.topAnchor.constraint(
                equalTo: stackView.bottomAnchor,
                constant: 16).isActive = true
            self.myReferHeaderLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                                 constant: 32).isActive = true
            self.myReferHeaderLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                                  constant: -32).isActive = true
            
            self.myReferHeaderLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor,
                                                        constant: -16).isActive = true
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.transactionCollectionView {
            return CGSize(width: self.transactionCollectionView.frame.size.width - 32, height: 90)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 480)
    }
    
}
