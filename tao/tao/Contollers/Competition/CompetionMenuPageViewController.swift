//
//  CompetionMenuPageViewController.swift
//  tao
//
//  Created by Betto Akkara on 14/04/22.
//

import UIKit



enum CompetionMenuPageViewTypes{
    case details
    case leadBoard
    case entries
    case learn
}

enum DetailsCells : Int{
    case rule = 0
    case banners = 1
    case prize = 2
    case score = 3
    case info = 4
}
enum EntriesCells {
    case mediacells
}
enum LeadboardCells {
        
}
enum LearnCells {
    
}

protocol CompetionMenuPageViewDelegate : AnyObject{
    func getTableViewHeight(value : CGFloat)
}

class CompetionMenuPageViewController: UIViewController {

    var type : CompetionMenuPageViewTypes = .details
    
    var detsilsCells : [DetailsCells] = []
    var entriesCells : [EntriesCells] = []
    var learnCells : [LearnCells] = []
    var leadboardCells : [LeadboardCells] = []
    var leaderBoards: [LeaderBoard]?
    var rewardType: RewardType = .coin
    var competitionRewards: [CompetitionReward] = []
    var completitionDetails : Activity?
    var academicCompetition : AcademicCompetitions?
    var competitionType : CompetitionDetailedViewControllerType = .detailedView
    
    var bannerIndex : Int = 0
    
    @IBOutlet weak var tableView : UITableView!
    
    weak var delegate : CompetionMenuPageViewDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch competitionType {
        case .detailedView:
            TaoHelper.competitionId = completitionDetails?.id ?? ""
            
            switch self.type {
            case .details:
                let parameters_getCompRewardRule = [
                    "type" : "COMPETITION",
                    "competitionId":completitionDetails?.id ?? ""
                ]
                APIDataProvider.init().getCompRewardRule(urlParams: parameters_getCompRewardRule) { response in
                    if let rewards = response?.body?.rewards {
                        self.competitionRewards.append(contentsOf: rewards)
                    }
                    self.rewardType = RewardType(rawValue: response?.body?.rewardType ?? "COIN") ?? .coin
                } onError: { error in
                    print("--------------------")
                    print(error?.debugDescription)
                    print("--------------------")
                }
                
                self.detsilsCells.append(.rule)
                self.detsilsCells.append(.info)
                self.detsilsCells.append(.prize)
                self.detsilsCells.append(.score)
                self.completitionDetails?.guide?.forEach({ guide in
                    self.detsilsCells.append(.banners)
                })
                self.detsilsCells.sort{$0.rawValue < $1.rawValue}
            
                self.tableView.register(UINib(nibName: RulesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RulesTableViewCell.identifier)
                self.tableView.register(UINib(nibName: ActionBannerTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ActionBannerTableViewCell.identifier)
                self.tableView.register(UINib(nibName: PrizeDistributionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PrizeDistributionTableViewCell.identifier)
                self.tableView.register(UINib(nibName: CompetitionInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompetitionInfoTableViewCell.identifier)
                self.tableView.register(UINib(nibName: CompetitionScoreTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompetitionScoreTableViewCell.identifier)
                
                self.tableView.delegate = self
                self.tableView.dataSource = self
                
                self.tableView.reloadData()
                
                break
            case .leadBoard:
                APIDataProvider.init().getCompetitionLeaderboard() { success in
                    self.leaderBoards = success?.leaderboardData
                    DispatchQueue.main.async {
                        self.tableView.register(TransactionTableViewCell.self,
                                                forCellReuseIdentifier: "leaderCell")
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.reloadData()
                    }
                } onError: { error in
                    print("error")
                }
            case .entries:
                
                TaoHelper.competitionId = completitionDetails?.id ?? ""
                
    //            APIDataProvider.init().getCompEntries { data in
    //                print(data)
    //            } onError: { error in
    //                print(error)
    //            }
                
                self.tableView.register(UINib(nibName: ActivityViewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ActivityViewsTableViewCell.identifier)
                
                self.tableView.delegate = self
                self.tableView.dataSource = self
                
                self.tableView.reloadData()
                
                break
            case .learn:
                
                break
            }
        case .detailedView_extraCaricular:
            break
        case .detailedView_accademic:
            TaoHelper.competitionId = academicCompetition?.id ?? ""
            
            switch self.type {
            case .details:
                let parameters_getCompRewardRule = [
                    "type" : "COMPETITION",
                    "competitionId":academicCompetition?.id ?? ""
                ]
                APIDataProvider.init().getCompRewardRule(urlParams: parameters_getCompRewardRule) { response in
                    if let rewards = response?.body?.rewards {
                        self.competitionRewards.append(contentsOf: rewards)
                    }
                    self.rewardType = RewardType(rawValue: response?.body?.rewardType ?? "COIN") ?? .coin
                } onError: { error in
                    print("--------------------")
                    print(error?.debugDescription)
                    print("--------------------")
                }
                
                self.detsilsCells.append(.rule)
                self.detsilsCells.append(.info)
                self.detsilsCells.append(.prize)
                self.detsilsCells.append(.score)
                self.academicCompetition?.guide?.forEach({ guide in
                    self.detsilsCells.append(.banners)
                })
                self.detsilsCells.sort{$0.rawValue < $1.rawValue}
            
                self.tableView.register(UINib(nibName: RulesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RulesTableViewCell.identifier)
                self.tableView.register(UINib(nibName: ActionBannerTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ActionBannerTableViewCell.identifier)
                self.tableView.register(UINib(nibName: PrizeDistributionTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PrizeDistributionTableViewCell.identifier)
                self.tableView.register(UINib(nibName: CompetitionInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompetitionInfoTableViewCell.identifier)
                self.tableView.register(UINib(nibName: CompetitionScoreTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CompetitionScoreTableViewCell.identifier)
                
                self.tableView.delegate = self
                self.tableView.dataSource = self
                
                self.tableView.reloadData()
                
                break
            case .leadBoard:
                APIDataProvider.init().getCompetitionLeaderboard() { success in
                    self.leaderBoards = success?.leaderboardData
                    DispatchQueue.main.async {
                        self.tableView.register(TransactionTableViewCell.self,
                                                forCellReuseIdentifier: "leaderCell")
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.reloadData()
                    }
                } onError: { error in
                    print("error")
                }
            case .entries:
                
                TaoHelper.competitionId = completitionDetails?.id ?? ""
                
    //            APIDataProvider.init().getCompEntries { data in
    //                print(data)
    //            } onError: { error in
    //                print(error)
    //            }
                
                self.tableView.register(UINib(nibName: ActivityViewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ActivityViewsTableViewCell.identifier)
                
                self.tableView.delegate = self
                self.tableView.dataSource = self
                
                self.tableView.reloadData()
                
                break
            case .learn:
                
                break
            }
        }
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                delegate?.getTableViewHeight(value: newsize.height)
            }
        }
    }
    
    
//    override func viewWillDisappear(_ animated: Bool) {
//        self.tableView.removeObserver(self, forKeyPath: "contentSize")
//        super.viewWillDisappear(true)
//    }

}


extension CompetionMenuPageViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch self.type {
        case .details:
            return detsilsCells.count
        case .leadBoard:
            return leaderBoards?.count ?? 0
        case .entries:
            return entriesCells.count
        case .learn:
            return learnCells.count
        }
        
    }
    fileprivate func loadDetailsViewCells(_ indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        switch self.detsilsCells[indexPath.row] {
            
        case .rule:
            let cell = tableView.dequeueReusableCell(withIdentifier: RulesTableViewCell.identifier, for: indexPath) as? RulesTableViewCell
            switch competitionType {
            case .detailedView:
                cell?.setData(title: "Rules", content: "<p>Sing your favourite patriotic song.</p>" +
                              "<p>Here is how the competetion works.</p>" +
                              "<p>1. Click the participate button</p>" +
                              "<p>2. Record a video in 1:30 minutes and upload on Tao</p>" +
                              "<p>3. Hit the Submit button & turn on the remind me button</p>")
            case .detailedView_extraCaricular:
                break
            case .detailedView_accademic:
                cell?.setData(title: "Rules", content: "<p> Academic Competiton: Sing your favourite patriotic song.</p>" +
                              "<p>Here is how the competetion works.</p>" +
                              "<p>1. Click the participate button</p>" +
                              "<p>2. Record a video in 1:30 minutes and upload on Tao</p>" +
                              "<p>3. Hit the Submit button & turn on the remind me button</p>")
            }

            
            return cell!
            
        case .banners:
            switch competitionType {
                
            case .detailedView:
                if self.completitionDetails?.guide?.count ?? 0 > 0 {
                    var totalCount = ((self.completitionDetails?.guide?.count ?? 0) - 1)
                    totalCount = totalCount - self.bannerIndex
                    self.bannerIndex = self.bannerIndex + 1
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: ActionBannerTableViewCell.identifier, for: indexPath) as? ActionBannerTableViewCell
                    
                    if let guide = (completitionDetails?.guide?[totalCount]) {
                        cell?.setData(data: guide, info: "")
                        return cell!
                    }
                }
            case .detailedView_extraCaricular:
                break
            case .detailedView_accademic:
                if self.academicCompetition?.guide?.count ?? 0 > 0 {
                    var totalCount = ((self.academicCompetition?.guide?.count ?? 0) - 1)
                    totalCount = totalCount - self.bannerIndex
                    self.bannerIndex = self.bannerIndex + 1
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: ActionBannerTableViewCell.identifier, for: indexPath) as? ActionBannerTableViewCell
                    
                    if let guide = (academicCompetition?.guide?[totalCount]) {
                        cell?.setData(data: guide, info: "")
                        return cell!
                    }
                }
            }

            return UITableViewCell()
        case .prize:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PrizeDistributionTableViewCell.identifier, for: indexPath) as? PrizeDistributionTableViewCell
            cell?.setData(icon: #imageLiteral(resourceName: "ic_prize.pdf"),
                          title: "Prize Dristribution",
                          competionRewards: self.competitionRewards,
                          rewardType: self.rewardType)
            
            return cell!
        case .score :
            let cell = tableView.dequeueReusableCell(withIdentifier: CompetitionScoreTableViewCell.identifier, for: indexPath) as? CompetitionScoreTableViewCell
            
            switch competitionType {
            case .detailedView:
                cell?.setData(title: "How  we score participants",
                              img1: completitionDetails?.evaluationDetails?.left?.first?.image ?? "",
                              img2: completitionDetails?.evaluationDetails?.left?.last?.image ?? "",
                              img3: completitionDetails?.evaluationDetails?.total?.image ?? "",
                              str1: completitionDetails?.evaluationDetails?.left?.first?.text ?? "",
                              str2: completitionDetails?.evaluationDetails?.left?.last?.text ?? "",
                              str3: completitionDetails?.evaluationDetails?.total?.text ?? "",
                              percent1: completitionDetails?.evaluationDetails?.left?.first?.percentage ?? "",
                              percent2: completitionDetails?.evaluationDetails?.left?.last?.percentage ?? "",
                              percent3: completitionDetails?.evaluationDetails?.total?.percentage ?? "")
            case .detailedView_extraCaricular:
                break
            case .detailedView_accademic:
                cell?.setData(title: "How  we score participants",
                              img1: academicCompetition?.evaluationDetails?.left?.first?.image ?? "",
                              img2: academicCompetition?.evaluationDetails?.left?.last?.image ?? "",
                              img3: academicCompetition?.evaluationDetails?.total?.image ?? "",
                              str1: academicCompetition?.evaluationDetails?.left?.first?.text ?? "",
                              str2: academicCompetition?.evaluationDetails?.left?.last?.text ?? "",
                              str3: academicCompetition?.evaluationDetails?.total?.text ?? "",
                              percent1: academicCompetition?.evaluationDetails?.left?.first?.percentage ?? "",
                              percent2: academicCompetition?.evaluationDetails?.left?.last?.percentage ?? "",
                              percent3: academicCompetition?.evaluationDetails?.total?.percentage ?? "")
            }

            return cell!
            
        case .info :
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CompetitionInfoTableViewCell.identifier, for: indexPath) as? CompetitionInfoTableViewCell
            switch competitionType {
            case .detailedView:
                cell?.setData(title: "Description", info: completitionDetails?.description ?? "")
            case .detailedView_extraCaricular:
                break
            case .detailedView_accademic:
                cell?.setData(title: "Description", info: academicCompetition?.description ?? "")
            }
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch self.type {
        case .details:
            return self.loadDetailsViewCells(indexPath, tableView)
        case .leadBoard:
            let cell = tableView.dequeueReusableCell(withIdentifier: "leaderCell") as? TransactionTableViewCell ?? TransactionTableViewCell(style: .default,
                                                                                                                                            reuseIdentifier: "leaderCell")
            
            if let leaderBoard = self.leaderBoards?[indexPath.row] {
                switch self.rewardType {
                case .cash:
                    cell.updateNudgeType(type: .money("\(leaderBoard.reward ?? 0)"))
                case .coin:
                    cell.updateNudgeType(type: .coin("\(leaderBoard.reward ?? 0)"))
                }
                if let urlString = leaderBoard.imageUrl,
                   let url = URL(string: urlString) {
                    cell.setupData(title: leaderBoard.username ?? "",
                                   image: .withURL(url),
                                   info: leaderBoard.school?.schoolName ?? "",
                                   subInfo: nil)
                } else {
                    cell.setupData(title: leaderBoard.username ?? "",
                                   image: .withImage(UIImage(systemName: "clock")!),
                                   info: leaderBoard.school?.schoolName ?? "",
                                   subInfo: nil)
                }
                cell.showCounter(text: "\(leaderBoard.rank ?? 0)")
            }
            return cell
        case .entries, .learn:
            return UITableViewCell()
        }
        
    }

}
