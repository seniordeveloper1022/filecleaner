//
//  BaseCollectionViewCell.swift
//  AlKadi
//
//  Created by Khurram Bilal Nawaz on 22/07/2016.
//  Copyright © 2016 Khurram Bilal Nawaz. All rights reserved.
//

import Foundation

import UIKit

public class BaseCollectionViewCell : UICollectionViewCell {
    
    func setBorderColor(view:UIView,color:UIColor, width: CGFloat? = 1) {
        
        view.layer.borderWidth = width!
        view.layer.borderColor = color.cgColor
    }
    
    //Mark:-SetImageWithUrl
//    func setImageWithUrl(imageView:UIImageView,url:String, placeHolder:String? = "IconLums"){
//        if let imageurl =  NSURL.init(string: url){
//            imageView.setIndicatorStyle(UIActivityIndicatorView.Style.gray)
//            imageView.setShowActivityIndicator(true)
//
//            imageView.sd_setImage(with: imageurl as URL?, placeholderImage: UIImage(named:placeHolder!))
//        }
//    }

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
    @IBAction func doneClicked(_ sender:AnyObject)
    {
        self.hideKeyboard()
    }
    func hideKeyboard() {
        self.endEditing(true)
    }
    
    
}
