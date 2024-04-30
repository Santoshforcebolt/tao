//
//  NointernetViewController.swift
//  creditcardapp
//
//  Created by Betto Akkara on 18/09/21.
//

import UIKit


struct AlertPageData {
    var title: String?
    var message: String?
    var image: UIImage?
    var btnTitile: String?
    init(
        title: String?,
        message: String?,
        image: UIImage?,
        btnTitile: String?
    ) {
        self.title = title
        self.message = message
        self.image = image
        self.btnTitile = btnTitile
    }
}

protocol AlertpageDelegate : class {
    func onDismiss()
}

/// Common Alert Page
class NointernetViewController: UIViewController {

    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var actionBtn: UIButton!

    weak var delegate : AlertpageDelegate?

    var alert_viewTitle : String? = ""
    var alert_message : String? = ""
    var alert_image : UIImage = UIImage()
    var alert_actionBtn : String? = ""

    var data : AlertPageData?  {
        didSet{
            self.alert_viewTitle = data?.title ?? ""
            self.alert_message = data?.message ?? ""
            self.alert_image = data?.image ?? UIImage()
            self.alert_actionBtn = data?.btnTitile ?? ""

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewTitle.text = alert_viewTitle
        message.text = alert_message
        image.image = alert_image
        actionBtn.setTitle(alert_actionBtn, for: .normal)

    }

    @IBAction func actionBtn(_ sender: Any) {
        delegate?.onDismiss()
    }

    @IBAction func bakcBtn(_ sender: Any) {
        delegate?.onDismiss()
    }

    func AlertPageDismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {

            }
        }
    }

}
