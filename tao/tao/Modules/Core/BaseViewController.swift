//
//  BaseViewController.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//


//MARK: Improvements
/**
 1. Setup navigation bar in baseViewController
 2. Back Action Should be move to base view model for action handling
 */

import Foundation

protocol ViewTransitionEvents {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
}

protocol ReloadableView {
    func reloadView()
    func showLoading()
    func stopLoading()
}

class BaseViewController<VM>: UIViewController, ReloadableView
where VM: ViewTransitionEvents {
    
    let viewModel: VM
    let scrollView = UIScrollView()
    let containerView = UIView()
    var enableScrollView = true
    
    init(_ viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func reloadView() {
  
    }
    
    func showLoading() {
        BALoader.show(currentViewController: self)
    }
    
    func stopLoading() {
        BALoader.dismiss(currentViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.viewDidLoad()
        
        if self.enableScrollView {
            self.view.addSubview(self.scrollView)
            self.scrollView.addSubview(self.containerView)
            
            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.containerView.translatesAutoresizingMaskIntoConstraints = false
            self.scrollView.showsVerticalScrollIndicator = false
            
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true

            let layoutGuide = scrollView.contentLayoutGuide
            
            self.containerView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
            self.containerView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
            self.containerView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
            self.containerView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
            self.containerView.widthAnchor.constraint(equalTo: self.scrollView.frameLayoutGuide.widthAnchor).isActive = true
        }
    }
    
    func enableBackButtonNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false,
                                                          animated: false)
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backbutton.backgroundColor = .white
        backbutton.layer.cornerRadius = 8
        backbutton.tintColor = .black
        backbutton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        backbutton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.viewDidDisappear()
    }
    
    @objc func backAction() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
