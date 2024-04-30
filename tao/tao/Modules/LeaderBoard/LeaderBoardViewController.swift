//
//  LeaderBoardViewController.swift
//  tao
//
//  Created by Mayank Khursija on 01/07/22.
//

import Foundation
import UIKit

class LeaderBoardViewController: BaseViewController<LeaderBoardViewModel> {
    var transactionCollectionView: UICollectionView
    var navigationBar: UINavigationBar?
    
    var switcherView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var subjectPickerView: UIPickerView = {
        let view = UIPickerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var subjectTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 20)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.textAlignment = .left
        return textField
    }()
    
    var monthPickerView: UIPickerView = {
        let view = UIPickerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var monthTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 20)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        textField.textAlignment = .left
        return textField
    }()
    
    
    var thisMonthButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Poppins", size: 12)
        button.backgroundColor = UIColor.init(hex: "#7284F5")
        button.cornerRadius = 15
        
        return button
    }()
    
    var allTimeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Poppins", size: 12)
        button.backgroundColor = .blueBackground
        button.cornerRadius = 15
        return button
    }()
    
    var bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .newDarkBlueBackground
        return view
    }()
    
    var bottomLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    override init(_ viewModel: LeaderBoardViewModel) {
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
        
        self.thisMonthButton.addTarget(self, action: #selector(thisMonthTapped), for: .touchUpInside)
        self.allTimeButton.addTarget(self, action: #selector(allTimeButtonTapped), for: .touchUpInside)
        
        self.thisMonthButton.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        self.allTimeButton.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        self.thisMonthButton.setTitle("This Month", for: .normal)
        self.allTimeButton.setTitle("All Time", for: .normal)
        self.allTimeButton.setTitleColor(.white, for: .normal)
        
        self.switcherView.backgroundColor = .blueBackground
        self.switcherView.cornerRadius = 20
        
        self.subjectPickerView.dataSource = self
        self.subjectPickerView.delegate = self
        
        self.monthPickerView.dataSource = self
        self.monthPickerView.delegate = self
        
        self.subjectTextField.setRightIcon(UIImage(named: "dropdown")!, size: 8)
        self.subjectTextField.rightView?.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                                     action: #selector(textFieldRightViewTapped)))
        
        self.monthTextField.setRightIcon(UIImage(named: "dropdown")!, size: 8)
        self.monthTextField.rightView?.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                                   action: #selector(monthTextFieldRightViewTapped)))
    }
    
    @objc func textFieldRightViewTapped() {
        self.subjectTextField.becomeFirstResponder()
    }
    
    @objc func monthTextFieldRightViewTapped() {
        self.monthTextField.becomeFirstResponder()
    }
    
    @objc func thisMonthTapped() {
        self.viewModel.time = .month
        
        self.thisMonthButton.backgroundColor = UIColor.init(hex: "#7284F5")
        self.thisMonthButton.setTitleColor(.white, for: .normal)
        self.allTimeButton.backgroundColor = .blueBackground
        self.allTimeButton.setTitleColor(.white, for: .normal)
        
        self.transactionCollectionView.reloadData()
        
        self.subjectPickerView.selectRow(self.viewModel.selectedCategoryIndex, inComponent: 0, animated: false)
        self.subjectTextField.text = self.viewModel.selectedCategory
    }
    
    @objc func allTimeButtonTapped() {
        self.viewModel.time = .all
        
        self.allTimeButton.backgroundColor = UIColor.init(hex: "#7284F5")
        self.allTimeButton.setTitleColor(.white, for: .normal)
        self.thisMonthButton.backgroundColor = .blueBackground
        self.thisMonthButton.setTitleColor(.white, for: .normal)
        
        self.transactionCollectionView.reloadData()
        
        self.subjectPickerView.selectRow(self.viewModel.selectedAllTimeCategoryIndex, inComponent: 0, animated: false)
        self.subjectTextField.text = self.viewModel.selectedAllTimeCategory
        self.monthTextField.text = self.viewModel.selectedMonth //For showing Selected Month as place holder first time
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
        
        let navigationItem = UINavigationItem(title: "Leader Board")
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func reloadView() {
        super.reloadView()
        
        if self.viewModel.userBoard != nil {
            self.transactionCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 52).isActive = true
            
            self.view.addSubview(self.bottomView)
            
            self.bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            self.bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            self.bottomView.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            self.bottomView.addSubview(self.bottomLabel)
            
            self.bottomLabel.topAnchor.constraint(equalTo: self.bottomView.topAnchor).isActive = true
            self.bottomLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.bottomLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            
            self.bottomLabel.text = "Your rank is \(self.viewModel.userBoard?.rank ?? 0)"
        }
        
        self.transactionCollectionView.reloadData()
        switch self.viewModel.time {
        case .month:
            self.subjectTextField.text = self.viewModel.selectedCategory
        case .all:
            self.subjectTextField.text = self.viewModel.selectedAllTimeCategory
            self.monthTextField.text = self.viewModel.selectedMonth
        }
    }
    
    @objc func doneClick() {
        self.subjectTextField.resignFirstResponder()
        switch self.viewModel.time {
        case .month:
            self.viewModel.loadMonthlyData(for: self.subjectTextField.text ?? "")
        case .all:
            break
        }
        
    }
    
    @objc func doneClickForAll() {
        self.monthTextField.resignFirstResponder()
        self.viewModel.loadYearlyData(for: self.subjectTextField.text ?? "")
    }
    
    @objc func itemSelected() {
        
    }
}

extension LeaderBoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.viewModel.time {
        case .month:
            return self.viewModel.leaderBoards?.count ?? 0
        case .all:
            return self.viewModel.pastLeaderBoards?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TransactionViewCell ?? TransactionViewCell()
        
        let leaderBoard: LeaderBoard?
        switch self.viewModel.time {
        case .month:
            leaderBoard = self.viewModel.leaderBoards?[indexPath.row]
        case .all:
            leaderBoard = self.viewModel.pastLeaderBoards?[indexPath.row]
        }
        
        if let leaderBoard = leaderBoard {
            switch self.viewModel.rewardType {
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
                               image: .withImage(UIImage(named: "defaultLeaderboardPicture")!),
                               info: leaderBoard.school?.schoolName ?? "",
                               subInfo: nil)
            }
            cell.showCounter(text: "\(leaderBoard.rank ?? 0)")
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.transactionCollectionView {
            return CGSize(width: self.transactionCollectionView.frame.size.width - 32, height: 70)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == self.transactionCollectionView, kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "headerCell",
                                                                             for: indexPath)
            headerView.addSubview(self.switcherView)
            self.switcherView.topAnchor.constraint(equalTo: headerView.topAnchor,
                                                  constant: 8).isActive = true
            self.switcherView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
            self.switcherView.heightAnchor.constraint(equalToConstant: 48).isActive = true
            self.switcherView.widthAnchor.constraint(equalToConstant: 252).isActive = true
            
            self.switcherView.addSubview(self.thisMonthButton)
            self.switcherView.addSubview(self.allTimeButton)
            
            self.thisMonthButton.leftAnchor.constraint(equalTo: switcherView.leftAnchor,
                                                        constant: 8).isActive = true
            self.thisMonthButton.topAnchor.constraint(equalTo: switcherView.topAnchor,
                                                       constant: 8).isActive = true
            self.thisMonthButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
            self.thisMonthButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            
            self.allTimeButton.leftAnchor.constraint(equalTo: self.thisMonthButton.rightAnchor, constant: 16).isActive = true
            self.allTimeButton.topAnchor.constraint(equalTo: switcherView.topAnchor,
                                                       constant: 8).isActive = true
            self.allTimeButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
            self.allTimeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            
            headerView.addSubview(self.subjectTextField)
  
            self.subjectTextField.topAnchor.constraint(equalTo: self.switcherView.bottomAnchor,
                                                  constant: 16).isActive = true
            self.subjectTextField.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16).isActive = true
            self.subjectTextField.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16).isActive = true
            self.subjectTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true

            self.subjectTextField.inputView = self.subjectPickerView
            
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
            toolBar.sizeToFit()
            
            // Adding Button ToolBar
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolBar.setItems([spaceButton, doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            self.subjectTextField.inputAccessoryView = toolBar
            
            switch self.viewModel.time {
            case .month:
                self.monthTextField.removeFromSuperview()
            case .all:
                headerView.addSubview(self.monthTextField)
      
                self.monthTextField.topAnchor.constraint(equalTo: self.subjectTextField.bottomAnchor,
                                                      constant: 16).isActive = true
                self.monthTextField.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16).isActive = true
                self.monthTextField.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16).isActive = true
                self.monthTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true

                self.monthTextField.inputView = self.monthPickerView
                
                let toolBar = UIToolbar()
                toolBar.barStyle = .default
                toolBar.isTranslucent = true
                toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
                toolBar.sizeToFit()
                
                // Adding Button ToolBar
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClickForAll))
                let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                toolBar.setItems([spaceButton, doneButton], animated: false)
                toolBar.isUserInteractionEnabled = true
                self.monthTextField.inputAccessoryView = toolBar
            }
            
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            switch self.viewModel.time {
            case .month:
                return CGSize(width: collectionView.frame.size.width, height: 124)
            case .all:
                return CGSize(width: collectionView.frame.size.width, height: 192)
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.itemTapped(at: indexPath.row)
    }
}

extension LeaderBoardViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.subjectPickerView {
            return self.viewModel.subCategories?.count ?? 0
        } else if pickerView == self.monthPickerView {
            return self.viewModel.dates.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.subjectPickerView {
            return self.viewModel.subCategories?[row]
        } else if pickerView == self.monthPickerView {
            return self.viewModel.dates[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.subjectPickerView {
            self.subjectTextField.text = self.viewModel.subCategories?[row]
            switch self.viewModel.time {
            case .month:
                self.viewModel.selectedCategoryIndex = row
                self.viewModel.selectedCategory = self.viewModel.subCategories?[row]
            case .all:
                self.viewModel.selectedAllTimeCategoryIndex = row
                self.viewModel.selectedAllTimeCategory = self.viewModel.subCategories?[row]
            }
        } else if pickerView == self.monthPickerView {
            self.monthTextField.text = self.viewModel.dates[row]
            self.viewModel.selectedMonth = self.viewModel.dates[row]
        }
    }
}
