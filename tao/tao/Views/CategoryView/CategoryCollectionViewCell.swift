//
//  CategoryCollectionViewCell.swift
//  tao
//
//  Created by Betto Akkara on 20/02/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!

    @IBOutlet weak var leading: NSLayoutConstraint!

    var cellType : DashBoardViews? {
        didSet{

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func loadViews(cellIndex : Int, cellType : DashBoardViews){
    
        switch cellType{
        case .banner:
            
            break
        case .category:
            self.height.constant = TaoHelper.constants().categoryView_height
            self.width.constant = TaoHelper.constants().categoryView_width
            let categoryView = CategoryView(frame: CGRect(x: 0, y: 0, width: TaoHelper.constants().categoryView_width, height: TaoHelper.constants().categoryView_height))
            self.containerView.addSubview(categoryView)
            categoryView.fillData(
                index: cellIndex,
                image_url: TaoHelper.competitionCategories?[cellIndex].imageUrl,
                title: TaoHelper.competitionCategories?[cellIndex].description,
                bg: TaoHelper.competitionCategories?[cellIndex].backgroundColor
            )
            self.containerView.backgroundColor = UIColor(hex: "#FFFFFF")
            break
        case .extraCurriculars:
            self.height.constant = TaoHelper.constants().extraCarricularsView_height
            self.width.constant = TaoHelper.constants().extraCarricularsView_width
            let extraCurriculars = ExtraCurriculars(frame: CGRect(x: 0, y: 0, width: TaoHelper.constants().extraCarricularsView_width, height: TaoHelper.constants().extraCarricularsView_height - 80))
            self.containerView.addSubview(extraCurriculars)
            extraCurriculars.loadView(
                ispaid: TaoHelper.homeDetails?.culturalCompetitions?[cellIndex].paid == true ? "Premium" : "Free",
                days: DateConverter.getDaysFromNow(from: DateConverter.convertDateFormat(TaoHelper.homeDetails?.culturalCompetitions?[cellIndex].endTime ?? "", inputFormat: "yyyy-MM-dd'T'HH:mm:ss")),
                img: TaoHelper.homeDetails?.culturalCompetitions?[cellIndex].imageUrl ?? "",
                reward: "win \(TaoHelper.homeDetails?.culturalCompetitions?[cellIndex].prize ?? 0)",
                rewardType: TaoHelper.homeDetails?.culturalCompetitions?[cellIndex].rewardType ?? "COIN",
                bg: TaoHelper.homeDetails?.culturalCompetitions?[cellIndex].background ?? "",
                description: TaoHelper.homeDetails?.culturalCompetitions?[cellIndex].name ?? ""
            )
            self.containerView.backgroundColor = UIColor(hex: "#FFFFFF")
            
            break
        case .dailyActivity:
//            let extraCurriculars = DailyActivity(frame: CGRect(x: 0, y: 0, width: TaoHelper.constants().extraCarricularsView_width, height: TaoHelper.constants().extraCarricularsView_height))
//            self.containerView.addSubview(extraCurriculars)
//            extraCurriculars.loadView(
//                subject: TaoHelper.homeDetails?.activityList?[cellIndex].description ?? "",
//                reward: "win \(TaoHelper.homeDetails?.activityList?[cellIndex].prize ?? 0)",
//                rewardType: TaoHelper.homeDetails?.activityList?[cellIndex].rewardType ?? "",
//                isPaid: TaoHelper.homeDetails?.activityList?[cellIndex].paid == true ? "Premium" : "Free",
//                bgImg: TaoHelper.homeDetails?.activityList?[cellIndex].imageUrl ?? "",
//                bgColor: TaoHelper.homeDetails?.activityList?[cellIndex].background ?? "")
            self.height.constant = TaoHelper.constants().extraCarricularsView_height
            self.width.constant = TaoHelper.constants().extraCarricularsView_width
            let extraCurriculars = ExtraCurriculars(frame: CGRect(x: 0, y: 30, width: TaoHelper.constants().extraCarricularsView_width, height: TaoHelper.constants().extraCarricularsView_height-80))
            self.containerView.addSubview(extraCurriculars)
            extraCurriculars.loadView(
                ispaid: TaoHelper.homeDetails?.activityList?[cellIndex].paid == true ? "Premium" : "Free",
                days: DateConverter.getDaysFromNow(from: DateConverter.convertDateFormat(TaoHelper.homeDetails?.activityList?[cellIndex].endTime ?? "", inputFormat: "yyyy-MM-dd'T'HH:mm:ss")),
                img: TaoHelper.homeDetails?.activityList?[cellIndex].imageUrl ?? "",
                reward: "win \(TaoHelper.homeDetails?.activityList?[cellIndex].prize ?? 0)",
                rewardType: TaoHelper.homeDetails?.activityList?[cellIndex].rewardType ?? "COIN",
                bg: TaoHelper.homeDetails?.activityList?[cellIndex].background ?? "",
                description: TaoHelper.homeDetails?.activityList?[cellIndex].name ?? ""
            )
            self.containerView.backgroundColor = UIColor(hex: "#FFFFFF")
            
            break
            
        case .academicCompetition:
            self.height.constant = TaoHelper.constants().extraCarricularsView_height
            self.width.constant = TaoHelper.constants().extraCarricularsView_width
            let extraCurriculars = ExtraCurriculars(frame: CGRect(x: 0, y: 0, width: TaoHelper.constants().extraCarricularsView_width, height: TaoHelper.constants().extraCarricularsView_height - 80))
            self.containerView.addSubview(extraCurriculars)
            extraCurriculars.loadView(
                ispaid: (TaoHelper.homeDetails?.academicCompetitions?[cellIndex].paid == true ? "Premium" : "Free"),
                days: DateConverter.getDaysFromNow(from: DateConverter.convertDateFormat(TaoHelper.homeDetails?.academicCompetitions?[cellIndex].endTime ?? "", inputFormat: "yyyy-MM-dd'T'HH:mm:ss")),
                img: TaoHelper.homeDetails?.academicCompetitions?[cellIndex].imageUrl ?? "",
                reward: "win \(TaoHelper.homeDetails?.academicCompetitions?[cellIndex].prize ?? 0)",
                rewardType: TaoHelper.homeDetails?.academicCompetitions?[cellIndex].rewardType ?? "COIN",
                bg: TaoHelper.homeDetails?.academicCompetitions?[cellIndex].background ?? "",
                description: TaoHelper.homeDetails?.academicCompetitions?[cellIndex].name ?? ""
            )
            
            self.containerView.backgroundColor = UIColor(hex: "#FFFFFF")
            
            break
        
        case .trending:
            let extraCurriculars = MediaView(frame: CGRect(x: 0, y: 0, width: TaoHelper.constants().trendingView_width, height: TaoHelper.constants().trendingView_height))
            self.containerView.addSubview(extraCurriculars)
            extraCurriculars.loadView(
                img: TaoHelper.homeDetails?.mediaEntryResponseList?[cellIndex].thumbnailURL ?? "",
                count: "\(TaoHelper.homeDetails?.mediaEntryResponseList?[cellIndex].views ?? 0)"
            )
            self.containerView.backgroundColor = UIColor(hex: "#FFFFFF")
            break
            
        default:
            break

        }
        
       
    }
    
    
}
