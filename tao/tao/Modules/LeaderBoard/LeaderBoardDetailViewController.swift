//
//  LeaderBoardDetailViewController.swift
//  tao
//
//  Created by Mayank Khursija on 02/07/22.
//

import Foundation

class LeaderBoardDetailViewController: BaseViewController<LeaderBoardDetailViewModel> {
    var transactionCollectionView: UICollectionView
    var userInfoView: UserInfoView = {
        let userInfoView = UserInfoView(renderData: UserInfoView.RenderData(
            imageHeight: 72,
            imageWidth: 72,
            distanceBetweenImageAndLabel: 24,
            textColor: .black,
            showMobileNumber: false))
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        return userInfoView
    }()
    
    var visitProfileButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var rewardLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var nudgeView: NudgeView = NudgeView()
    
    override init(_ viewModel: LeaderBoardDetailViewModel) {
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
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupView()
        
        self.transactionCollectionView.delegate = self
        self.transactionCollectionView.dataSource = self
        self.transactionCollectionView.showsHorizontalScrollIndicator = false
        self.transactionCollectionView.register(LeaderBoardDetailViewCell.self, forCellWithReuseIdentifier: "cell")
        self.transactionCollectionView.showsVerticalScrollIndicator = true
        
        if let imageUrlString = self.viewModel.leaderBoard.imageUrl,
           let imageUrl = URL(string: imageUrlString) {
            self.userInfoView.setupData(name: self.viewModel.leaderBoard.username ?? "",
                                        image: .withURL(imageUrl),
                                        info: self.viewModel.leaderBoard.school?.schoolName ?? "")
        } else {
            self.userInfoView.setupData(name: self.viewModel.leaderBoard.username ?? "",
                                        image: .withImage(UIImage(named: "defaultLeaderboardPicture")!),
                                        info: self.viewModel.leaderBoard.school?.schoolName ?? "")
        }
        self.visitProfileButton.setTitle("Visit Profile", for: .normal)
        self.visitProfileButton.addTarget(self, action: #selector(visitProfileTapped), for: .touchUpInside)
        self.rewardLabel.text = "Reward: "
        switch self.viewModel.type {
        case .cash:
            self.nudgeView.updateType(type: .money("\(self.viewModel.leaderBoard.reward ?? 0)"))
        case .coin:
            self.nudgeView.updateType(type: .coin("\(self.viewModel.leaderBoard.reward ?? 0)"))
        }
    }
    
    @objc func visitProfileTapped() {
        self.viewModel.visitProfileTapped()
    }
    
    func setupView() {
        self.containerView.addSubview(self.userInfoView)
        self.containerView.addSubview(self.visitProfileButton)
        self.containerView.addSubview(self.transactionCollectionView)
        
        self.userInfoView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.userInfoView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.userInfoView.topAnchor.constraint(equalTo: self.containerView.topAnchor,
                                               constant: 8).isActive = true
        self.userInfoView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        self.visitProfileButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                      constant: 24).isActive = true
        self.visitProfileButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                       constant: -24).isActive = true
        self.visitProfileButton.topAnchor.constraint(equalTo: self.userInfoView.bottomAnchor,
                                                     constant: 8).isActive = true
        self.visitProfileButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.transactionCollectionView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                      constant: 24).isActive = true
        self.transactionCollectionView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                       constant: -24).isActive = true
        self.transactionCollectionView.topAnchor.constraint(equalTo: self.visitProfileButton.bottomAnchor,
                                                     constant: 8).isActive = true
        self.transactionCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let rewardView = UIStackView(frame: .zero)
        rewardView.translatesAutoresizingMaskIntoConstraints = false
        rewardView.axis = .horizontal
        rewardView.spacing = 8
        
        rewardView.addArrangedSubview(self.rewardLabel)
        rewardView.addArrangedSubview(self.nudgeView)
        
        self.containerView.addSubview(rewardView)
        
        rewardView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        rewardView.topAnchor.constraint(equalTo: self.transactionCollectionView.bottomAnchor).isActive = true
        rewardView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        rewardView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16).isActive = true
    }
}

extension LeaderBoardDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.leaderBoard.competitionDetails?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LeaderBoardDetailViewCell ?? LeaderBoardDetailViewCell(frame: .zero)
        
        if let competition = self.viewModel.leaderBoard.competitionDetails?[indexPath.row] {
            cell.setupData(leftText: competition.name ?? "", rightText: "\(round(competition.points ?? 0.0))")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 24)
    }
}
