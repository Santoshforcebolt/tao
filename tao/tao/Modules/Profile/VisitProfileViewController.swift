//
//  VisitProfileViewController.swift
//  tao
//
//  Created by Mayank Khursija on 03/07/22.
//

import Foundation

class VisitProfileViewController: BaseViewController<VisitProfileViewModel> {
    
    var followerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var followerValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var followingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var followingValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    private var profilePictureImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameView: NudgeView = {
        let renderData = NudgeView.RenderData(image: UIImage(systemName: "checkmark.seal.fill"))
        let view = NudgeView(renderData: renderData)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var usernameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    var schoolLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var scholarshipLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var scholarshipLabelValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins-Bold", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var competitionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var competitionValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins-Bold", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var coinsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var coinsValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins-Bold", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var followButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var blockButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .lightBlueBackground
        return button
    }()
    
    var navigationBar: UINavigationBar?
    var storyCollectionView: UICollectionView
    
    override init(_ viewModel: VisitProfileViewModel) {
        let storyCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        storyCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        storyCollectionViewLayout.scrollDirection = .vertical
        
        self.storyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: storyCollectionViewLayout)
        self.storyCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.storyCollectionView.delegate = self
        self.storyCollectionView.dataSource = self
        self.storyCollectionView.register(MediaViewCell.self, forCellWithReuseIdentifier: "cell")
        self.storyCollectionView.showsVerticalScrollIndicator = false
        self.storyCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
        let storyCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        storyCollectionViewLayout.scrollDirection = .vertical
        storyCollectionViewLayout.minimumInteritemSpacing = 8
        
        // left margin of collection view + right margin of collection view + (number of cells in row - 1) * interItemSpace = 56
        storyCollectionViewLayout.itemSize = CGSize(width: Int((self.view.frame.size.width - 56)/4), height: 120)
        
        self.storyCollectionView.setCollectionViewLayout(storyCollectionViewLayout, animated: true)
        
        self.followButton.addTarget(self, action: #selector(followButtonTapped), for: .touchUpInside)
        self.followButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        self.followButton.tintColor = .white
        self.blockButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        self.blockButton.addTarget(self, action: #selector(blockButtonTapped), for: .touchUpInside)
    }
    
    func setupView() {
            self.view.addSubview(self.storyCollectionView)
            
            self.storyCollectionView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
                                                             constant: 16).isActive = true
            self.storyCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                             constant: 16).isActive = true
            self.storyCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                             constant: -16).isActive = true
            self.storyCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                             constant: -16).isActive = true
    }
    
    @objc func blockButtonTapped() {
        self.viewModel.blockButtonTapped()
    }
    
    @objc func followButtonTapped() {
        self.viewModel.followButtonTapped()
    }
    
    override func reloadView() {
        super.reloadView()
        self.storyCollectionView.reloadData()
        
        if let imageUrlString = self.viewModel.profile?.profileImage,
           let imageUrl = URL(string: imageUrlString) {
            self.profilePictureImageView.sd_setImage(with: imageUrl)
        } else {
            self.profilePictureImageView.image = UIImage(named: "profile")
        }
        self.profilePictureImageView.cornerRadius = 34
        self.followerLabel.text = "Followers"
        self.followerValueLabel.text = "\(self.viewModel.profile?.userSocialStatResponse?.follower ?? 0)"
        self.followingLabel.text = "Following"
        self.followingValueLabel.text = "\(self.viewModel.profile?.userSocialStatResponse?.following ?? 0)"
        if self.viewModel.profile?.verified ?? false {
            self.nameView.updateType(type: .coin(self.viewModel.profile?.username ?? ""))
        } else {
            self.nameView.updateType(type: .coin(self.viewModel.profile?.username ?? ""))
            self.nameView.updatePictureForCoin(image: nil)
        }
        self.usernameLabel.text = "@\(self.viewModel.profile?.handle ?? "")"
        self.schoolLabel.text = self.viewModel.profile?.school ?? ""
        
        self.scholarshipLabel.text = "Scholarship"
        self.scholarshipLabelValueLabel.text = "₹\(self.viewModel.profile?.userRewardHistory?.cash ?? 0)"
        
        self.competitionLabel.text = "Competitions"
        self.competitionValueLabel.text = "\(self.viewModel.profile?.competitions ?? 0)"
        
        self.coinsLabel.text = "Coins"
        self.coinsValueLabel.text = "\(self.viewModel.profile?.userRewardHistory?.coins ?? 0)"
        
        if self.viewModel.profile?.following ?? false {
            self.followButton.setTitle("Followed", for: .normal)
            self.followButton.setImage(UIImage(systemName: "person.crop.circle.badge.checkmark")?.withRenderingMode(.alwaysTemplate),
                                       for: .normal)
        } else {
            self.followButton.setTitle("Follow", for: .normal)
            self.followButton.setImage(UIImage(systemName: "person.crop.circle.badge.plus")?.withRenderingMode(.alwaysTemplate),
                                       for: .normal)
        }
        self.blockButton.setTitle("Block", for: .normal)
        self.blockButton.setTitleColor(.black, for: .normal)
        self.blockButton.setImage(UIImage(systemName: "slash.circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.blockButton.tintColor = .black
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
        
        let navigationItem = UINavigationItem(title: "Profile")
        
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

extension VisitProfileViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.profileMediaEntries?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as? MediaViewCell ?? MediaViewCell(frame: .zero)
        let mediaEntry = self.viewModel.profileMediaEntries?.data?[indexPath.row]
        if let imageUrlString = mediaEntry?.thumbnailURL,
           let count = mediaEntry?.views {
            cell.setup(urlString: imageUrlString, count: "\(count)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.itemSelected(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.storyCollectionView, kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath)
            
            headerView.subviews.forEach({ $0.removeFromSuperview() })
            let horizontalStackView = UIStackView(frame: .zero)
            horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView.axis = .horizontal
            horizontalStackView.distribution = .fillProportionally
            
            let verticalStackView = UIStackView(frame: .zero)
            verticalStackView.axis = .vertical
            verticalStackView.distribution = .fillEqually
            
            let verticalStackView2 = UIStackView(frame: .zero)
            verticalStackView2.axis = .vertical
            verticalStackView2.distribution = .fillEqually
            
            let verticalStackView3 = UIStackView(frame: .zero)
            verticalStackView3.axis = .vertical
            verticalStackView3.distribution = .fillEqually
            
            verticalStackView.addArrangedSubview(self.followerValueLabel)
            verticalStackView.addArrangedSubview(self.followerLabel)
            
            self.followerValueLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            verticalStackView3.addArrangedSubview(self.followingValueLabel)
            verticalStackView3.addArrangedSubview(self.followingLabel)
            
            self.followingValueLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            
            horizontalStackView.addArrangedSubview(verticalStackView)
            horizontalStackView.addArrangedSubview(self.profilePictureImageView)
            horizontalStackView.addArrangedSubview(verticalStackView3)
            
            self.profilePictureImageView.widthAnchor.constraint(equalToConstant: 68).isActive = true
            self.profilePictureImageView.centerXAnchor.constraint(equalTo: horizontalStackView.centerXAnchor).isActive = true
            self.profilePictureImageView.backgroundColor = .grayBackground
            self.profilePictureImageView.setContentHuggingPriority(.required,
                                                                   for: .horizontal)
            
            headerView.addSubview(horizontalStackView)
            
            horizontalStackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 24).isActive = true
            horizontalStackView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 24).isActive = true
            horizontalStackView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -24).isActive = true
            horizontalStackView.heightAnchor.constraint(equalToConstant: 68).isActive = true
            
            
            let horizontalStackView2 = UIStackView(frame: .zero)
            horizontalStackView2.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView2.axis = .horizontal
            horizontalStackView2.alignment = .center
            
            headerView.addSubview(horizontalStackView2)
            
            horizontalStackView2.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 16).isActive = true
            horizontalStackView2.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 24).isActive = true
            horizontalStackView2.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -24).isActive = true
            horizontalStackView2.heightAnchor.constraint(equalToConstant: 36).isActive = true
            
            horizontalStackView2.addArrangedSubview(self.nameView)
            self.nameView.setContentHuggingPriority(.required, for: .horizontal)
            
            headerView.addSubview(self.usernameLabel)
            
            self.usernameLabel.topAnchor.constraint(equalTo: horizontalStackView2.bottomAnchor, constant: 8).isActive = true
            self.usernameLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 24).isActive = true
            self.usernameLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -24).isActive = true
            
            headerView.addSubview(self.schoolLabel)
            
            self.schoolLabel.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: 8).isActive = true
            self.schoolLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 24).isActive = true
            self.schoolLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -24).isActive = true
            
            let horizontalStackView3 = UIStackView(frame: .zero)
            horizontalStackView3.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView3.axis = .horizontal
            horizontalStackView3.distribution = .fillEqually
            
            let verticalStackViewX = UIStackView(frame: .zero)
            verticalStackViewX.axis = .vertical
            verticalStackViewX.distribution = .fillEqually
            
            let verticalStackView2X = UIStackView(frame: .zero)
            verticalStackView2X.axis = .vertical
            verticalStackView2X.distribution = .fillEqually
            
            let verticalStackView3X = UIStackView(frame: .zero)
            verticalStackView3X.axis = .vertical
            verticalStackView3X.distribution = .fillEqually
            
            verticalStackViewX.addArrangedSubview(self.scholarshipLabelValueLabel)
            verticalStackViewX.addArrangedSubview(self.scholarshipLabel)
            
            self.scholarshipLabelValueLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            
            verticalStackView2X.addArrangedSubview(self.competitionValueLabel)
            verticalStackView2X.addArrangedSubview(self.competitionLabel)
            
            self.competitionValueLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            
            verticalStackView3X.addArrangedSubview(self.coinsValueLabel)
            verticalStackView3X.addArrangedSubview(self.coinsLabel)
            
            self.coinsValueLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            
            horizontalStackView3.addArrangedSubview(verticalStackViewX)
            horizontalStackView3.addArrangedSubview(verticalStackView2X)
            horizontalStackView3.addArrangedSubview(verticalStackView3X)
            
            headerView.addSubview(horizontalStackView3)
            
            horizontalStackView3.topAnchor.constraint(equalTo: self.schoolLabel.bottomAnchor, constant: 24).isActive = true
            horizontalStackView3.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 8).isActive = true
            horizontalStackView3.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8).isActive = true
            horizontalStackView3.heightAnchor.constraint(equalToConstant: 48).isActive = true
            
            headerView.addSubview(self.followButton)
            
            self.followButton.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                    constant: 24).isActive = true
            self.followButton.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                     constant: -24).isActive = true
            self.followButton.topAnchor.constraint(equalTo: horizontalStackView3.bottomAnchor,
                                                   constant: 24).isActive = true
            self.followButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            headerView.addSubview(self.blockButton)
            
            self.blockButton.leftAnchor.constraint(equalTo: headerView.leftAnchor,
                                                    constant: 24).isActive = true
            self.blockButton.rightAnchor.constraint(equalTo: headerView.rightAnchor,
                                                     constant: -24).isActive = true
            self.blockButton.topAnchor.constraint(equalTo: self.followButton.bottomAnchor,
                                                   constant: 8).isActive = true
            self.blockButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == self.storyCollectionView {
            return CGSize(width: self.storyCollectionView.frame.width, height: 424)
        }
        return .zero
    }
    
}
