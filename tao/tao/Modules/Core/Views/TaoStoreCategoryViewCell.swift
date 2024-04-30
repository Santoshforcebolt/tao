//
//  TaoStoreCategoryViewCell.swift
//  tao
//
//  Created by Mayank Khursija on 03/06/22.
//

import Foundation

class TaoStoreCategoryViewCell: UICollectionViewCell {
    
    var instructionView: InstructionView = {
        let renderData = InstructionView.RenderData(imageHeight: 48,
                                                    imageWidth: 48,
                                                    topMargin: 8,
                                                    distanceBetweenImageAndLabel: 8,
                                                    textColor: .white,
                                                    font: UIFont(name: "Poppins-Medium",
                                                                 size: 12)!)
        let instructionView = InstructionView(renderData: renderData)
        instructionView.translatesAutoresizingMaskIntoConstraints = false
        return instructionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(self.instructionView)
        self.instructionView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.instructionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        self.instructionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        self.instructionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupCell(viewModel: InstructionViewModel) {
        self.instructionView.setVM(viewModel: viewModel)
    }
}
