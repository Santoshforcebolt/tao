//
//  AcademicCompetitionsCollectionViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 22/08/22.
//

import Foundation

class AcademicCompetitionsCollectionViewCell: UICollectionViewCell {
    var competitionsCollectionView: UICollectionView
    
    var vm: AcademicsCompetitionViewModel?
    
    override init(frame: CGRect) {
        let categoryCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        categoryCollectionViewLayout.scrollDirection = .vertical
        
        self.competitionsCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: categoryCollectionViewLayout)
        self.competitionsCollectionView.bounces = false
        self.competitionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 14.0, *) {
            var config = UICollectionLayoutListConfiguration(appearance:
                    .plain)
            config.showsSeparators = true
            self.competitionsCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
        } else {
            // Fallback on earlier versions
        }
        
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.contentView.addSubview(self.competitionsCollectionView)
        
        self.competitionsCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.competitionsCollectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: 16).isActive = true
        self.competitionsCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -16).isActive = true
        self.competitionsCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        
        self.competitionsCollectionView.delegate = self
        self.competitionsCollectionView.dataSource = self
        self.competitionsCollectionView.showsHorizontalScrollIndicator = false
        self.competitionsCollectionView.showsVerticalScrollIndicator = true
        self.competitionsCollectionView.register(UINib(nibName: "CompetitionCollectionViewCellNew", bundle: nil), forCellWithReuseIdentifier: "CompetitionCollectionViewCellNew")
    }
    
    func setupData(vm: AcademicsCompetitionViewModel) {
        self.vm = vm
        self.competitionsCollectionView.reloadData()
    }
}

extension AcademicCompetitionsCollectionViewCell: UICollectionViewDelegate,
                                              UICollectionViewDataSource,
                                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm?.competitions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompetitionCollectionViewCellNew", for: indexPath) as? CompetitionCollectionViewCellNew ?? CompetitionCollectionViewCellNew()
        
        if let competition = self.self.vm?.competitions[indexPath.row] {
            print("competition Data",competition)
            if let compUrl = URL(string: competition.imageUrl ?? "") {
                let endDate = DateConverter.convertDateFormat(competition.endTime ?? "",
                                                           inputFormat: "yyyy-MM-dd'T'HH:mm:ss")
                let days = DateManager.shared.getDaysBetween(date1: Date(), date2: endDate)

                if competition.rewardType ?? "COIN" == "COIN" {
                    cell.setupData(compImage: .withURL(compUrl),
                                   name: competition.name ?? "",
                                   nudgeType: .coin("\(competition.prize ?? 0)"),
                                   daysRemaining: days > 0 ? TextType.plain("\(days)"): TextType.clock(endDate))
                } else {
                    cell.setupData(compImage: .withURL(compUrl),
                                   name: competition.name ?? "",
                                   nudgeType: .money("\(competition.prize ?? 0)"),
                                   daysRemaining: days > 0 ? TextType.plain("\(days)"): TextType.clock(endDate))
                }
            }
//            cell.backgroundColor = .lightBlueBackground
            cell.backgroundColor = .black
        }
        cell.secondaryLabel.text = "sm2"
        cell.timeRemainingLabel.text = "sm3"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 225, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vm?.itemSelected(index: indexPath.row)
    }
}
