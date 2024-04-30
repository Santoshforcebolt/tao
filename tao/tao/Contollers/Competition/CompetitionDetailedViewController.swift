//
//  CompetitionDetailedViewController.swift
//  tao
//
//  Created by Betto Akkara on 06/04/22.
//

import UIKit


enum CompetitionDetailedViewControllerType{
    
    case detailedView
    case detailedView_extraCaricular
    case detailedView_accademic
    
}

enum CompetitionDetailedViewTypes {
    
    case header
    case detailSection
    
}


class CompetitionDetailedViewController: UIViewController, CAPSPageMenuDelegate {
    
    // Header View
    @IBOutlet weak var participationButton: UIButton!
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var c_title: UILabel!
    @IBOutlet weak var sponser_lbl: UILabel!
    @IBOutlet weak var sponser1: UIImageView!
    @IBOutlet weak var sponser2: UIImageView!
    @IBOutlet weak var sponser3: UIImageView!
    @IBOutlet weak var isSubmitted: UILabel!
    @IBOutlet weak var infoView1: UIView!
    @IBOutlet weak var infoView1_img: UIImageView!
    @IBOutlet weak var infoView1_lbl: UILabel!
    @IBOutlet weak var infoView2: UIView!
    @IBOutlet weak var infoView2_img: UIImageView!
    @IBOutlet weak var infoView2_lbl: UILabel!
    @IBOutlet weak var infoView2_height: NSLayoutConstraint!
    @IBOutlet weak var participants_img: UIImageView!
    @IBOutlet weak var participants_lbl: UILabel!
    
    @IBOutlet weak var seeLeaderBoardButton: UIButton!
    @IBOutlet weak var seeEntriesButton: UIButton!
    // Page Section
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageViewHeight: NSLayoutConstraint!

    var capsPageMenu : CAPSPageMenu!
    var controllerArray : [UIViewController] = []
    
    var completitionDetails : Activity?
    var academicCompetition : AcademicCompetitions?
    var competitionId: String?
    
    var type : CompetitionDetailedViewControllerType = .detailedView
    
    var isParticipated: Bool = false
    var rank: Int?
    
    let taoNavigationController = TaoNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var parameters: [String: String]?
        
        if completitionDetails == nil && academicCompetition == nil && competitionId != nil {
            ApiProviderImpl.instance.competitionApi.getCompetition(by: competitionId ?? "") { comp, error in
                if error != nil {
                    //
                } else {
                    if comp?.categoryType == "ACADEMIC" {
                        self.academicCompetition = comp
                        self.type = .detailedView_accademic
                        self.seeEntriesButton.isEnabled = false
                        self.seeEntriesButton.setTitle("No Entries", for: .disabled)
                    } else {
                        self.academicCompetition = comp
                        self.type = .detailedView
                        self.completitionDetails = Activity(rewardType: self.academicCompetition?.rewardType,
                                                            entryFee: self.academicCompetition?.entryFee,
                                                            status: self.academicCompetition?.status,
                                                            participationCount: self.academicCompetition?.participationCount,
                                                            maxAge: self.academicCompetition?.maxAge,
                                                            rewardRuleId: self.academicCompetition?.rewardRuleId,
                                                            createdTimeStamp: self.academicCompetition?.createdTimeStamp,
                                                            background: self.academicCompetition?.background,
                                                            endTime: self.academicCompetition?.endTime,
                                                            activity: self.academicCompetition?.activity,
                                                            name: self.academicCompetition?.name,
                                                            priority: self.academicCompetition?.priority,
                                                            prize: self.academicCompetition?.prize,
                                                            imageUrl: self.academicCompetition?.imageUrl,
                                                            id: self.academicCompetition?.id,
                                                            paid: self.academicCompetition?.paid,
                                                            contentMaxDuration: self.academicCompetition?.contentMaxDuration,
                                                            participationCloseTime: self.academicCompetition?.participationCloseTime,
                                                            subCategory: self.academicCompetition?.subCategory,
                                                            minParticipants: self.academicCompetition?.minParticipants,
                                                            certificateGenerated: self.academicCompetition?.certificateGenerated,
                                                            minAge: self.academicCompetition?.minAge,
                                                            standards: self.academicCompetition?.standards,
                                                            maxParticipants: self.academicCompetition?.maxParticipants,
                                                            sample: self.academicCompetition?.sample,
                                                            mediaType: self.academicCompetition?.mediaType,
                                                            guide: self.academicCompetition?.guide,
                                                            startTime: self.academicCompetition?.startTime,
                                                            evaluationDetails: self.academicCompetition?.evaluationDetails,
                                                            categoryType: self.academicCompetition?.categoryType,
                                                            description: self.academicCompetition?.description,
                                                            sponsorDetails: nil,
                                                            categoryImage: self.academicCompetition?.categoryImage)
                        self.academicCompetition = nil
                    }
                    
                    switch self.type {
                    case .detailedView:
                        self.detailedViewConfig()
                        parameters = [
                            "competitionId":self.completitionDetails?.id ?? "",
                            "userId":TaoHelper.userID ?? ""
                        ]
                    case .detailedView_extraCaricular:
                        self.detailedView_extraCaricularConfig()
                    case .detailedView_accademic:
                        self.seeEntriesButton.isEnabled = false
                        self.seeEntriesButton.setTitle("No Entries", for: .disabled)
                        self.detailedView_accademicConfig()
                        parameters = [
                            "competitionId":self.academicCompetition?.id ?? "",
                            "userId":TaoHelper.userID ?? ""
                        ]
                    }

                    
                    APIDataProvider.init().getParticipation(urlParams: parameters) { response in
                        //MARK: Confirm ATTEMPTING Scenario
                        //FIXME: Use enum for participationStatus
                        if response?.participationStatus == "" ||
                            response?.participationStatus == "REGISTERED" ||
                            response?.participationStatus == "ATTEMPTING"
                        {
                            self.isParticipated = true
                            DispatchQueue.main.async {
                                self.participationButton.setTitle(response?.participationStatus ?? "Participated", for: .normal)
                                self.participationButton.isUserInteractionEnabled = false
                                self.participationButton.isEnabled = false
                                self.participationButton.backgroundColor = .systemYellow
                                self.participationButton.setTitleColor(.white, for: .disabled)
                            }
                        }
                        if response?.participationStatus == "EVALUATED" ||
                            response?.participationStatus == "SUBMITTED" {
                            DispatchQueue.main.async {
                                self.participationButton.setTitle(response?.participationStatus ?? "Participated", for: .normal)
                                self.participationButton.isUserInteractionEnabled = false
                                self.participationButton.isEnabled = false
                                self.participationButton.backgroundColor = .systemGreen
                                self.participationButton.setTitleColor(.white, for: .disabled)
                            }
                        }
                        if response?.participationStatus == "REJECTED" {
                            DispatchQueue.main.async {
                                self.participationButton.setTitle(response?.participationStatus ?? "Participated", for: .normal)
                                self.participationButton.isUserInteractionEnabled = false
                                self.participationButton.isEnabled = false
                                self.participationButton.backgroundColor = .red
                                self.participationButton.setTitleColor(.white, for: .disabled)
                            }
                        }
                        self.rank = response?.rank
                    } onError: { error in
                        print("error")
                    }

                }
            }
        } else {
            switch type {
            case .detailedView:
                self.detailedViewConfig()
                parameters = [
                    "competitionId":completitionDetails?.id ?? "",
                    "userId":TaoHelper.userID ?? ""
                ]
                break
            case .detailedView_extraCaricular:
                self.detailedView_extraCaricularConfig()
                parameters = [
                    "competitionId":completitionDetails?.id ?? "",
                    "userId":TaoHelper.userID ?? ""
                ]
                break
            case .detailedView_accademic:
                self.detailedView_accademicConfig()
                parameters = [
                    "competitionId":academicCompetition?.id ?? "",
                    "userId":TaoHelper.userID ?? ""
                ]
                break
            }

            
            APIDataProvider.init().getParticipation(urlParams: parameters) { response in
                //MARK: Confirm ATTEMPTING Scenario
                //FIXME: Use enum for participationStatus
                if response?.participationStatus == "" ||
                    response?.participationStatus == "REGISTERED" ||
                    response?.participationStatus == "REJECTED" ||
                    response?.participationStatus == "ATTEMPTING" {
                    self.isParticipated = true
                    DispatchQueue.main.async {
                        self.participationButton.setTitle(response?.participationStatus ?? "Participated", for: .normal)
                        self.participationButton.isUserInteractionEnabled = false
                        self.participationButton.isEnabled = false
                        
                    }
                }
            } onError: { error in
                print("error")
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func detailedViewConfig(){
        
        if (self.completitionDetails?.activity ?? true) {
            self.seeLeaderBoardButton.isEnabled = false
            self.seeLeaderBoardButton.setTitle("No leaderboard", for: .disabled)
        }
        self.banner.backgroundColor = UIColor(hex: completitionDetails?.background ?? "#ffffff")
        self.banner.sd_setImage(with: URL(string: completitionDetails?.imageUrl ?? ""))
        self.c_title.text = completitionDetails?.name ?? ""//?.convertHtml()
        self.c_title.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.sponser_lbl.text = "Sponsored by"
        self.sponser_lbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        var urlOfSponsors: [URL] = []
        
        if let imageUrlStrings = self.completitionDetails?.sponsorDetails {
            let splitUrlStrings = imageUrlStrings.split(separator: ",")
            for urlString in splitUrlStrings {
                if let url = URL(string: String(urlString)) {
                    urlOfSponsors.append(url)
                }
            }
        }
        
        if urlOfSponsors.count == 0 {
            self.sponser_lbl.isHidden = true
        } else if urlOfSponsors.count == 1 {
            self.sponser1.sd_setImage(with: urlOfSponsors[0])
        } else if urlOfSponsors.count == 2 {
            self.sponser1.sd_setImage(with: urlOfSponsors[0])
            self.sponser2.sd_setImage(with: urlOfSponsors[1])
        } else {
            self.sponser1.sd_setImage(with: urlOfSponsors[0])
            self.sponser2.sd_setImage(with: urlOfSponsors[1])
            self.sponser3.sd_setImage(with: urlOfSponsors[2])
        }
//        self.isSubmitted.text = completitionDetails.
//        self.infoView1
        self.infoView1_img.image = #imageLiteral(resourceName: "ic_calender.png")
        self.infoView1_lbl.text = "Last date to participate: \(DateConverter.convertDateFormat("\((completitionDetails?.endTime ?? "").split(separator: "T").first ?? "")", inputFormat: "yyyy-MM-dd", outputFormat: "dd MMMM yyyy") ?? "")"
        self.sponser_lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.infoView2_img.image = #imageLiteral(resourceName: "rank.pdf")
        self.infoView2_lbl.text = completitionDetails?.categoryType
        self.sponser_lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.infoView2_height.constant = 20
        self.infoView2.isHidden = false
        self.participants_lbl.text = "and \n\((completitionDetails?.participationCount ?? 3 - 3)) others"
        
        
        let details = storyboard?.instantiateViewController(withIdentifier: "CompetionMenuPageViewController") as! CompetionMenuPageViewController
//        let details = CompetionMenuPageViewController()
        details.title = "  Details    "
        details.type = .details
        details.completitionDetails = completitionDetails
        details.delegate = self
        controllerArray.append(details)
        
//        let leardBoard = storyboard?.instantiateViewController(withIdentifier: "CompetionMenuPageViewController") as! CompetionMenuPageViewController
////        let leardBoard = CompetionMenuPageViewController()
//        leardBoard.title = "  LeardBoard    "
//        leardBoard.type = .leadBoard
//        leardBoard.completitionDetails = completitionDetails
//        controllerArray.append(leardBoard)
        
//        let entries = storyboard?.instantiateViewController(withIdentifier: "CompetionMenuPageViewController") as! CompetionMenuPageViewController
//        entries.title = "  Entries    "
//        entries.type = .entries
//        entries.completitionDetails = completitionDetails
//        entries.delegate = self
//        controllerArray.append(entries)
//
//        let learn = storyboard?.instantiateViewController(withIdentifier: "CompetionMenuPageViewController") as! CompetionMenuPageViewController
//        learn.title = "  Learn    "
//        learn.type = .learn
//        learn.completitionDetails = completitionDetails
//        learn.delegate = self
//        controllerArray.append(learn)
        
        DispatchQueue.main .async {
            print(self.controllerArray.count)
            self.capsPageMenu?.delegate = self
            let parameters: [CAPSPageMenuOption] = CAPSPageMenuOption.defaultOptions(isHairlineNeeded: true, backgroundColor: .white)
            self.capsPageMenu = CAPSPageMenu(viewControllers: self.controllerArray, frame: self.pageView.bounds, pageMenuOptions: parameters)
            self.pageView.addSubview(self.capsPageMenu!.view)
        }
        
    }
    
    
    @IBAction func seeLeaderboardTapped(_ sender: Any) {
        let viewModel = LeaderBoardCompetitionViewModel()
        let viewController = LeaderBoardCompetitionViewController(viewModel)
        let viewHandler = BaseViewHandler(presentingViewController: self)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        viewHandler.pushViewController(viewController: viewController)
    }
    
    func detailedView_extraCaricularConfig(){
        
    }
    
    func detailedView_accademicConfig(){
        if (self.academicCompetition?.activity ?? false) {
            self.seeLeaderBoardButton.isEnabled = false
            self.seeLeaderBoardButton.setTitle("No leaderboard", for: .disabled)
        }
        
        self.seeEntriesButton.isEnabled = false
        self.seeEntriesButton.setTitle("No Entries", for: .disabled)
        self.banner.backgroundColor = UIColor(hex: academicCompetition?.background ?? "")
        self.banner.sd_setImage(with: URL(string: academicCompetition?.imageUrl ?? ""))
        self.c_title.text = academicCompetition?.name ?? ""//?.convertHtml()
        self.c_title.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.sponser_lbl.text = "Sponsored by"
        self.sponser_lbl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        var urlOfSponsors: [URL] = []
        
        if urlOfSponsors.count == 0 {
            self.sponser_lbl.isHidden = true
        } else if urlOfSponsors.count == 1 {
            self.sponser1.sd_setImage(with: urlOfSponsors[0])
        } else if urlOfSponsors.count == 2 {
            self.sponser1.sd_setImage(with: urlOfSponsors[0])
            self.sponser2.sd_setImage(with: urlOfSponsors[1])
        } else {
            self.sponser1.sd_setImage(with: urlOfSponsors[0])
            self.sponser2.sd_setImage(with: urlOfSponsors[1])
            self.sponser3.sd_setImage(with: urlOfSponsors[2])
        }
//        self.isSubmitted.text = completitionDetails.
//        self.infoView1
        self.infoView1_img.image = #imageLiteral(resourceName: "ic_calender.png")
        self.infoView1_lbl.text = "Last date to participate: \(DateConverter.convertDateFormat("\((academicCompetition?.endTime ?? "").split(separator: "T").first ?? "")", inputFormat: "yyyy-MM-dd", outputFormat: "dd MMMM yyyy") ?? "")"
        self.sponser_lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.infoView2_img.image = #imageLiteral(resourceName: "rank.pdf")
        self.infoView2_lbl.text = academicCompetition?.categoryType
        self.sponser_lbl.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.infoView2_height.constant = 20
        self.infoView2.isHidden = false
        self.participants_lbl.text = "and \n\((academicCompetition?.participationCount ?? 3 - 3)) others"
        
        
        let details = storyboard?.instantiateViewController(withIdentifier: "CompetionMenuPageViewController") as! CompetionMenuPageViewController
//        let details = CompetionMenuPageViewController()
        details.title = "  Details    "
        details.type = .details
        details.academicCompetition = academicCompetition
        details.delegate = self
        details.competitionType = .detailedView_accademic
        controllerArray.append(details)
        
//        let leardBoard = storyboard?.instantiateViewController(withIdentifier: "CompetionMenuPageViewController") as! CompetionMenuPageViewController
////        let leardBoard = CompetionMenuPageViewController()
//        leardBoard.title = "  LeardBoard    "
//        leardBoard.type = .leadBoard
//        leardBoard.completitionDetails = completitionDetails
//        controllerArray.append(leardBoard)
        
//        let entries = storyboard?.instantiateViewController(withIdentifier: "CompetionMenuPageViewController") as! CompetionMenuPageViewController
//        entries.title = "  Entries    "
//        entries.type = .entries
//        entries.completitionDetails = completitionDetails
//        entries.delegate = self
//        controllerArray.append(entries)
//
//        let learn = storyboard?.instantiateViewController(withIdentifier: "CompetionMenuPageViewController") as! CompetionMenuPageViewController
//        learn.title = "  Learn    "
//        learn.type = .learn
//        learn.completitionDetails = completitionDetails
//        learn.delegate = self
//        controllerArray.append(learn)
        
        DispatchQueue.main .async {
            print(self.controllerArray.count)
            self.capsPageMenu?.delegate = self
            let parameters: [CAPSPageMenuOption] = CAPSPageMenuOption.defaultOptions(isHairlineNeeded: true, backgroundColor: .white)
            self.capsPageMenu = CAPSPageMenu(viewControllers: self.controllerArray, frame: self.pageView.bounds, pageMenuOptions: parameters)
            self.pageView.addSubview(self.capsPageMenu!.view)
        }
    }
    
    @IBAction func seeEntriesClicked(_ sender: Any) {
        let competitionId: String
        switch self.type {
        case .detailedView:
            competitionId = completitionDetails?.id ?? ""
        case .detailedView_extraCaricular:
            competitionId = completitionDetails?.id ?? ""
        case .detailedView_accademic:
            competitionId = academicCompetition?.id ?? ""
        }
        let viewModel = CompetitionEventsViewModel(competitionId: competitionId)
        let viewController = CompetitionEventsViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        let viewHandler = BaseViewHandler(presentingViewController: self)
        viewHandler.pushViewController(viewController: viewController)
    }
    
    @IBAction func participateClicked(_ sender: Any) {
        if self.isParticipated == false {
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let actionOk = UIAlertAction(title: "OK", style: .default) { _ in
                print("OK Pressed")
                var parameters: HTTPBody?
                switch self.type {
                case .detailedView:
                    parameters = [
                        "competitionId":self.completitionDetails?.id ?? "",
                        "userId":TaoHelper.userID ?? "",
                        "entryFee": 0,
                    ] as [String : Any]
                case .detailedView_extraCaricular:
                    break
                case .detailedView_accademic:
                    parameters = [
                        "competitionId":self.academicCompetition?.id ?? "",
                        "userId":TaoHelper.userID ?? "",
                        "entryFee": 0,
                    ] as [String : Any]
                }

                APIDataProvider.init().createParticipation(bodyParams: parameters) { _ in
                    if let completitionDetails = self.completitionDetails {
                        let viewModel = ChooseVideoViewModel(competionDetails: completitionDetails)
                        let viewController = ChooseVideoViewController(viewModel)
                        let viewHandler = BaseViewHandler(presentingViewController: self)
                        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
                        viewHandler.pushViewController(viewController: viewController)


                        //FIXME: Use pushViewModel when migrated to MVVM
                        //viewHandler.pushViewModel(viewModel: viewModel)
                    } else if let academicCompetition = self.academicCompetition {
                        let viewModel = QuizStartupPageViewModel(competitionDetails: academicCompetition)
                        let viewController = QuizStartupPageViewController(viewModel)
                        let viewHandler = BaseViewHandler(presentingViewController: self)
                        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
                        viewHandler.pushViewController(viewController: viewController)
                    }
                    
                    

                } onError: { error in
                    DispatchQueue.main.async {
                        self.view.makeToast("\(error?.debugDescription ?? "Something went wrong"), Please try again.")
                    }
                    print(error?.debugDescription ?? "participateClicked: Error debug desc nil")
                }
            }
            
            self.taoNavigationController.showAlert(title: "Are you sure you want to Proceed?",
                                                message: nil,
                                                actions: [actionCancel, actionOk],
                                                controller: self)
        }
    }
}

/// API calls
extension CompetitionDetailedViewController : CompetionMenuPageViewDelegate {
    func getTableViewHeight(value: CGFloat) {
        self.pageViewHeight.constant = value + 100
    }
}
