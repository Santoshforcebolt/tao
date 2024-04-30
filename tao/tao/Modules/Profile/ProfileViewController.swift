//
//  ProfileViewController.swift
//  tao
//
//  Created by Mayank Khursija on 18/06/22.
//

import Foundation
import UIKit

class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    var userInfoView: UserInfoView = {
        let userInfoView = UserInfoView(renderData: UserInfoView.RenderData(
            imageHeight: 72,
            imageWidth: 72,
            distanceBetweenImageAndLabel: 24,
            textColor: .black,
            showMobileNumber: true))
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        return userInfoView
    }()
    
    var updateProfileButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var followerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var followerValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 20)
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
        label.font = UIFont(name: "Poppins", size: 20)
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
        label.font = UIFont(name: "Poppins", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    } ()
    
    var verifyMyAccountView: ProfileOptionView = {
        let infoView = ProfileOptionView(renderData: ProfileOptionView.RenderData(
            imageWidth: 24,
            leftSpacing: 16,
            font: UIFont(name: "Poppins", size: 14),
            customSpacing: 10,
            height: 48,
            showRightIcon: false))
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.cornerRadius = 8
        return infoView
    }()
    
    var premiumImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.cornerRadius = 8
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var storeHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var supportHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var aboutHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var walletHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    var myTaoHeaderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var myVideosOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var myCertificatesOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var myCompOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var orderOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var manageAddressOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var feedbackOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var supportOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var faqOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var tncOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var privacyOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var myWalletOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var pastTransactionOption: ProfileOptionView = {
        let option = ProfileOptionView()
        option.translatesAutoresizingMaskIntoConstraints = false
        return option
    }()
    
    var referralsOption: ProfileOptionView = {
        let infoView = ProfileOptionView(renderData: ProfileOptionView.RenderData(
            imageWidth: 24,
            leftSpacing: 0,
            font: UIFont(name: "Poppins", size: 14),
            customSpacing: 10,
            height: 48,
            showRightIcon: true))
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.cornerRadius = 8
        return infoView
    }()
    
    var logoutButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .lightBlueBackground
        return button
    }()
    
    override init(_ viewModel: ProfileViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupView()
        self.setupNavigationBar()
        
//        self.updateProfileButton.addTarget(self, action: #selector(verifyAccountTapped), for: .touchUpInside)
        
        if let imageUrlString = TaoHelper.userProfile?.userDetails?.imageUrl,
           let imageUrl = URL(string: imageUrlString) {
            self.userInfoView.setupData(name: TaoHelper.userProfile?.userDetails?.firstName ?? "",
                                        image: .withURL(imageUrl))
        } else {
            //FIXME: Change default image
            self.userInfoView.setupData(name: TaoHelper.userProfile?.userDetails?.firstName ?? "",
                                        image: .withImage(UIImage(named: "defaultLeaderboardPicture")!))
        }
        self.updateProfileButton.setTitle("Update Profile", for: .normal)
        
        self.followerLabel.text = "Followers"
        self.followerValueLabel.text = "\(TaoHelper.userProfile?.userSocialStatResponse?.follower ?? 0)"
        
        self.competitionLabel.text = "Competitions"
        self.competitionValueLabel.text = "\(TaoHelper.userProfile?.userDetails?.competitionCount ?? 0)"
        
        self.followingLabel.text = "Following"
        self.followingValueLabel.text = "\(TaoHelper.userProfile?.userSocialStatResponse?.following ?? 0)"
        
        self.storeHeaderLabel.text = "Tao Store"
        self.supportHeaderLabel.text = "Support"
        self.aboutHeaderLabel.text = "About"
        self.walletHeaderLabel.text = "My Wallet"
        self.myTaoHeaderLabel.text = "My Tao"
        self.orderOption.setupData(image: .withImage(UIImage(named: "orders")!), text: "Orders")
        self.manageAddressOption.setupData(image: .withImage(UIImage(named: "manageAddress")!), text: "Manage Address")
        self.manageAddressOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(manageAddressTapped)))
        
        self.feedbackOption.setupData(image: .withImage(UIImage(named: "feedback")!), text: "Feedback")
        self.supportOption.setupData(image: .withImage(UIImage(named: "support")!), text: "Support")
        self.faqOption.setupData(image: .withImage(UIImage(named: "faq")!), text: "FAQ")
        self.tncOption.setupData(image: .withImage(UIImage(named: "tnc")!), text: "Terms and Condition")
        self.privacyOption.setupData(image: .withImage(UIImage(named: "privacy")!), text: "Privacy Policy")
        self.myWalletOption.setupData(image: .withImage(UIImage(named: "et_wallet")!), text: "My Wallet")
        self.pastTransactionOption.setupData(image: .withImage(UIImage(named: "transaction")!), text: "Past Transactions")
        self.referralsOption.setupData(image: .withImage(UIImage(named: "referral")!),
                                                         text: "My Referrals")
        self.myCompOption.setupData(image: .withImage(UIImage(named: "comp")!), text: "My Competitions")
        self.myVideosOption.setupData(image: .withImage(UIImage(named: "videos")!), text: "My Videos")
        self.myCertificatesOption.setupData(image: .withImage(UIImage(named: "certificates")!), text: "My Certificates")
        
        
        self.verifyMyAccountView.setupData(image: .withImage(UIImage(systemName: "checkmark.circle")!), text: "Verify my account")
        self.verifyMyAccountView.backgroundColor = .lightBlueBackground
        
        self.verifyMyAccountView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(verifyAccountTapped)))
        self.myWalletOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myWalletTapped)))
        self.pastTransactionOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pastTransactionOptionTapped)))
        self.orderOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(orderOptionTapped)))
        self.faqOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(faqOptionTapped)))
        self.tncOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tncOptionTapped)))
        self.privacyOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(privacyPolicyTapped)))
        self.feedbackOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(feedbackTapped)))
        self.supportOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(supportOptionTapped)))
        self.referralsOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(referralOptionTapped)))
        
        self.myCompOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myCompetitionsTapped)))
        self.myVideosOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myVideosTapped)))
        self.myCertificatesOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myCertificatesTapped)))

        if let url = URL(string: ImagesData.premiumImage) {
            self.premiumImageView.sd_setImage(with: url) { _, _, _, _ in
                self.premiumImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.premiumImageViewTapped)))
            }
        }
        
        self.logoutButton.setTitle("Logout", for: .normal)
        self.logoutButton.setTitleColor(.black, for: .normal)
        self.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc func premiumImageViewTapped() {
        self.viewModel.premiumImageTapped()
    }
    
    @objc func myCompetitionsTapped() {
        self.viewModel.showMyCompetitions()
    }
    
    @objc func myVideosTapped() {
        self.viewModel.showMyVideos()
    }
    
    @objc func referralOptionTapped() {
        self.viewModel.showReferralScreen()
    }
    
    @objc func supportOptionTapped() {
        self.viewModel.supportOptionTapped()
    }
    
    @objc func feedbackTapped() {
        self.viewModel.feedbackOptionTapped()
    }
    @objc func faqOptionTapped() {
        self.viewModel.faqOptionTapped()
    }
    
    @objc func tncOptionTapped() {
        self.viewModel.tncOptionTapped()
    }
    
    @objc func privacyPolicyTapped() {
        self.viewModel.privacyPolicyTapped()
    }
    
    @objc func myCertificatesTapped() {
        self.viewModel.showMyCertificates()
    }
    
    @objc func logoutTapped() {
        self.viewModel.logout()
    }
    
    @objc func pastTransactionOptionTapped() {
        self.viewModel.pastTransactionTapped()
    }
    
    @objc func orderOptionTapped() {
        self.viewModel.orderOptionTapped()
    }
    
    @objc func myWalletTapped() {
        self.viewModel.myWalletTapped()
    }
    
    @objc func updateProfileTapped() {
        self.viewModel.verifyAccountTapped()
    }
    
    @objc func verifyAccountTapped() {
        self.viewModel.verifyAccountTapped()
    }
    
    @objc func manageAddressTapped() {
        self.viewModel.manageAddressTapped()
    }
    
    private func setupView() {
        self.containerView.addSubview(self.userInfoView)
        if self.viewModel.profileUpdatable {
            self.containerView.addSubview(self.updateProfileButton)
        }
        
        self.userInfoView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.userInfoView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.userInfoView.topAnchor.constraint(equalTo: self.containerView.topAnchor,
                                               constant: 60).isActive = true
        self.userInfoView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        if self.viewModel.profileUpdatable {
            self.updateProfileButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                    constant: 24).isActive = true
            self.updateProfileButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                     constant: -24).isActive = true
            self.updateProfileButton.topAnchor.constraint(equalTo: self.userInfoView.bottomAnchor,
                                                   constant: 30).isActive = true
            self.updateProfileButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        
        let horizontalStackView = UIStackView(frame: .zero)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        
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
        
        verticalStackView2.addArrangedSubview(self.competitionValueLabel)
        verticalStackView2.addArrangedSubview(self.competitionLabel)
        
        self.competitionValueLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        verticalStackView3.addArrangedSubview(self.followingValueLabel)
        verticalStackView3.addArrangedSubview(self.followingLabel)
        
        self.followingValueLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(verticalStackView2)
        horizontalStackView.addArrangedSubview(verticalStackView3)
        
        self.containerView.addSubview(horizontalStackView)
        
        if self.viewModel.profileUpdatable {
            horizontalStackView.topAnchor.constraint(equalTo: self.updateProfileButton.bottomAnchor, constant: 30).isActive = true
        } else {
            horizontalStackView.topAnchor.constraint(equalTo: self.userInfoView.bottomAnchor, constant: 30).isActive = true
        }
        horizontalStackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 24).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -24).isActive = true
        horizontalStackView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        self.containerView.addSubview(self.premiumImageView)
        
        self.premiumImageView.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 16).isActive = true
        self.premiumImageView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        self.premiumImageView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        self.premiumImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        if !self.viewModel.userVerified {
            self.containerView.addSubview(self.verifyMyAccountView)
            
            self.verifyMyAccountView.topAnchor.constraint(equalTo: self.premiumImageView.bottomAnchor, constant: 16).isActive = true
            self.verifyMyAccountView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
            self.verifyMyAccountView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
            self.verifyMyAccountView.heightAnchor.constraint(equalToConstant: 48).isActive = true

        }
        
        self.containerView.addSubview(self.referralsOption)
        if self.viewModel.userVerified {
            self.referralsOption.topAnchor.constraint(equalTo: self.premiumImageView.bottomAnchor,
                                                   constant: 16).isActive = true
        } else {
            self.referralsOption.topAnchor.constraint(equalTo: self.verifyMyAccountView.bottomAnchor,
                                                   constant: 16).isActive = true
        }
        self.referralsOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.referralsOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.referralsOption.heightAnchor.constraint(equalToConstant: 20).isActive = true

        self.containerView.addSubview(self.myTaoHeaderLabel)
        self.myTaoHeaderLabel.topAnchor.constraint(equalTo: self.referralsOption.bottomAnchor,
                                               constant: 30).isActive = true

        self.myTaoHeaderLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.myTaoHeaderLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        
        self.containerView.addSubview(self.myCompOption)
        self.myCompOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.myCompOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.myCompOption.topAnchor.constraint(equalTo: self.myTaoHeaderLabel.bottomAnchor,
                                               constant: 8).isActive = true
        self.myCompOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.containerView.addSubview(self.myVideosOption)
        self.myVideosOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.myVideosOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.myVideosOption.topAnchor.constraint(equalTo: self.myCompOption.bottomAnchor,
                                               constant: 8).isActive = true
        self.myVideosOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.containerView.addSubview(self.myCertificatesOption)
        self.myCertificatesOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.myCertificatesOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.myCertificatesOption.topAnchor.constraint(equalTo: self.myVideosOption.bottomAnchor,
                                               constant: 8).isActive = true
        self.myCertificatesOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        self.containerView.addSubview(self.walletHeaderLabel)
        self.walletHeaderLabel.topAnchor.constraint(equalTo: self.myCertificatesOption.bottomAnchor,
                                               constant: 30).isActive = true

        self.walletHeaderLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.walletHeaderLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true

        
        self.containerView.addSubview(self.myWalletOption)
        self.myWalletOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.myWalletOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.myWalletOption.topAnchor.constraint(equalTo: self.walletHeaderLabel.bottomAnchor,
                                               constant: 8).isActive = true
        self.myWalletOption.heightAnchor.constraint(equalToConstant: 20).isActive = true

        self.containerView.addSubview(self.pastTransactionOption)
        self.pastTransactionOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.pastTransactionOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.pastTransactionOption.topAnchor.constraint(equalTo: self.myWalletOption.bottomAnchor,
                                               constant: 8).isActive = true
        self.pastTransactionOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.containerView.addSubview(self.storeHeaderLabel)

        self.storeHeaderLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.storeHeaderLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.storeHeaderLabel.topAnchor.constraint(equalTo: self.pastTransactionOption.bottomAnchor,
                                               constant: 30).isActive = true
        
        self.containerView.addSubview(self.orderOption)
        self.orderOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.orderOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.orderOption.topAnchor.constraint(equalTo: self.storeHeaderLabel.bottomAnchor,
                                               constant: 8).isActive = true
        self.orderOption.heightAnchor.constraint(equalToConstant: 20).isActive = true

        self.containerView.addSubview(self.manageAddressOption)
        self.manageAddressOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.manageAddressOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.manageAddressOption.topAnchor.constraint(equalTo: self.orderOption.bottomAnchor,
                                               constant: 8).isActive = true
        self.manageAddressOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.containerView.addSubview(self.supportHeaderLabel)
        self.supportHeaderLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.supportHeaderLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.supportHeaderLabel.topAnchor.constraint(equalTo: self.manageAddressOption.bottomAnchor,
                                               constant: 30).isActive = true
        
        self.containerView.addSubview(self.feedbackOption)
        self.containerView.addSubview(self.supportOption)
        self.containerView.addSubview(self.faqOption)
        
        self.feedbackOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.feedbackOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.feedbackOption.topAnchor.constraint(equalTo: self.supportHeaderLabel.bottomAnchor,
                                               constant: 8).isActive = true
        self.feedbackOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.supportOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.supportOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.supportOption.topAnchor.constraint(equalTo: self.feedbackOption.bottomAnchor,
                                               constant: 8).isActive = true
        self.supportOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.faqOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.faqOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.faqOption.topAnchor.constraint(equalTo: self.supportOption.bottomAnchor,
                                               constant: 8).isActive = true
        self.faqOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.containerView.addSubview(self.aboutHeaderLabel)
        self.aboutHeaderLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.aboutHeaderLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.aboutHeaderLabel.topAnchor.constraint(equalTo: self.faqOption.bottomAnchor,
                                               constant: 30).isActive = true
        
        self.containerView.addSubview(self.tncOption)
        self.containerView.addSubview(self.privacyOption)
        
        self.tncOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.tncOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.tncOption.topAnchor.constraint(equalTo: self.aboutHeaderLabel.bottomAnchor,
                                               constant: 8).isActive = true
        self.tncOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.privacyOption.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.privacyOption.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.privacyOption.topAnchor.constraint(equalTo: self.tncOption.bottomAnchor,
                                               constant: 8).isActive = true
        self.privacyOption.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.containerView.addSubview(self.logoutButton)
        self.logoutButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                constant: 24).isActive = true
        self.logoutButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                 constant: -24).isActive = true
        self.logoutButton.topAnchor.constraint(equalTo: self.privacyOption.bottomAnchor,
                                               constant: 30).isActive = true
        self.logoutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.logoutButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                    constant: -16).isActive = true
        
    }
    
    private func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: .zero)
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
        
        let navigationItem = UINavigationItem(title: "My Profile")
        
        navigationBar.setItems([navigationItem], animated: false)
    }
}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
