//
//  EXT_UITextField.swift
//  tao
//
//  Created by Betto Akkara on 06/02/22.
//

import Foundation

extension UITextField{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard()
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let image = UIImage(named: "ic_hideKeyBoard")?.withRenderingMode(.alwaysOriginal)
        let done: UIBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}


@IBDesignable
@objc open class TaoTextField: UITextField {

    //MARK:- UITtextfield Draw Method Override
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    @IBInspectable var rightImageWidth : CGFloat = 30{
        didSet{

        }
    }

    open override var isEnabled: Bool{
        didSet{
            self.alpha = (self.isEnabled == true ? 1 : 0.5)
        }
    }

    @IBInspectable var rightImage : UIImage?{
        didSet{

            let uiview = UIView(frame: CGRect(x: 0, y: 0, width: rightImageWidth, height: bounds.size.height))
            let imageView = UIImageView(image: rightImage)

            self.rightView = uiview
            uiview.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 10, y: 0, width: rightImageWidth - 20, height: bounds.size.height)
            self.layoutSubviews()
            self.rightViewMode = .always
        }
    }
    @IBInspectable var leftImageWidth : CGFloat = 33{
        didSet{

        }
    }
    @IBInspectable var leftImage : UIImage?{
        didSet{

            let uiview = UIView(frame: CGRect(x: 0, y: 0, width: leftImageWidth, height: bounds.size.height))
            let imageView = UIImageView(image: leftImage)
            self.leftView = uiview
            uiview.addSubview(imageView)
            imageView.frame = CGRect(x: 10, y: 0, width: leftImageWidth - 20, height: bounds.size.height)
            imageView.contentMode = .scaleAspectFit

            self.layoutSubviews()
            self.leftViewMode = .always

        }
    }

    func upadteTextField(frame:CGRect) -> Void {
         self.frame = frame;
         self.initialize()
     }
       func initialize() -> Void {
           self.clipsToBounds = true
       }

}

