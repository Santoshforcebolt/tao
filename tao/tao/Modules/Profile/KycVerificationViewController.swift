//
//  KycVerificationViewController.swift
//  tao
//
//  Created by Mayank Khursija on 24/06/22.
//

import Foundation

class KycVerificationViewController: BaseViewController<KycVerificationViewModel> {
    var navigationBar: UINavigationBar?
    
    var adhaarCardButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Poppins", size: 12)
        button.backgroundColor = UIColor.init(hex: "#7284F5")
        button.cornerRadius = 18
        return button
    }()
    
    var studentIdCardButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Poppins", size: 12)
        button.backgroundColor = .blueBackground
        button.cornerRadius = 18
        return button
    }()
    
    private var previewImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var rejectedReasonLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    } ()
    
    var infoView: ProfileOptionView = {
        let infoView = ProfileOptionView(renderData: ProfileOptionView.RenderData(
            imageWidth: 24,
            font: UIFont(name: "Poppins", size: 14),
            customSpacing: 12,
            height: 28,
            showRightIcon: false))
        infoView.translatesAutoresizingMaskIntoConstraints = false
        return infoView
    }()
    
    var verifyProfileInfo: UserInfoView = {
        let verifyInfo = UserInfoView(renderData: UserInfoView.RenderData(imageHeight: 152,
                                                                          imageWidth: 152,
                                                                          textColor: .black,
                                                                          titleFont: UIFont(name: "Poppins", size: 18)!))
        verifyInfo.translatesAutoresizingMaskIntoConstraints = false
        return verifyInfo
    }()
    
    var instructionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var adhaarNumberTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter Adhaar Number*"
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "Poppins", size: 12)
        textField.contentVerticalAlignment = .center
        textField.leftViewMode = .always
        textField.tintColor = .black
        return textField
    }()
    
    var uploadDocumentButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.titleLabel?.textColor = .white
        button.backgroundColor = .blueBackground
        return button
    }()
    
    override init(_ viewModel: KycVerificationViewModel) {
        super.init(viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNavigationBar()
        self.setupView()
        
        self.uploadDocumentButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        self.adhaarCardButton.addTarget(self, action: #selector(adhaarCardTapped), for: .touchUpInside)
        self.studentIdCardButton.addTarget(self, action: #selector(studentIdCardTapped), for: .touchUpInside)
        
        self.adhaarCardButton.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        self.studentIdCardButton.titleEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        self.rejectedReasonLabel.textColor = .white
//        self.rejectedReasonLabel.
        
    }
    
    override func reloadView() {
        super.reloadView()
        if let imageUrl = self.viewModel.previewImageUrl {
            do {
                let imageData = try Data(contentsOf: imageUrl)
                self.previewImageView.image = UIImage(data: imageData)
                self.uploadDocumentButton.setTitle("Send for approval", for: .normal)
            } catch {
                print("\(error.localizedDescription)")
            }
        } else {
            self.uploadDocumentButton.setTitle("Select Document", for: .normal)
            self.previewImageView.image = UIImage(systemName: "creditcard")
            self.verifyProfileInfo.setupData(name: "Verify your Profile",
                                             image: .withImage(UIImage(systemName: "checkmark.seal")!),
                                             info: "Upload your Aadhar card or school ID card to verify your Profile")
            self.adhaarCardButton.setTitle("Adhaar Card", for: .normal)
            self.studentIdCardButton.setTitle("Student Id Card", for: .normal)
            self.studentIdCardButton.setTitleColor(.white, for: .normal)
            
            self.infoView.setupData(image: .withImage(UIImage(systemName: "info.circle.fill")!), text: "Info")
            
            self.instructionLabel.text = "Step 1: Enter your Aadhar Number\n\nStep 2: Upload your Aadhar Card Photo (Refer Sample Aadhar Card)\n\nStep 3: Submit for approval\n\nNote: Make sure that your name and date of birth in the card matches the details in the profile"
            
            self.adhaarNumberTextField.setLeftIcon(UIImage(systemName: "creditcard")!, size: 16)
            
            if let remark = self.viewModel.remark {
                self.rejectedReasonLabel.text = remark
            } else {
                self.rejectedReasonLabel.isHidden = false
            }
        }
    }
    
    @objc func adhaarCardTapped() {
        self.viewModel.idType = .aadhar
        self.instructionLabel.text = "Step 1: Enter your Aadhar Number\n\nStep 2: Upload your Aadhar Card Photo (Refer Sample Aadhar Card)\n\nStep 3: Submit for approval\n\nNote: Make sure that your name and date of birth in the card matches the details in the profile"
        self.adhaarNumberTextField.placeholder = "Enter Adhaar Number*"
        
        self.adhaarCardButton.backgroundColor = UIColor.init(hex: "#7284F5")
        self.adhaarCardButton.setTitleColor(.white, for: .normal)
        self.studentIdCardButton.backgroundColor = .blueBackground
        self.studentIdCardButton.setTitleColor(.white, for: .normal)
        
        
    }

    @objc func studentIdCardTapped() {
        self.viewModel.idType = .schoolId
        self.adhaarNumberTextField.placeholder = "Enter Admission Number (Optional)"
        self.instructionLabel.text = "Step 1: Enter Details\n\nStep 2: Upload your School photo ID card proof (Refer Sample ID Card).\n\nStep 3: Submit for approval\n\nNote: Make sure that your name and date of birth in the card matches the details in the profile"

        
        self.studentIdCardButton.backgroundColor = UIColor.init(hex: "#7284F5")
        self.studentIdCardButton.setTitleColor(.white, for: .normal)
        self.adhaarCardButton.backgroundColor = .blueBackground
        self.adhaarCardButton.setTitleColor(.white, for: .normal)
    }

    @objc func uploadButtonTapped() {
        self.viewModel.uploadDocumentTapped(uniqueId: self.adhaarNumberTextField.text)
    }
    
    func setupView() {
        
        let switcherView = UIView(frame: .zero)
        switcherView.translatesAutoresizingMaskIntoConstraints = false
        switcherView.cornerRadius = 20
        
        self.containerView.addSubview(self.verifyProfileInfo)
        self.containerView.addSubview(switcherView)
        self.containerView.addSubview(self.rejectedReasonLabel)
        self.containerView.addSubview(self.infoView)
        self.containerView.addSubview(self.instructionLabel)
        self.containerView.addSubview(self.adhaarNumberTextField)
        self.containerView.addSubview(self.previewImageView)
        self.containerView.addSubview(self.uploadDocumentButton)
        
        self.verifyProfileInfo.topAnchor.constraint(equalTo: self.navigationBar?.bottomAnchor ?? self.containerView.topAnchor, constant: 16).isActive = true
        self.verifyProfileInfo.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        self.verifyProfileInfo.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        self.verifyProfileInfo.heightAnchor.constraint(equalToConstant: 155).isActive = true
        
        let line = UIView()
        self.containerView.addSubview(line)
        
        line.translatesAutoresizingMaskIntoConstraints = false
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        line.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        line.topAnchor.constraint(equalTo: self.verifyProfileInfo.bottomAnchor,constant: 16).isActive = true
        line.backgroundColor = .grayBackground
        
        switcherView.addSubview(self.adhaarCardButton)
        switcherView.addSubview(self.studentIdCardButton)
        switcherView.backgroundColor = .blueBackground
        
        switcherView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        switcherView.topAnchor.constraint(equalTo: line.bottomAnchor,
                                                   constant: 8).isActive = true
        switcherView.widthAnchor.constraint(equalToConstant: 252).isActive = true
        switcherView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        self.adhaarCardButton.leftAnchor.constraint(equalTo: switcherView.leftAnchor,
                                                    constant: 8).isActive = true
        self.adhaarCardButton.topAnchor.constraint(equalTo: switcherView.topAnchor,
                                                   constant: 8).isActive = true
        self.adhaarCardButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        self.adhaarCardButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        self.studentIdCardButton.leftAnchor.constraint(equalTo: self.adhaarCardButton.rightAnchor, constant: 16).isActive = true
        self.studentIdCardButton.topAnchor.constraint(equalTo: switcherView.topAnchor,
                                                   constant: 8).isActive = true
        self.studentIdCardButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        self.studentIdCardButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let line2 = UIView()
        self.containerView.addSubview(line2)
        
        line2.translatesAutoresizingMaskIntoConstraints = false
        line2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line2.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        line2.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        line2.topAnchor.constraint(equalTo: switcherView.bottomAnchor,constant: 8).isActive = true
        line2.backgroundColor = .grayBackground
        
        
        self.rejectedReasonLabel.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 16).isActive = true
        self.rejectedReasonLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        self.rejectedReasonLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        self.rejectedReasonLabel.cornerRadius = 8
        self.rejectedReasonLabel.backgroundColor = .systemRed
        
        self.infoView.topAnchor.constraint(equalTo: rejectedReasonLabel.bottomAnchor, constant: 16).isActive = true
        self.infoView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        self.infoView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        self.infoView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        self.instructionLabel.topAnchor.constraint(equalTo: self.infoView.bottomAnchor, constant: 16).isActive = true
        self.instructionLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        self.instructionLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        
        let line3 = UIView()
        self.containerView.addSubview(line3)
        
        line3.translatesAutoresizingMaskIntoConstraints = false
        line3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line3.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 16).isActive = true
        line3.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -16).isActive = true
        line3.topAnchor.constraint(equalTo: self.instructionLabel.bottomAnchor,constant: 8).isActive = true
        line3.backgroundColor = .grayBackground
        
        self.adhaarNumberTextField.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                                       constant: 16).isActive = true
        self.adhaarNumberTextField.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                                        constant: -16).isActive = true
        self.adhaarNumberTextField.topAnchor.constraint(equalTo: line3.bottomAnchor,
                                                      constant: 16).isActive = true
        self.adhaarNumberTextField.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        self.previewImageView.topAnchor.constraint(equalTo: self.adhaarNumberTextField.bottomAnchor,
                                                   constant: 16).isActive = true
        self.previewImageView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        self.previewImageView.widthAnchor.constraint(equalToConstant: 262).isActive = true
        self.previewImageView.heightAnchor.constraint(equalToConstant: 172).isActive = true
        
        self.uploadDocumentButton.topAnchor.constraint(equalTo: self.previewImageView.bottomAnchor,
                                              constant: 24).isActive = true
        self.uploadDocumentButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor,
                                               constant: 32).isActive = true
        self.uploadDocumentButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor,
                                              constant: -32).isActive = true
        self.uploadDocumentButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.uploadDocumentButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor,
                                                          constant: -16).isActive = true
        
        
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
        
        //MARK: For IQKeyboardManager we need to add it to container view instead view itself.
        self.containerView.addSubview(navigationBar)
        
        navigationBar.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        navigationBar.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        navigationBar.topAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        let navigationItem = UINavigationItem(title: "Student Verification")
        
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
}
