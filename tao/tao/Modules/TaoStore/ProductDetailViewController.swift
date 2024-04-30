//
//  ProductDetailViewController.swift
//  tao
//
//  Created by Mayank Khursija on 04/06/22.
//

import Foundation

class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {
    
    var caraouselCollectionView: UICollectionView
    
    var claimNowButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.backgroundColor = .blueBackground
        return button
    }()
    
    var addToDreamListButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont(name: "Poppins", size: 16)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var priceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var discountedPriceLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Poppins", size: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var instructionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    } ()
    
    override init(_ viewModel: ProductDetailViewModel) {
        
        let caraouselCollectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        caraouselCollectionViewLayout.scrollDirection = .horizontal
        self.caraouselCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: caraouselCollectionViewLayout)
        self.caraouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.caraouselCollectionView.delegate = self
        self.caraouselCollectionView.dataSource = self
        self.caraouselCollectionView.showsHorizontalScrollIndicator = false
        self.caraouselCollectionView.register(BannerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.titleLabel.text = self.viewModel.productTitle
        self.priceLabel.text = self.viewModel.discountedPrice
        let attributedText = NSAttributedString(
            string: self.viewModel.price,
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        self.discountedPriceLabel.attributedText = attributedText
        
        let discount: Int = Int(((self.viewModel.product.coinsDiscount ?? 0)/(self.viewModel.product.coinsAmount ?? 0)) * 100)
        if TaoHelper.userProfile?.userDetails?.isPremiumUser ?? false {
            self.instructionLabel.text = "You have \(discount)% premium memeber discount"
        } else {
            self.instructionLabel.text = "Update to preimum account and get \(discount)% discount"
        }
        
        self.addToDreamListButton.setTitle("Add to Dreamlist", for: .normal)
        self.claimNowButton.setTitle("Claim Now", for: .normal)
        self.claimNowButton.addTarget(self, action: #selector(claimNowButtonTapped), for: .touchUpInside)
        
        self.descriptionLabel.text = self.viewModel.product.description
    }
    
    func setupView() {
        self.containerView.addSubview(self.caraouselCollectionView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.instructionLabel)
        
        self.caraouselCollectionView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        self.caraouselCollectionView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        self.caraouselCollectionView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 52).isActive = true
        self.caraouselCollectionView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.caraouselCollectionView.bottomAnchor, constant: 8).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        
        let stackView: UIStackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        let coinImageViewPriceLabel = UIImageView(frame: .zero)
        coinImageViewPriceLabel.contentMode = .scaleAspectFit
        coinImageViewPriceLabel.image = UIImage(named: "twemoji_coin")
        
        let coinImageViewDiscountedPriceLabel = UIImageView(frame: .zero)
        coinImageViewDiscountedPriceLabel.contentMode = .scaleAspectFit
        coinImageViewDiscountedPriceLabel.image = UIImage(named: "twemoji_coin")
        
        
        stackView.addArrangedSubview(coinImageViewPriceLabel)
        stackView.addArrangedSubview(self.priceLabel)
        stackView.addArrangedSubview(coinImageViewDiscountedPriceLabel)
        stackView.addArrangedSubview(self.discountedPriceLabel)
        
        coinImageViewPriceLabel.frame.size.width = 18
        coinImageViewPriceLabel.frame.size.height = 18
        coinImageViewDiscountedPriceLabel.frame.size.width = 12
        coinImageViewDiscountedPriceLabel.frame.size.height = 12
        
        coinImageViewPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.priceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        coinImageViewDiscountedPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        self.containerView.addSubview(stackView)
        
        stackView.setCustomSpacing(16, after: self.priceLabel)
        
        stackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.instructionLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                                   constant: 8).isActive = true
        self.instructionLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        self.instructionLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        
        self.containerView.addSubview(self.descriptionLabel)
        
        self.descriptionLabel.topAnchor.constraint(equalTo: self.instructionLabel.bottomAnchor,
                                                   constant: 8).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -66).isActive = true
        
        let bottomView = UIStackView(frame: .zero)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.axis = .horizontal
        bottomView.distribution = .fillEqually
        //MARK: For now we do not need add to dream list button
//        bottomView.addArrangedSubview(self.addToDreamListButton)
        bottomView.addArrangedSubview(self.claimNowButton)
        
        self.view.addSubview(bottomView)
        
        bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 58).isActive = true
        
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar(frame: .zero)
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
        
        let navigationItem = UINavigationItem(title: "Product")
        
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
    
    @objc func claimNowButtonTapped() {
        self.viewModel.claimNowButtonTapped()
    }
    
    override func backAction() {
        super.backAction()
        self.viewModel.backButtonTapped()
    }
}

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as? BannerViewCell ?? BannerViewCell(frame: .zero)
        if let url = URL(string: self.viewModel.imageUrls[indexPath.row]) {
            cell.setupImage(image: .withURL(url))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.viewModel.numberOfImages <= 1 {
            return CGSize(width: collectionView.frame.size.width, height: 380)
        } else {
            return CGSize(width: 300, height: 380)
        }
    }
}
