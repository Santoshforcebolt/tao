//
//  DashboardHeaderViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 23/08/22.
//

import Foundation

class DashboardHeaderViewCell: UICollectionViewCell {
    var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Bold", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    var nudgeView: NudgeView = {
        let renderData = NudgeView.RenderData(font: UIFont(name: "Poppins", size: 14),
                                              textColor: .systemBlue,
                                              image: UIImage(named: "right-chevron"))
        return NudgeView(renderData: renderData)
    }()
    
    var vm: DashboardHeaderViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        for view in self.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let mainHorizontalStackView = UIStackView(frame: .zero)
        mainHorizontalStackView.axis = .horizontal
        mainHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainHorizontalStackView.addArrangedSubview(self.headerLabel)
        mainHorizontalStackView.addArrangedSubview(self.nudgeView)
        
        self.nudgeView.setContentHuggingPriority(.required, for: .horizontal)
        self.nudgeView.widthAnchor.constraint(equalTo: mainHorizontalStackView.widthAnchor, multiplier: 0.3).isActive = true
        self.nudgeView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(viewAllTapped)))
        self.headerLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        self.contentView.addSubview(mainHorizontalStackView)
        
        mainHorizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        mainHorizontalStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        mainHorizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        mainHorizontalStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
    }
    
    func setupVm(vm: DashboardHeaderViewModel) {
        self.vm = vm
        self.headerLabel.text = self.vm?.header
        self.nudgeView.updateType(type: .coin("View All"))
    }

    @objc func viewAllTapped() {
        self.vm?.viewAllTapped()
    }
}
