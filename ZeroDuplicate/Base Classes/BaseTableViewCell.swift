//
//  BaseTableViewCell.swift
//  AlKadi
//
//  Created by Khurram Bilal Nawaz on 22/07/2016.
//  Copyright © 2016 Khurram Bilal Nawaz. All rights reserved.
//

import Foundation
import UIKit

public class BaseTableViewCell : UITableViewCell {
    
    func setBorderColor(view:UIView,color:UIColor, width: CGFloat? = 1) {
        
        view.layer.borderWidth = width!
        view.layer.borderColor = color.cgColor
    }
    
    func addDatePicker(textfield:UITextField)  {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        
        datePickerView.maximumDate = Date()
        textfield.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    func addShadowOnView(view:UIView,color:UIColor,radius:Int,opacity:Float? = 1) {
        //view.center = self.view.center
        view.layer.shadowOpacity = opacity!
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = CGFloat(radius)
        //self.view.addSubview(view)
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        //textfield.text = dateFormatter.string(from: sender.date)
    }
    //MARK:-setToolbarOnPickerView
    func addToolBarToPickerView(textField:UITextField)
    {
        var buttonDone = UIBarButtonItem()
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        let buttonflexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        //buttonDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target:self, action:#selector(BaseViewController.doneClicked(_:)))
        
        
        let button =  UIButton(type: .custom)
        button.addTarget(self, action: #selector(BaseViewController.doneClicked(_:)), for: .touchUpInside)
        //button.frame = CGRectMake(0, 0, 53, 31)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        //  button.setTitleColor(UIColor(netHex: 0xAE2540), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.contentMode = UIView.ContentMode.right
        button.frame = CGRect(x:0, y:0, width:60, height:40)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
        buttonDone = UIBarButtonItem(customView: button)
        
        
        toolbar.setItems(Array.init(arrayLiteral: buttonflexible,buttonDone), animated: true)
        textField.inputAccessoryView = toolbar
        
    }
    func addToolBarToPickerViewOnTextview(textview:UITextView)
    {
        var buttonDone = UIBarButtonItem()
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        let buttonflexible = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        //buttonDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target:self, action:#selector(BaseViewController.doneClicked(_:)))
        //buttonDone.title = "ye bat"
        
        let button =  UIButton(type: .custom)
        button.addTarget(self, action: #selector(BaseViewController.doneClicked(_:)), for: .touchUpInside)
        //button.frame = CGRectMake(0, 0, 53, 31)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        //button.setTitleColor(UIColor(netHex: 0xAE2540), for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.contentMode = UIView.ContentMode.right
        button.frame = CGRect(x:0, y:0, width:60, height:40)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        
        buttonDone = UIBarButtonItem(customView: button)
        toolbar.setItems(Array.init(arrayLiteral: buttonflexible,buttonDone), animated: true)
        textview.inputAccessoryView = toolbar
        
    }
    @IBAction func doneClicked(_ sender:AnyObject)
    {
        self.hideKeyboard()
    }
    func hideKeyboard() {
        self.endEditing(true)
    }
    //Mark:-SetImageWithUrl
    func setImageWithUrl(imageView:UIImageView,url:String, placeholder:String? = ""){
        let finalUrl = url.replacingOccurrences(of: " ", with: "%20")
        if let imageurl =  NSURL.init(string: finalUrl){
            imageView.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
            imageView.sd_setShowActivityIndicatorView(true)
            
            imageView.sd_setImage(with: imageurl as URL?, placeholderImage: UIImage(named:placeholder!))
            
//            imageView.sd_setImage(with: imageurl as URL!, completed: { (image, error, type, url) in
//                imageView.setShowActivityIndicator(false)
//                if ((error) != nil) {
//                    if let pCircle = profileCircle{
//                        if (pCircle == true) {
//                            imageView.image = UIImage(named: "DaleelDetailLogo")
//                        }
//                    }
//                }
//            })
            
           
        }
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
   
    
   
}
