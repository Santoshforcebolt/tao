//
//  TransactionHistoryViewController.swift
//  tao
//
//  Created by Mayank Khursija on 28/06/22.
//

import Foundation

class TransactionHistoryViewController: BaseViewController<TransactionHistoryViewModel> {
    
    var transactionCollectionView: UICollectionView
    var navigationBar: UINavigationBar?
    
    override init(_ viewModel: TransactionHistoryViewModel) {
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
        self.transactionCollectionView.register(TransactionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.transactionCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
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
        
        let navigationItem = UINavigationItem(title: "Transaction History")
        
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

extension TransactionHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.transactions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TransactionViewCell ?? TransactionViewCell()
        
        if let transaction = self.viewModel.transactions?[indexPath.row] {
            if self.viewModel.isTransactionCoins(for: indexPath.row) {
                switch self.viewModel.getTransactionType(for: indexPath.row) {
                case .credit:
                    cell.updateNudgeType(type: .coin("+\(transaction.amount ?? 0)"))
                case .debit:
                    cell.updateNudgeType(type: .coin("-\(transaction.amount ?? 0)"))
                }
                
            } else {
                switch self.viewModel.getTransactionType(for: indexPath.row) {
                case .credit:
                    cell.updateNudgeType(type: .money("+\(transaction.amount ?? 0)"))
                case .debit:
                    cell.updateNudgeType(type: .money("-\(transaction.amount ?? 0)"))
                }
            }
            let formattedDate: String?
            if let date = transaction.createdOn {
                let date = DateConverter.convertDateFormat(date, inputFormat: "yyyy-MM-dd'T'HH:mm:ss.SS")
                formattedDate = DateConverter.convertDateFormat(date, outputFormat: "MMM dd, YYYY")
            } else {
                formattedDate = nil
            }
            let imageData = ImagesData.dictionary[transaction.category ?? ""] ?? ImagesData.dictionary["DEFAULT"]
            if let urlString = imageData?.imageUrl,
               let url = URL(string: urlString) {
                cell.setupData(title: imageData?.name ?? "",
                                image: .withURL(url),
                                info: transaction.description,
                                subInfo: formattedDate)
            } else {
                cell.setupData(title: imageData?.name ?? "",
                                image: .withImage(UIImage(systemName: "clock")!),
                                info: transaction.description,
                                subInfo: formattedDate)
            }

            cell.cornerRadius = 16
            cell.backgroundColor = .grayBackground
            switch self.viewModel.getTransactionType(for: indexPath.row) {
            case .credit:
                cell.updateTextColor(color: .systemGreen)
            case .debit:
                cell.updateTextColor(color: .systemRed)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.transactionCollectionView {
            return CGSize(width: self.transactionCollectionView.frame.size.width - 32, height: 120)
        }
        return .zero
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if collectionView == self.addressCollectionView, kind == UICollectionView.elementKindSectionHeader {
//            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
//                                                                             withReuseIdentifier: "headerCell",
//                                                                             for: indexPath)
//            footerView.addSubview(self.addNewAddress)
//            self.addNewAddress.topAnchor.constraint(equalTo: footerView.topAnchor,
//                                                  constant: 8).isActive = true
//            self.addNewAddress.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 8).isActive = true
//            self.addNewAddress.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -8).isActive = true
//            self.addNewAddress.heightAnchor.constraint(equalToConstant: 44).isActive = true
//            self.addNewAddress.addTarget(self, action: #selector(addNewAddressTapped), for: .touchUpInside)
//            return footerView
//        }
//        return UICollectionReusableView()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        if section == 0 {
//            return CGSize(width: collectionView.frame.size.width, height: 50)
//        }
//        return .zero
//    }
}
