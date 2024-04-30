//
//  CustomHomeTableViewCell.swift
//  tao
//
//  Created by Betto Akkara on 20/02/22.
//

import UIKit

class CustomHomeTableViewCell: UITableViewCell {

    private var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        viewLayout.scrollDirection = .horizontal
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    var title_lbl: UILabel = {
        let title_lbl = UILabel(frame: .zero)
        title_lbl.textColor = UIColor.black
        title_lbl.font = UIFont(name: "Poppins-Medium", size: 16)
        title_lbl.text = ""
        return title_lbl
    }()


    var expand_view: UIView = {
        let expand_view = UIView(frame: .zero)
        return expand_view
    }()

    var expand_lbl: UILabel = {
        let expand_lbl = UILabel(frame: .zero)
        expand_lbl.textColor = #colorLiteral(red: 0.2157959044, green: 0.2783293426, blue: 0.8247789741, alpha: 1)
        expand_lbl.textAlignment = .right
        expand_lbl.font = UIFont(name: "Poppins-Medium", size: 12)
        expand_lbl.text = "View all"
        return expand_lbl
    }()

    var expand_img: UIImageView = {
        let expand_img = UIImageView(frame: .zero)
        expand_img.image = UIImage(named: "right-chevron")
        expand_img.backgroundColor = #colorLiteral(red: 0.2157959044, green: 0.2783293426, blue: 0.8247789741, alpha: 1)
        expand_img.layer.cornerRadius = 3
        expand_img.contentMode = .scaleAspectFit
        expand_img.largeContentImageInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        expand_img.tintColor = .white
        return expand_img
    }()

    var expand_btn: UIButton = {
        let expand_btn = UIButton(frame: .zero)
        return expand_btn
    }()

    var collection_Type : DashBoardViews!

    private var futureDate: Date?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.layoutIfNeeded()
    }

    private struct LayoutConstant {
        static let spacing: CGFloat = 0
        static func itemWidth(type : DashBoardViews) -> CGFloat{
            switch type {
            case .category:
                return (TaoHelper.constants().categoryView_width) + 30
            case .extraCurriculars:
                return (TaoHelper.constants().extraCarricularsView_width) + 30
            case .academicCompetition:
                return (TaoHelper.constants().extraCarricularsView_width) + 30
            case .dailyActivity:
                return (TaoHelper.constants().extraCarricularsView_width) + 30
                
            case .trending:
                return (TaoHelper.constants().trendingView_width) + 30
            default:
                break
            }
            return 0
        }
        static func itemHeight(type : DashBoardViews) -> CGFloat{
            switch type {
            case .category:
                return (TaoHelper.constants().categoryView_height)
            case .extraCurriculars,.academicCompetition,.dailyActivity:
                return (TaoHelper.constants().extraCarricularsView_height)
            case .event:
                return (TaoHelper.constants().eventView_height)
            case .trending:
                return (TaoHelper.constants().trendingView_height)
            default:
                break
            }
            return 0
        }

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Set any attributes of your UI components here.

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventCollectionViewCell")
        collectionView.register(UINib(nibName: "TrendingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TrendingCollectionViewCell")

        // Add the UI components
        contentView.backgroundColor = .white

        contentView.addSubview(expand_view)
        contentView.addSubview(title_lbl)
        expand_view.addSubview(expand_lbl)
        expand_view.addSubview(expand_img)
        expand_view.addSubview(expand_btn)
        contentView.addSubview(collectionView)

        expand_view.translatesAutoresizingMaskIntoConstraints = false
        title_lbl.translatesAutoresizingMaskIntoConstraints = false
        expand_lbl.translatesAutoresizingMaskIntoConstraints = false
        expand_img.translatesAutoresizingMaskIntoConstraints = false
        expand_btn.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        // Layout constraints for `expand_view`
        NSLayoutConstraint.activate([
            expand_view.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            expand_view.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -25),
            expand_view.heightAnchor.constraint(equalToConstant: 20),
            expand_view.leftAnchor.constraint(equalTo: title_lbl.safeAreaLayoutGuide.rightAnchor, constant: 16)
        ])

        // Layout constraints for `title_lbl`
        NSLayoutConstraint.activate([
            title_lbl.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30),
            title_lbl.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor,constant: 30),
            //title_lbl.rightAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.leftAnchor),
            title_lbl.heightAnchor.constraint(equalToConstant: 20)
        ])

        // Layout constraints for `expand_lbl`
        NSLayoutConstraint.activate([
            expand_lbl.topAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.topAnchor),
            expand_lbl.bottomAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.bottomAnchor),
            expand_lbl.rightAnchor.constraint(equalTo: expand_img.safeAreaLayoutGuide.leftAnchor, constant: -8),            //expand_lbl.widthAnchor.constraint(equalToConstant: 60)
        ])

        // Layout constraints for `expand_img`
        NSLayoutConstraint.activate([
            expand_img.topAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.topAnchor, constant: 2),
            expand_img.rightAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            expand_img.widthAnchor.constraint(equalToConstant: 16),
            expand_img.heightAnchor.constraint(equalToConstant: 16)
        ])

        // Layout constraints for `expand_btn`
        NSLayoutConstraint.activate([
            expand_btn.topAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.topAnchor),
            expand_btn.bottomAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.bottomAnchor),
            expand_btn.leftAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.leftAnchor),
            expand_btn.rightAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.rightAnchor)
        ])

        // Layout constraints for `collectionView`
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: title_lbl.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor)
        ])
        
        title_lbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        collectionView.reloadData()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

extension CustomHomeTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch self.collection_Type {
        case .category :
            return TaoHelper.competitionCategories?.count ?? 0
        case .extraCurriculars :
            return TaoHelper.homeDetails?.culturalCompetitions?.count ?? 0
        case .academicCompetition :
            return TaoHelper.homeDetails?.academicCompetitions?.count ?? 0
        case .dailyActivity:
            return TaoHelper.homeDetails?.activityList?.count ?? 0
        case .trending :
            return TaoHelper.homeDetails?.mediaEntryResponseList?.count ?? 0
        default:
            return 10
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch self.collection_Type {
        case .category :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.loadViews(cellIndex: indexPath.item, cellType: .category)
            cell.leading.constant = indexPath.item == 0 ? 30 : 10
            return cell
        case .extraCurriculars :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.loadViews(cellIndex: indexPath.item, cellType: .extraCurriculars)
            cell.leading.constant = indexPath.item == 0 ? 25 : 10
            return cell
        case .academicCompetition :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.loadViews(cellIndex: indexPath.item, cellType: .academicCompetition)
            cell.leading.constant = indexPath.item == 0 ? 25 : 10
            return cell
        case .dailyActivity :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            //FIXME: WorkAround, Need to fix it later
            expand_img.isHidden = true
            expand_img.removeFromSuperview()
            expand_lbl.text = ""
            expand_lbl.numberOfLines = 0
            expand_view.backgroundColor = .black
            expand_lbl.textColor = .white
            expand_lbl.font = UIFont(name: "Poppins-Medium", size: 10)
            expand_view.layer.cornerRadius = 6
            expand_view.layer.borderWidth = 2
            expand_lbl.textAlignment = .center

            expand_view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            title_lbl.setContentHuggingPriority(.defaultLow, for: .horizontal)

            NSLayoutConstraint.activate([
                expand_lbl.leftAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.leftAnchor,
                                                 constant: 8),
                expand_lbl.rightAnchor.constraint(equalTo: expand_view.safeAreaLayoutGuide.rightAnchor,
                                                  constant: -8)
            ])

            self.futureDate = DateConverter.convertDateFormat(TaoHelper.homeDetails?.activityList?[indexPath.row].endTime ?? "", inputFormat: "yyyy-MM-dd'T'HH:mm:ss")
            cell.loadViews(cellIndex: indexPath.item, cellType: .dailyActivity)
            cell.leading.constant = indexPath.item == 0 ? 25 : 10
            self.runCountdown()
            
            return cell
        case .trending :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.loadViews(cellIndex: indexPath.item, cellType: .trending)
            cell.leading.constant = indexPath.item == 0 ? 30 : 10
            return cell
        default:
            return UICollectionViewCell()
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Logger.w(indexPath.item)
        
        switch self.collection_Type {
        case .category :
            
            break
        case .extraCurriculars :
            DispatchQueue.main.async {
                guard let ob_vc = self.parentViewController?.storyboard?.instantiateViewController(withIdentifier: "CompetitionDetailedViewController") as? CompetitionDetailedViewController else {return}
                ob_vc.completitionDetails = TaoHelper.homeDetails?.culturalCompetitions?[indexPath.item]
                self.parentViewController?.navigationController?.pushViewController(ob_vc, animated: true)
            }
//            let viewModel = CompetitionDetailViewModel()
//            let viewHandler = BaseViewHandler(presentingViewController: self.parentViewController!)
//            let viewController = CompetitionDetailViewController(viewModel)
//            viewModel.viewHandler = viewHandler
//            viewHandler.pushViewController(viewController: viewController)
        case .academicCompetition :
            DispatchQueue.main.async {
                guard let ob_vc = self.parentViewController?.storyboard?.instantiateViewController(withIdentifier: "CompetitionDetailedViewController") as? CompetitionDetailedViewController else {return}
                ob_vc.type = .detailedView_accademic
                ob_vc.academicCompetition = TaoHelper.homeDetails?.academicCompetitions?[indexPath.item]
                self.parentViewController?.navigationController?.pushViewController(ob_vc, animated: true)
            }
//            DispatchQueue.main.async {
//                let viewModel = QuizStartupPageViewModel(competitionDetails: (TaoHelper.homeDetails?.academicCompetitions?[indexPath.item])!)
//                let viewHandler = BaseViewHandler(presentingViewController: self.parentViewController!)
//                let viewController = QuizStartupPageViewController(viewModel)
//                viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
//                viewHandler.pushViewController(viewController: viewController)
//            }
        case .dailyActivity :
            DispatchQueue.main.async {
                guard let ob_vc = self.parentViewController?.storyboard?.instantiateViewController(withIdentifier: "CompetitionDetailedViewController") as? CompetitionDetailedViewController else {return}
                if let activityList = TaoHelper.homeDetails?.activityList?[indexPath.item] {
                    if activityList.categoryType == "ACADEMIC" {
                        ob_vc.type = .detailedView_accademic
                        ob_vc.academicCompetition = AcademicCompetitions(rewardType:activityList.rewardType,
                                                                         entryFee: activityList.entryFee,
                                                                         status: activityList.status,
                                                                         participationCount: activityList.participationCount,
                                                                         maxAge: activityList.maxAge,
                                                                         rewardRuleId: activityList.rewardRuleId,
                                                                         createdTimeStamp: activityList.createdTimeStamp,
                                                                         background: activityList.background,
                                                                         endTime: activityList.endTime,
                                                                         activity: activityList.activity,
                                                                         name: activityList.name,
                                                                         priority: activityList.priority,
                                                                         prize: activityList.prize,
                                                                         imageUrl: activityList.imageUrl,
                                                                         id: activityList.id,
                                                                         questionCriteria: nil,
                                                                         paid: activityList.paid,
                                                                         participationCloseTime: activityList.endTime,
                                                                         subCategory: activityList.subCategory,
                                                                         minParticipants: activityList.minParticipants,
                                                                         contentMaxDuration: activityList.contentMaxDuration,
                                                                         minAge: activityList.minAge,
                                                                         certificateGenerated: activityList.certificateGenerated,
                                                                         maxParticipants: activityList.maxParticipants,
                                                                         standards: activityList.standards,
                                                                         sample: activityList.sample,
                                                                         mediaType: activityList.mediaType,
                                                                         startTime: activityList.startTime,
                                                                         guide: activityList.guide,
                                                                         evaluationDetails: activityList.evaluationDetails,
                                                                         categoryType: activityList.categoryType,
                                                                         description: activityList.description, categoryImage: activityList.categoryImage)
                    } else {
                        ob_vc.completitionDetails = activityList
                    }
                }
                
                self.parentViewController?.navigationController?.pushViewController(ob_vc, animated: true)
            }
        case .trending :
           
            break
        default:
       
            break
        }

        
    }

}

extension CustomHomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let width = itemWidth(for: contentView.frame.width, spacing: 3)
        return  indexPath.item == 0 ? (CGSize(width: LayoutConstant.itemWidth(type: self.collection_Type), height: LayoutConstant.itemHeight(type: self.collection_Type))) : (CGSize(width: LayoutConstant.itemWidth(type: self.collection_Type) - 20, height: LayoutConstant.itemHeight(type: self.collection_Type)))
    }

//    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
//        let itemsInRow: CGFloat = 1
//
//        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
//        let finalWidth = (width - totalSpacing) / itemsInRow
//
//        return finalWidth - 5.0
//    }
}

extension CustomHomeTableViewCell {
    var countdown: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: self.futureDate ?? Date())
    }
    
    @objc func updateTime() {
        let countdown = self.countdown
        let hours = countdown.hour!
        let minutes = countdown.minute!
        let seconds = countdown.second!
        
        let timerStringFormatted = String(format: "Ends in %02d:%02d:%02d", hours, minutes, seconds)
        //FIXME: Hardcoded Value for length
        let lengthOfTimerString = 8
        let timerAttributedString = NSMutableAttributedString(string: timerStringFormatted)
        let attributes = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 10)]
        timerAttributedString.addAttributes(attributes as [NSAttributedString.Key : Any],
                                  range: NSRange(location: 8, length: lengthOfTimerString))
        self.expand_lbl.attributedText = timerAttributedString
    }

    func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
}
