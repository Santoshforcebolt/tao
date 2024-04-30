//
//  InstructionView.swift
//  tao
//
//  Created by Mayank Khursija on 29/05/22.
//

import Foundation

//Image
//Text

class InstructionView: UIView {
    
    struct RenderData {
        var imageHeight: CGFloat = 68.0
        var imageWidth: CGFloat = 68.0
        var topMargin: CGFloat = 0.0
        var distanceBetweenImageAndLabel: CGFloat = 8.0
        var textColor: UIColor = .black
        var font: UIFont = UIFont(name: "Poppins", size: 12)!
        var textAlignment: NSTextAlignment = .center
    }
    
    private var endDate: Date?
    private var renderData: RenderData
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    } ()
    
    init(renderData: RenderData = RenderData()) {
        self.renderData = renderData
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self.imageView)
        self.addSubview(self.textLabel)
        
        self.textLabel.textColor = self.renderData.textColor
        self.textLabel.font = self.renderData.font
        self.textLabel.textAlignment = self.renderData.textAlignment
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: self.renderData.topMargin).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: self.renderData.imageWidth).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.renderData.imageHeight).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.textLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor,
                                            constant: self.renderData.distanceBetweenImageAndLabel).isActive = true
        self.textLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.textLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func setVM(viewModel: InstructionViewModel) {
        switch viewModel.image {
        case .withURL(let url):
            self.imageView.sd_setImage(with: url)
        case .withImage(let image):
            self.imageView.image = image
        }
        
        switch viewModel.text {
        case .plain(let text):
            self.textLabel.text = text
        case .clock(let endDate):
            self.endDate = endDate
            self.runCountdown()
        }
    }
}

//MARK: Timer Implementation
extension InstructionView {
    private var countdown: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: self.endDate ?? Date())
    }
    
    @objc private func updateTime() {
        let countdown = self.countdown
        let hours = countdown.hour!
        let minutes = countdown.minute!
        
        self.textLabel.text = ""
        
        if hours != 0 {
            self.textLabel.text?.append(contentsOf: "\(hours) hours ")
        }
        
        if minutes != 0 {
            self.textLabel.text?.append(contentsOf: "\(minutes) minutes ")
        }
        
    }

    private func runCountdown() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
}
