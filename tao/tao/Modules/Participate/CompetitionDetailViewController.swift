//
//  CompetitionDetailViewController.swift
//  tao
//
//  Created by Mayank Khursija on 02/06/22.
//

import Foundation
import UIKit

class CompetitionDetailViewController: BaseViewController<CompetitionDetailViewModel> {
    
    var navigationBar: UINavigationBar?
    var detailsCollectionView: UICollectionView
    
    var competitionImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var competitionTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var overviewButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Poppins", size: 12)
        button.backgroundColor = UIColor.init(hex: "#7284F5")
        button.cornerRadius = 15
        
        return button
    }()
    
    var leaderBoardButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Poppins", size: 12)
        button.backgroundColor = .blueBackground
        button.cornerRadius = 15
        return button
    }()
    
    var switcherView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(_ viewModel: CompetitionDetailViewModel) {
        let transactionCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        transactionCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        transactionCollectionViewLayout.scrollDirection = .vertical
        self.detailsCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: transactionCollectionViewLayout)
        self.detailsCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.competitionImageView.image = UIImage(systemName: "clock")
        self.competitionTitleLabel.text = "Some Title\nBigTitle"
        
        self.overviewButton.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        self.leaderBoardButton.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        self.overviewButton.setTitle("Overview", for: .normal)
        self.leaderBoardButton.setTitle("Leaderboard", for: .normal)
        self.leaderBoardButton.setTitleColor(.white, for: .normal)
        
        self.switcherView.backgroundColor = .blueBackground
        self.switcherView.cornerRadius = 20
        
        self.overviewButton.addTarget(self, action: #selector(overviewButtonTapped), for: .touchUpInside)
        self.leaderBoardButton.addTarget(self, action: #selector(leaderBoardButtonTapped), for: .touchUpInside)
        
        self.detailsCollectionView.delegate = self
        self.detailsCollectionView.dataSource = self
        self.detailsCollectionView.showsHorizontalScrollIndicator = false
        self.detailsCollectionView.register(CompetitionDetailOverviewCell.self, forCellWithReuseIdentifier: "cell")
        self.detailsCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        self.detailsCollectionView.showsVerticalScrollIndicator = false

       
    }
    
    @objc func overviewButtonTapped() {
        self.overviewButton.backgroundColor = UIColor.init(hex: "#7284F5")
        self.overviewButton.setTitleColor(.white, for: .normal)
        self.leaderBoardButton.backgroundColor = .blueBackground
        self.leaderBoardButton.setTitleColor(.white, for: .normal)
    }
    
    @objc func leaderBoardButtonTapped() {
        self.leaderBoardButton.backgroundColor = UIColor.init(hex: "#7284F5")
        self.leaderBoardButton.setTitleColor(.white, for: .normal)
        self.overviewButton.backgroundColor = .blueBackground
        self.overviewButton.setTitleColor(.white, for: .normal)
        
    }
    
    func setupView() {
        self.view.addSubview(self.detailsCollectionView)
        
        self.detailsCollectionView.topAnchor.constraint(
            equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
            constant: 16).isActive = true
        self.detailsCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,
                                                             constant: 8).isActive = true
        self.detailsCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor,
                                                              constant: -8).isActive = true
        self.detailsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
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
        
        let navigationItem = UINavigationItem(title: "")
        
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

extension CompetitionDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CompetitionDetailOverviewCell ?? CompetitionDetailOverviewCell()
        cell.setupData(rules: "Rules\n\n1. Do ABC\n2.DO not do XYZ")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.detailsCollectionView {
            return CGSize(width: self.detailsCollectionView.frame.size.width - 32,
                          height: self.detailsCollectionView.frame.size.height)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.detailsCollectionView, kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath)
            headerView.addSubview(self.competitionImageView)
            headerView.addSubview(self.competitionTitleLabel)
            headerView.addSubview(self.switcherView)
            
            self.competitionImageView.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16).isActive = true
            self.competitionImageView.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16).isActive = true
            self.competitionImageView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? headerView.topAnchor,
                                                           constant: 16).isActive = true
            self.competitionImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
            
            self.competitionTitleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16).isActive = true
            self.competitionTitleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16).isActive = true
            self.competitionTitleLabel.topAnchor.constraint(equalTo: self.competitionImageView.bottomAnchor,
                                                           constant: 16).isActive = true
            
            self.switcherView.topAnchor.constraint(equalTo: self.competitionTitleLabel.bottomAnchor,
                                                  constant: 16).isActive = true
            self.switcherView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
            self.switcherView.heightAnchor.constraint(equalToConstant: 48).isActive = true
            self.switcherView.widthAnchor.constraint(equalToConstant: 252).isActive = true
            
            self.switcherView.addSubview(self.overviewButton)
            self.switcherView.addSubview(self.leaderBoardButton)
            
            self.overviewButton.leftAnchor.constraint(equalTo: self.switcherView.leftAnchor,
                                                        constant: 8).isActive = true
            self.overviewButton.topAnchor.constraint(equalTo: self.switcherView.topAnchor,
                                                       constant: 8).isActive = true
            self.overviewButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
            self.overviewButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            
            self.leaderBoardButton.leftAnchor.constraint(equalTo: self.overviewButton.rightAnchor, constant: 16).isActive = true
            self.leaderBoardButton.topAnchor.constraint(equalTo: self.switcherView.topAnchor,
                                                       constant: 8).isActive = true
            self.leaderBoardButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
            self.leaderBoardButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 270)
    }
}
