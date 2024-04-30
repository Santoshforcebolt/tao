//
//  BaseViewHandler.swift
//  tao
//
//  Created by Mayank Khursija on 28/05/22.
//

import Foundation
import UIKit
import AVKit
import FloatingPanel

typealias ImagePickerResult = (URL)-> Void

protocol ErrorHandling {
    func showToast(with error: String?)
}

enum GalleryMediaType: String {
    case video = "public.movie"
    case image = "public.image"
}

class BaseViewHandler: NSObject {
    private var presentingViewController: UIViewController
    private var imagePickerCompletion: ImagePickerResult?
    private var imagePickerController = UIImagePickerController()
    var fpc: FloatingPanelController!
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func presentView(viewController: UIViewController) {
        DispatchQueue.main.async {
            self.presentingViewController.navigationController?.present(viewController,
                                                                        animated: true,
                                                                        completion: nil)
        }
    }
    
    func pushViewController(viewController: UIViewController) {
        DispatchQueue.main.async {
            self.presentingViewController.navigationController?.pushViewController(viewController,
                                                                                   animated: false)
        }
    }
    
    func popViewController() {
        self.presentingViewController.navigationController?.popViewController(animated: false)
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = false) {
        if let vc = self.presentingViewController.navigationController?.viewControllers.filter({$0.isKind(of: ofClass)}).last {
            self.presentingViewController.navigationController?.popToViewController(vc, animated: animated)
            self.presentingViewController = vc
        }
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            (self.presentingViewController as? ReloadableView)?.reloadView()
        }
    }
    
    func showLoading() {
        (self.presentingViewController as? ReloadableView)?.showLoading()
    }
    
    func stopLoading() {
        (self.presentingViewController as? ReloadableView)?.stopLoading()
    }

    func pushViewModel(viewModel: BaseViewModel) {
        let viewController = self.getViewController(viewModel: viewModel)
        self.pushViewController(viewController: viewController)
    }
    
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        for action in actions {
            alertVC.addAction(action)
        }
        self.presentView(viewController: alertVC)
    }
    
    func setRootViewController(viewController: UIViewController) {
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                let navigationController = UINavigationController(rootViewController: viewController)
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        }
    }
}

extension BaseViewHandler {
    func getViewController(viewModel: BaseViewModel) -> UIViewController {
        switch viewModel {
        case is ChooseVideoViewModel:
            return ChooseVideoViewController(viewModel as! ChooseVideoViewModel)
        default:
            return BaseViewController(BaseViewModel())
        }
    }
}

//MARK: Request Photos from Library
extension BaseViewHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func getMediaURLFromLibrary(mediaType: GalleryMediaType = .video, completion: @escaping ImagePickerResult) {
        self.imagePickerCompletion = completion
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            DispatchQueue.main.async {
                self.imagePickerController.delegate = self
                self.imagePickerController.sourceType = .savedPhotosAlbum
                self.imagePickerController.allowsEditing = false
                self.imagePickerController.mediaTypes = [mediaType.rawValue]
                self.presentView(viewController: self.imagePickerController)
            }
        }
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        self.imagePickerController.dismiss(animated: true) {
            if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                self.imagePickerCompletion?(videoURL)
            } else if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                self.imagePickerCompletion?(imageURL)
            }
        }
    }
}

//MARK: Share
extension BaseViewHandler {
    func share(text: String) {
        let activityViewController = UIActivityViewController(activityItems: [text] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.presentingViewController.view
        self.presentingViewController.present(activityViewController, animated: true, completion: nil)
    }
}

//MARK: Error Handling
extension BaseViewHandler: ErrorHandling {
    func showToast(with error: String?) {
        DispatchQueue.main.async {
            self.presentingViewController.view.makeToast(error ?? "Something went wrong, Please try again!")
        }
    }
}

//MARK: Show Extra-Curricular Screens
extension BaseViewHandler {
    func showAddCaption(mediaDetails: MediaDetails, mediaType: String) {
        let viewModel = EnterCaptionViewModel(mediaDetails: mediaDetails, mediaType: mediaType)
        let viewController = EnterCaptionViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showSubmitVideo() {
        let viewModel = SubmitActivityViewModel(competition: .extraCurricular)
        let viewController = SubmitActivityViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
}

//MARK: Show Quiz Screens
extension BaseViewHandler {
    func showQuiz(questions: [QuizQuestion], competitionId: String) {
        let viewModel = QuizViewModel(questions: questions,
                                      competitionId: competitionId)
        let viewController = QuizViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showSubmitQuiz(competitionId: String, allQuestionsParams: [[String: Any]]) {
        let viewModel = SubmitActivityViewModel(competition: .academic)
        viewModel.competitionId = competitionId
        viewModel.allQuestionsParams = allQuestionsParams
        let viewController = SubmitActivityViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showQuizResult(competitionID: String) {
        let viewModel = QuizResultViewModel(competitionId: competitionID)
        let viewController = QuizResultViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showCompetitionLeaderBoard() {
        let viewModel = LeaderBoardCompetitionViewModel()
        let viewController = LeaderBoardCompetitionViewController(viewModel)
        let viewHandler = BaseViewHandler(presentingViewController: viewController)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        viewHandler.pushViewController(viewController: viewController)
    }
}

//MARK: Product Screens
extension BaseViewHandler {
    func showProductScreen(product: Product) {
        let viewModel = ProductDetailViewModel(product: product)
        let viewController = ProductDetailViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showOrderDetailsScreen(product: Product) {
        let viewModel = CheckoutViewModel(product: product)
        let viewController = CheckoutViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showOrderSuccessScreen(product: Product, order: Order, orderStatus: OrderStatus, flow: OrderFlow = .store) {
        let viewModel = OrderDetailsViewModel(product: product, order: order, orderStatus: orderStatus, flow: flow)
        let viewController = OrderDetailsViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showSearchScreen(searchFlow: SearchFlow) {
        let viewModel = SearchViewModel(searchFlow: searchFlow)
        let viewController = SearchViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showAddAddressScreen(action: AddressViewModel.Action = .add) {
        let viewModel = AddressViewModel(action: action)
        let viewController = AddressViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showProductsByCategory(cateogry: String) {
        let viewModel = CategoryProductViewModel(category: cateogry)
        let viewController = CategoryProductViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
}

//MARK: TAO TV Screens
extension BaseViewHandler {
    
    func showStoryView(mediaEntries: [TVMedia], index: Int) {
        let viewModel = TaoStoryViewModel(mediaEntries: mediaEntries, itemSelected: index)
        let viewController = TaoStoryViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showReportSheet(listOfMainItems: [String],
                         listOfReportItems: [String],
                         mediaId: String,
                         userId: String) {
        
        let reportVM = ReportSheetViewModel(listOfMainItems: listOfMainItems,
                                            listOfReportItems: listOfReportItems,
                                            mediaId: mediaId,
                                            userId: userId,
                                            completion: {flow in 
            self.fpc.removePanelFromParent(animated: true,
                                      completion: nil)
            if flow == "media" {
                self.showToast(with: "Reported Successfully")
            } else {
                self.showToast(with: "Blocked Successfully")
            }
        })
        reportVM.viewHandler = BaseViewHandler(presentingViewController: self.presentingViewController)
        let reportVC = ReportSheetViewController(reportVM)
        
        fpc = FloatingPanelController()
        fpc.delegate = self.presentingViewController as? FloatingPanelControllerDelegate
        fpc.isRemovalInteractionEnabled = true
        fpc.contentMode = .fitToBounds
        
        // Set a content view controller.
        fpc.set(contentViewController: reportVC)
        
        // Track a scroll view(or the siblings) in the content view controller.
        fpc.track(scrollView: reportVC.tableView)
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self.presentingViewController, animated: true, completion: nil)
    }
    
    func showLeaderBoardDetail(leaderBoard: LeaderBoard, type: RewardType) {
        let detailVM = LeaderBoardDetailViewModel(leaderBoard: leaderBoard, type: type)
        detailVM.viewHandler = BaseViewHandler(presentingViewController: self.presentingViewController)
        let leaderBoardVC = LeaderBoardDetailViewController(detailVM)
        
        fpc = FloatingPanelController()
        fpc.delegate = self.presentingViewController as? FloatingPanelControllerDelegate
        fpc.isRemovalInteractionEnabled = true
        fpc.contentMode = .fitToBounds
        
        // Set a content view controller.
        fpc.set(contentViewController: leaderBoardVC)
        
        fpc.backdropView.dropShadow()
        
        // Track a scroll view(or the siblings) in the content view controller.
        fpc.track(scrollView: leaderBoardVC.transactionCollectionView)
        
        let appearance = SurfaceAppearance()

        // Define shadows
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = UIColor.black
        shadow.offset = CGSize(width: 0, height: 16)
        shadow.radius = 16
        shadow.spread = 20
        appearance.shadows = [shadow]

        // Define corner radius and background color
        appearance.cornerRadius = 20.0

        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        fpc.addPanel(toParent: self.presentingViewController, animated: true, completion: nil)
    }
}

extension BaseViewHandler: FloatingPanelControllerDelegate {
    func floatingPanelWillBeginDragging(_ vc: FloatingPanelController) {
        self.presentingViewController.view.isUserInteractionEnabled = true
    }

    func floatingPanelWillEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetState: UnsafeMutablePointer<FloatingPanelState>) {
        self.presentingViewController.view.isUserInteractionEnabled = false
    }
}

//MARK: Profile Screens
extension BaseViewHandler {
    
    func showVerifyKyc() {
        let viewModel = KycVerificationViewModel()
        let viewController = KycVerificationViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showManageAddress() {
        let viewModel = ManageAddressViewModel()
        let viewController = ManageAddressViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showWallet(switchTab: ( (Int)-> Void)?) {
        let viewModel = WalletViewModel(switchTab: switchTab)
        let viewController = WalletViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showSelectTransactionType(walletDetails: UserWalletResponse, completion: @escaping (Bool)-> Void) {
        let viewModel = SelectTransactionTypeViewModel(walletDetails: walletDetails,
                                                       completion: completion)
        let viewController = SelectTransactionTypeViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showWithdrawAmountScreen(walletDetails: UserWalletResponse,
                                  transactionType: TransactionType,
                                  completion: @escaping (Bool)-> Void) {
        let viewModel = WithdrawRewardViewModel(walletDetails: walletDetails,
                                                transactionType: transactionType,
                                                completion: completion)
        let viewController = WithdrawRewardViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showTransactionHistory() {
        let viewModel = TransactionHistoryViewModel()
        let viewController = TransactionHistoryViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showOrders() {
        let viewModel = OrdersViewModel()
        let viewController = OrdersViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showVisitProfile(userId: String) {
        let viewModel = VisitProfileViewModel(userId: userId, completion: { isUserBlocked in
            if isUserBlocked {
                self.popViewController()
                self.showUserBlocked(userId: userId)
            }
        })
        let viewController = VisitProfileViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showUserBlocked(userId: String) {
        let viewModel = UserBlockedViewModel(userId: userId, completion: { _ in
            self.popViewController()
            self.showVisitProfile(userId: userId)
        })
        let viewController = UserBlockedViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showManageSubscription() {
        let viewModel = ManageSubscriptionViewModel()
        let viewController = ManageSubscriptionViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showPaymentScreen(planDetail: PlanDetails, completition: @escaping ()-> Void) {
        let viewModel = PaymentViewModel(planDetails: planDetail, completition: completition)
        let viewController = PaymentViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showFeedbackForm() {
        let viewModel = FeedbackViewModel()
        let viewController = FeedbackViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showSupportScreen() {
        let viewModel = SupportViewModel()
        let viewController = SupportViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showReferralScreen() {
        let viewModel = MyReferralViewModel()
        let viewController = MyReferralViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
}

extension BaseViewHandler {
    func showWebView(url: URL) {
        let viewModel = WebViewModel(url: url)
        let viewController = WebViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
}

extension BaseViewHandler {
    func showKycStatus(status: KycStatuses) {
        let viewModel = KycStatusViewModel(status: status)
        let viewController = KycStatusViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
}

extension BaseViewHandler {
    func showEntriesScreen(competitionId: String) {
        let viewModel = CompetitionEventsViewModel(competitionId: competitionId, for: .competition)
        let viewController = CompetitionEventsViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showUserEntriesScreen() {
        let viewModel = CompetitionEventsViewModel(competitionId: "NA", for: .user)
        let viewController = CompetitionEventsViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showMyCompetitions() {
        let viewModel = MyCompetitionsViewModel()
        let viewController = MyCompetitionsViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showMyCertificates() {
        let viewModel = MyCertificatesViewModel()
        let viewController = MyCertificatesViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
}

extension BaseViewHandler {
    func showNotifications() {
        let viewModel = NotificationViewModel()
        let viewController = NotificationViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showAllActivities(activities: [Activity]) {
        let viewModel = ActivityListViewModel(competitions: activities)
        let viewController = ActivityListViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showAllAcademics(activities: [AcademicCompetitions]) {
        let viewModel = CulturalListViewModel(competitions: activities)
        let viewController = CulturalListViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
    
    func showAllCompsByCategory(cateogry: String, subCategory: String) {
        let viewModel = CategoryCompetitionViewModel(category: cateogry, subCategory: subCategory)
        let viewController = CategoryCompetitionViewController(viewModel)
        viewModel.viewHandler = BaseViewHandler(presentingViewController: viewController)
        self.pushViewController(viewController: viewController)
    }
}

extension BaseViewHandler {
    func logout() {
        AppController.shared.clearUserState()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let ob_vc = storyBoard.instantiateViewController(withIdentifier: "SplashViewController") as? SplashViewController else {
            return
        }
        self.setRootViewController(viewController: ob_vc)
    }
}
