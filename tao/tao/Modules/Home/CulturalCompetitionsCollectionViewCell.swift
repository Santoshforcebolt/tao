//
//  CulturalCompetitionsCollectionViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 23/08/22.
//

import Foundation

class CulturalCompetitionsCollectionViewCell: UICollectionViewCell {
    var competitionsCollectionView: UICollectionView
    
    var vm: CulturalCompetitionsViewModel?
    
    override init(frame: CGRect) {
        let categoryCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        categoryCollectionViewLayout.scrollDirection = .horizontal
        self.competitionsCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: categoryCollectionViewLayout)
        self.competitionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.competitionsCollectionView)
        
        self.competitionsCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.competitionsCollectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.competitionsCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.competitionsCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        
        self.competitionsCollectionView.delegate = self
        self.competitionsCollectionView.dataSource = self
        self.competitionsCollectionView.showsHorizontalScrollIndicator = false
        self.competitionsCollectionView.register(CompetitionCollectionViewCell.self,
                                            forCellWithReuseIdentifier: "competitionCell")
    }
    
    func setupData(vm: CulturalCompetitionsViewModel) {
        self.vm = vm
        self.competitionsCollectionView.reloadData()
    }
}

extension CulturalCompetitionsCollectionViewCell: UICollectionViewDelegate,
                                              UICollectionViewDataSource,
                                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm?.competitions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "competitionCell", for: indexPath) as? CompetitionCollectionViewCell ?? CompetitionCollectionViewCell()
        if let competition = self.vm?.competitions[indexPath.row] {
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
            }
            cell.cornerRadius = 16
//            cell.backgroundColor = UIColor(hex: competition.background ?? "#000000")
            cell.backgroundColor = .lightBlueBackground
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 225, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vm?.itemSelected(index: indexPath.row)
    }
}
