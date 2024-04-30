//
//  ActivityListViewController.swift
//  tao
//
//  Created by Mayank Khursija on 01/09/22.
//

import Foundation

class ActivityListViewController: BaseViewController<ActivityListViewModel> {
    var navigationBar: UINavigationBar?
    var transactionCollectionView: UICollectionView
    
    override init(_ viewModel: ActivityListViewModel) {
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
        self.transactionCollectionView.register(CompetitionCollectionViewCell.self,
                                            forCellWithReuseIdentifier: "competitionCell")
        self.transactionCollectionView.showsVerticalScrollIndicator = false
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
        
        let navigationItem = UINavigationItem(title: "Competitions")
        
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
    }
}

extension ActivityListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.competitions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "competitionCell", for: indexPath) as? CompetitionCollectionViewCell ?? CompetitionCollectionViewCell()
        let competition = self.viewModel.competitions[indexPath.row]
        if let compUrl = URL(string: competition.imageUrl ?? "") {
            let endDate = DateConverter.convertDateFormat(competition.endTime ?? "",
                                                          inputFormat: "yyyy-MM-dd'T'HH:mm:ss")
            let days = DateManager.shared.getDaysBetween(date1: Date(), date2: endDate)
            
            if competition.rewardType ?? "COIN" == "COIN" {
                cell.setupData(compImage: .withURL(compUrl),
                               sponsorImage: competition.guide?[0].image,
                               nudgeType: .coin("\(competition.prize ?? 0)"),
                               daysRemaining: days > 0 ? TextType.plain("\(days)"): TextType.clock(endDate))
            } else {
                cell.setupData(compImage: .withURL(compUrl),
                               sponsorImage: competition.guide?[0].image,
                               nudgeType: .money("\(competition.prize ?? 0)"),
                               daysRemaining: days > 0 ? TextType.plain("\(days)"): TextType.clock(endDate))
            }
            cell.cornerRadius = 16
            cell.backgroundColor = .lightBlueBackground
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.transactionCollectionView {
            return CGSize(width: self.transactionCollectionView.frame.size.width - 32, height: 180)
        }
        return .zero
    }
    
}

