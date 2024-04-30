//
//  WalletViewController.swift
//  tao
//
//  Created by Mayank Khursija on 27/06/22.
//

import Foundation

class WalletViewController: BaseViewController<WalletViewModel> {
    
    var bannersCollectionView: UICollectionView
    var navigationBar: UINavigationBar?
    
    var viewTransactionHistoryButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var moneyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins-Bold", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var coinsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins-Bold", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var moneyWithdrawLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 14)
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
    
    var coinsHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var coinBalanceView2: NudgeView = {
        let renderData = NudgeView.RenderData(font: UIFont(name: "Poppins-Bold", size: 30), textColor: .white)
        let view = NudgeView(renderData: renderData)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var moneyBalanceView2: NudgeView = {
        let renderData = NudgeView.RenderData(font: UIFont(name: "Poppins-Bold", size: 30), textColor: .white)
        let view = NudgeView(renderData: renderData)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var moneyWithdrawView: ProfileOptionView = {
        let renderData = ProfileOptionView.RenderData(leftSpacing: 16, rightSpacing: 16, showLeftIcon: false)
        let view = ProfileOptionView(renderData: renderData)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coinsWithdrawView: ProfileOptionView = {
        let renderData = ProfileOptionView.RenderData(leftSpacing: 16, rightSpacing: 16, showLeftIcon: false)
        let view = ProfileOptionView(renderData: renderData)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coinCardView = UIStackView(frame: .zero)
    var moneyCardView = UIStackView(frame: .zero)
    
    override init(_ viewModel: WalletViewModel) {
        let bannersCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        bannersCollectionViewLayout.scrollDirection = .horizontal
        self.bannersCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: bannersCollectionViewLayout)
        self.bannersCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
        
        
        self.bannersCollectionView.delegate = self
        self.bannersCollectionView.dataSource = self
        self.bannersCollectionView.showsHorizontalScrollIndicator = false
        self.bannersCollectionView.register(BannerViewCell.self, forCellWithReuseIdentifier: TaoStoreSections.banners.rawValue)
        
        self.viewTransactionHistoryButton.setTitle("Your Winnings & Transaction History", for: .normal)
        self.viewTransactionHistoryButton.addTarget(self, action: #selector(viewHistoryTapped), for: .touchUpInside)
        
        self.moneyWithdrawView.backgroundColor = .white
        
        self.moneyCardView.cornerRadius = 16
        self.coinCardView.cornerRadius = 16
        
        self.coinsWithdrawView.backgroundColor = .white
    }
    
    @objc func viewHistoryTapped() {
        self.viewModel.showHistory()
    }
    
    override func reloadView() {
        super.reloadView()
        self.bannersCollectionView.reloadData()
        
        self.moneyCardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moneyCardTapped)))
        self.coinCardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(coinCardTapped)))
        
        self.moneyHeaderLabel.text = "Scholarships"
        self.moneyLabel.text = "₹ \(self.viewModel.walletResponse?.balanceDetails?.rewardsCashBalance ?? 0)"
        self.moneyWithdrawView.setupData(image: nil, text: "Withdraw")
        
        self.coinsHeaderLabel.text = "Coins Won"
        self.coinsLabel.text = "\(self.viewModel.walletResponse?.balanceDetails?.rewardsCoinBalance ?? 0)"
        self.coinsWithdrawView.setupData(image: nil, text: "Redeem Now")
        self.coinBalanceView2.updateType(type: .coin("\(self.viewModel.walletResponse?.balanceDetails?.rewardsCoinBalance ?? 0)"))
        self.moneyBalanceView2.updateType(type: .money("\(self.viewModel.walletResponse?.balanceDetails?.rewardsCashBalance ?? 0)"))
    }
    
    func setupView() {
        
        self.containerView.addSubview(self.bannersCollectionView)
        self.containerView.addSubview(self.viewTransactionHistoryButton)
        self.bannersCollectionView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.containerView.topAnchor,
                                                           constant: 16).isActive = true
        self.bannersCollectionView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                            constant: 8).isActive = true
        self.bannersCollectionView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                             constant: -8).isActive = true
        self.bannersCollectionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.viewTransactionHistoryButton.topAnchor.constraint(equalTo: self.bannersCollectionView.bottomAnchor,
                                              constant: 24).isActive = true
        self.viewTransactionHistoryButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 32).isActive = true
        self.viewTransactionHistoryButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                              constant: -32).isActive = true
        self.viewTransactionHistoryButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        self.coinCardView.translatesAutoresizingMaskIntoConstraints = false
        self.coinCardView.axis = .vertical
        self.moneyCardView.translatesAutoresizingMaskIntoConstraints = false
        self.moneyCardView.axis = .vertical
        
        self.containerView.addSubview(self.moneyCardView)
        self.containerView.addSubview(self.coinCardView)
        
        self.moneyCardView.addArrangedSubview(self.moneyHeaderLabel)
        self.moneyCardView.addArrangedSubview(self.moneyBalanceView2)
        self.moneyCardView.addArrangedSubview(self.moneyWithdrawView)
        
        self.moneyCardView.topAnchor.constraint(equalTo: self.viewTransactionHistoryButton.bottomAnchor,
                                              constant: 24).isActive = true
        self.moneyCardView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 32).isActive = true
        self.moneyCardView.widthAnchor.constraint(equalToConstant: self.view.frame.width/2-48).isActive = true
        self.moneyCardView.heightAnchor.constraint(equalToConstant: self.view.frame.width/2-48).isActive = true
        self.moneyCardView.backgroundColor = .systemGreen

        
        self.moneyCardView.layoutMargins = UIEdgeInsets.init(top: 16, left: 0, bottom: 16, right: 0)
        self.moneyCardView.isLayoutMarginsRelativeArrangement = true

        self.moneyHeaderLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.moneyWithdrawView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        
        self.coinCardView.addArrangedSubview(self.coinsHeaderLabel)
        self.coinCardView.addArrangedSubview(self.coinBalanceView2)
        self.coinCardView.addArrangedSubview(self.coinsWithdrawView)
        
        self.coinCardView.topAnchor.constraint(equalTo: self.viewTransactionHistoryButton.bottomAnchor,
                                              constant: 24).isActive = true
        self.coinCardView.leftAnchor.constraint(equalTo: self.moneyCardView.rightAnchor,
                                               constant: 32).isActive = true
        self.coinCardView.widthAnchor.constraint(equalToConstant: self.view.frame.width/2-48).isActive = true
        self.coinCardView.heightAnchor.constraint(equalToConstant: self.view.frame.width/2-48).isActive = true
        self.coinCardView.backgroundColor = .systemYellow

        
        self.coinCardView.layoutMargins = UIEdgeInsets.init(top: 16, left: 0, bottom: 16, right: 0)
        self.coinCardView.isLayoutMarginsRelativeArrangement = true

        self.coinsHeaderLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        self.coinsWithdrawView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        self.moneyCardView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                                  constant: -16).isActive = true
        
        
    }
    
    @objc func moneyCardTapped() {
        self.viewModel.moneyCardTapped()
    }
    
    @objc func coinCardTapped() {
        self.viewModel.coinCardTapped()
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
        
        let navigationItem = UINavigationItem(title: "My Wallet")
        
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

//MARK: Cateogry Collection View Cell Protocols
extension WalletViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.walletBanners?.topBanners?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaoStoreSections.banners.rawValue,
                                                      for: indexPath) as? BannerViewCell ?? BannerViewCell(frame: .zero)
        
        if let banner = self.viewModel.walletBanners?.topBanners?[indexPath.row],
           let url = URL(string: banner.imageUrl ?? "") {
            cell.setupImage(image: .withURL(url))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 348, height: 116)
    }
}
