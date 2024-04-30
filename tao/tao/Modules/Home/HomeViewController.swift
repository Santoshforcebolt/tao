//
//  HomeViewController.swift
//  tao
//
//  Created by Mayank Khursija on 20/08/22.
//

import Foundation

enum HomeSection: String {
    case category
    case banners
    case academicsHeader
    case academics
    case extraCurricularHeader
    case extraCurricular
    case dailyActivityHeader
    case dailyActivity
    case games
    case trendingHeader
    case trending
    case privateCompetition
    case staticBanners
}


class HomeViewController: BaseViewController<HomeViewModel> {
        
    var dashBoardCollectionView: UICollectionView
    
    var dashboardViews: [HomeSection]?
    
    var navigationBar: UINavigationBar?
    
    
    override init(_ viewModel: HomeViewModel) {
        let dashboardCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        dashboardCollectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        dashboardCollectionViewLayout.scrollDirection = .vertical
        self.dashBoardCollectionView = UICollectionView(frame: .zero,
                                                        collectionViewLayout: dashboardCollectionViewLayout)
        self.dashBoardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.enableScrollView = false
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.setupNavigationBar()
        self.setupView()
        
        self.dashBoardCollectionView.delegate = self
        self.dashBoardCollectionView.dataSource = self
        self.dashBoardCollectionView.showsHorizontalScrollIndicator = false
        self.dashBoardCollectionView.showsVerticalScrollIndicator = false
        self.dashBoardCollectionView.register(BannerCollectionViewCollectionCell.self,
                                              forCellWithReuseIdentifier: HomeSection.banners.rawValue)
        self.dashBoardCollectionView.register(CategoryCollectionViewCollectionCell.self,
                                              forCellWithReuseIdentifier: HomeSection.category.rawValue)
        self.dashBoardCollectionView.register(AcademicCompetitionsCollectionViewCell.self,
                                              forCellWithReuseIdentifier: HomeSection.academics.rawValue)
        self.dashBoardCollectionView.register(CulturalCompetitionsCollectionViewCell.self,
                                              forCellWithReuseIdentifier: HomeSection.extraCurricular.rawValue)
        self.dashBoardCollectionView.register(TrendingVideosCollectionViewCell.self,
                                              forCellWithReuseIdentifier: HomeSection.trending.rawValue)
        self.dashBoardCollectionView.register(DashboardHeaderViewCell.self,
                                              forCellWithReuseIdentifier: "headerCell")
        self.dashBoardCollectionView.register(UINib(nibName: "SpecialComtetitionTableViewCell", bundle: nil), forCellWithReuseIdentifier: "SpecialComtetitionTableViewCell")
        // Register the new collectionViewCell Xib
        self.dashBoardCollectionView.register(UINib(nibName: "CompetitionCollectionViewCellNew", bundle: nil), forCellWithReuseIdentifier: "CompetitionCollectionViewCellNew")
    }
    
    func setupView() {
        self.view.addSubview(self.dashBoardCollectionView)
        self.dashBoardCollectionView.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.view.topAnchor,
                                                          constant: 16).isActive = true
        self.dashBoardCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        self.dashBoardCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        self.dashBoardCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16).isActive = true
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
        
        let navigationItem = UINavigationItem(title: "Home")
        
        let walletButton = UIButton(type: .custom)
        walletButton.setImage(UIImage(named: "wallet"), for: .normal)
        walletButton.addTarget(self, action: #selector(walletTapped), for: .touchUpInside)
        walletButton.backgroundColor = .lightBlueBackground
        walletButton.layer.cornerRadius = 8
        walletButton.tintColor = .black
        walletButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        walletButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        let notificationButton = UIButton(type: .custom)
        notificationButton.setImage(UIImage(named: "notify"), for: .normal)
        notificationButton.addTarget(self, action: #selector(notificationTapped), for: .touchUpInside)
        notificationButton.backgroundColor = .lightBlueBackground
        notificationButton.layer.cornerRadius = 8
        notificationButton.tintColor = .black
        notificationButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        notificationButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: notificationButton),
                                              UIBarButtonItem(customView: walletButton)]
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func reloadView() {
        super.reloadView()
        self.dashboardViews = []
        if let widgetsCount = self.viewModel.banners?.topBanners?.count, widgetsCount > 0 {
            self.dashboardViews?.append(.banners)
        }
        
        if let categoryCount = self.viewModel.competitionCategories?.count, categoryCount > 0 {
            self.dashboardViews?.append(.category)
        }
        
        if let academicCount = self.viewModel.homeDetails?.academicCompetitions?.count, academicCount > 0 {
            self.dashboardViews?.append(.academicsHeader)
            self.dashboardViews?.append(.academics)
        }
        
        if let extraCurricularCount = self.viewModel.homeDetails?.culturalCompetitions?.count, extraCurricularCount > 0 {
            self.dashboardViews?.append(.extraCurricularHeader)
            self.dashboardViews?.append(.extraCurricular)
        }
        
        if let dailyActivityCount = self.viewModel.homeDetails?.activityList?.count, dailyActivityCount > 0 {
            self.dashboardViews?.append(.dailyActivityHeader)
            self.dashboardViews?.append(.dailyActivity)
        }
        
        if let gamesCount = self.viewModel.games?.games?.count, gamesCount > 0 {
            self.dashboardViews?.append(.games)
        }
        
        if let mediaEntries = self.viewModel.homeDetails?.mediaEntryResponseList?.count, mediaEntries > 0 {
            self.dashboardViews?.append(.trendingHeader)
            self.dashboardViews?.append(.trending)
        }
        
        self.dashboardViews?.append(.privateCompetition)
        
        if let widgetsCount = self.viewModel.banners?.staticBanners?.count, widgetsCount > 0 {
            self.dashboardViews?.append(.staticBanners)
        }
        
        self.dashBoardCollectionView.reloadData()
    }
    
    @objc func walletTapped() {
        self.viewModel.walletTapped()
    }
    
    @objc func notificationTapped() {
        self.viewModel.notificationTapped()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dashboardViews?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let view = self.dashboardViews?[indexPath.row]
        switch view {
        case .banners:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSection.banners.rawValue,
                                                          for: indexPath) as? BannerCollectionViewCollectionCell ?? BannerCollectionViewCollectionCell(frame: .zero)
            if let banners = self.viewModel.banners?.topBanners {
                let vm = BannerCollectionViewModel(widgets: banners)
                vm.viewHandler = BaseViewHandler(presentingViewController: self)
                cell.setupData(vm: vm)
            }
            return cell
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSection.category.rawValue,
                                                          for: indexPath) as? CategoryCollectionViewCollectionCell ?? CategoryCollectionViewCollectionCell(frame: .zero)
            if let comps = self.viewModel.competitionCategories {
                let vm = CategoryCollectionViewModel(categories: comps)
                vm.viewHandler = BaseViewHandler(presentingViewController: self)
                cell.setupData(vm: vm)
            }
            return cell
        case .extraCurricular:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSection.extraCurricular.rawValue,
                                                          for: indexPath) as? CulturalCompetitionsCollectionViewCell ?? CulturalCompetitionsCollectionViewCell(frame: .zero)
            if let comps = self.viewModel.homeDetails?.culturalCompetitions {
                let vm = CulturalCompetitionsViewModel(competitions: comps)
                vm.viewHandler = BaseViewHandler(presentingViewController: self)
                cell.setupData(vm: vm)
            }
            return cell
        case .academics:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSection.academics.rawValue,
                                                          for: indexPath) as? AcademicCompetitionsCollectionViewCell ?? AcademicCompetitionsCollectionViewCell(frame: .zero)
            if let comps = self.viewModel.homeDetails?.academicCompetitions {
                let vm = AcademicsCompetitionViewModel(competitions: comps)
                vm.viewHandler = BaseViewHandler(presentingViewController: self)
                cell.setupData(vm: vm)
            }
            return cell
        case .dailyActivity:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSection.extraCurricular.rawValue,
                                                          for: indexPath) as? CulturalCompetitionsCollectionViewCell ?? CulturalCompetitionsCollectionViewCell(frame: .zero)
            if let comps = self.viewModel.homeDetails?.activityList {
                let vm = CulturalCompetitionsViewModel(competitions: comps)
                vm.viewHandler = BaseViewHandler(presentingViewController: self)
                cell.setupData(vm: vm)
            }
            return cell
        case .academicsHeader:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as? DashboardHeaderViewCell ?? DashboardHeaderViewCell(frame: .zero)
            let vm = DashboardHeaderViewModel(header: "Academics") {
                self.viewModel.academicsViewAllTapped()
            }
            cell.setupVm(vm: vm)
            return cell
        case .dailyActivityHeader:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as? DashboardHeaderViewCell ?? DashboardHeaderViewCell(frame: .zero)
            let vm = DashboardHeaderViewModel(header: "Daily Activity") {
                self.viewModel.dailyActivityViewAllTapped()
            }
            cell.setupVm(vm: vm)
            return cell
        case .extraCurricularHeader:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as? DashboardHeaderViewCell ?? DashboardHeaderViewCell(frame: .zero)
            let vm = DashboardHeaderViewModel(header: "Extra-Curricular") {
                self.viewModel.culturalViewAllTapped()
            }
            cell.setupVm(vm: vm)
            return cell
        case .trendingHeader:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "headerCell", for: indexPath) as? DashboardHeaderViewCell ?? DashboardHeaderViewCell(frame: .zero)
            let vm = DashboardHeaderViewModel(header: "Trending Videos") {
                self.viewModel.trendingViewAllTapped()
            }
            cell.setupVm(vm: vm)
            return cell
        case .trending:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSection.trending.rawValue, for: indexPath) as? TrendingVideosCollectionViewCell ?? TrendingVideosCollectionViewCell()
            if let mediaEntry = self.viewModel.homeDetails?.mediaEntryResponseList {
                let vm = TrendingVideosCollectionViewModel(competitions: mediaEntry)
                vm.viewHandler = BaseViewHandler(presentingViewController: self)
                cell.setupData(vm: vm)
            }
            return cell
        case .games:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSection.banners.rawValue,
                                                          for: indexPath) as? BannerCollectionViewCollectionCell ?? BannerCollectionViewCollectionCell(frame: .zero)
            if let games = self.viewModel.games?.games {
                var banners: [Banner] = []
                for game in games {
                    let banner = Banner(active: nil,
                                        audienceIDS: nil,
                                        background: nil,
                                        cta: nil,
                                        endTime: nil,
                                        id: nil,
                                        imageUrl: game.image,
                                        link: game.url,
                                        linkType: nil,
                                        maxAppVersion: nil,
                                        minAppVersion: nil,
                                        name: nil,
                                        priority: nil,
                                        screenType: nil,
                                        startTime: nil,
                                        subText: nil,
                                        subType: nil,
                                        text: nil,
                                        type: nil)
                    banners.append(banner)
                }
                let vm = BannerCollectionViewModel(widgets: banners)
                vm.viewHandler = BaseViewHandler(presentingViewController: self)
                cell.setupData(vm: vm)
            }
            return cell
        case .privateCompetition:
            guard let specialComtetitionTableViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpecialComtetitionTableViewCell", for: indexPath) as? SpecialComtetitionTableViewCell else {
                return UICollectionViewCell()
            }
            specialComtetitionTableViewCell.presentingVC = self
            return specialComtetitionTableViewCell
        case .staticBanners:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSection.banners.rawValue,
                                                          for: indexPath) as? BannerCollectionViewCollectionCell ?? BannerCollectionViewCollectionCell(frame: .zero)
            if let banners = self.viewModel.banners?.staticBanners {
                let vm = BannerCollectionViewModel(widgets: banners)
                vm.viewHandler = BaseViewHandler(presentingViewController: self)
                cell.setupData(vm: vm)
            }
            return cell
        case .none:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let view = self.dashboardViews?[indexPath.row]
        switch view {
        case .banners:
            return CGSize(width: collectionView.frame.width, height: 116)
        case .category:
            return CGSize(width: collectionView.frame.width, height: 90)
        case .extraCurricular:
            return CGSize(width: collectionView.frame.width, height: 180)
        case .academics:
            return CGSize(width: collectionView.frame.width, height: 180)
        case .dailyActivity:
            return CGSize(width: collectionView.frame.width, height: 180)
        case .academicsHeader:
            return CGSize(width: collectionView.frame.width, height: 40)
        case .dailyActivityHeader:
            return CGSize(width: collectionView.frame.width, height: 40)
        case .extraCurricularHeader:
            return CGSize(width: collectionView.frame.width, height: 40)
        case .trendingHeader:
            return CGSize(width: collectionView.frame.width, height: 40)
        case .trending:
            return CGSize(width: collectionView.frame.width, height: 120)
        case .privateCompetition:
            return CGSize(width: collectionView.frame.width, height: 200)
        case .staticBanners:
            return CGSize(width: collectionView.frame.width, height: 116)
        case .games:
            return CGSize(width: collectionView.frame.width, height: 116)
        case .none:
            return .zero
        }
    }
}

