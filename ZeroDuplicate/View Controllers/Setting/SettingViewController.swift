//
//  SettingViewController.swift
//  ZeroDuplicate
//
//  Created by Waqas Ahmad on 18/03/2019.
//  Copyright © 2019 trivalent. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var lblPercentage : UILabel!
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var btnImageRotation : UIButton!
    @IBOutlet weak var btnGrayScale : UIButton!
    @IBOutlet weak var btnRestore : UIButton!
    @IBOutlet weak var btnCancel : UIButton!
    var rotationBox : Bool = false
    var scaleBox : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.btnCancel.layer.borderColor = UIColor.white.cgColor
        self.btnCancel.layer.cornerRadius = 5
        self.btnCancel.layer.borderWidth = 1

        self.btnRestore.layer.borderColor = UIColor.white.cgColor
        self.btnRestore.layer.cornerRadius = 5
        self.btnRestore.layer.borderWidth = 1
        
        self.lblPercentage.text = "Similarity Thershold: \(Global.shared.similarityThershold)%"
        self.slider.value = Float(Global.shared.similarityThershold)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let container = self.mainContainer{
            container.lblTitle.text = "Settings"
            container.btnEdit.isHidden = true
        }
    }
    

    //MARK:- Actions
    @IBAction func actionImageRotation(_ sender:Any){
        if(self.rotationBox){
            self.rotationBox = false
            self.btnImageRotation.setImage(UIImage(named: "checkBoxChecked"), for: .normal)
        }else{
            self.rotationBox = true
             self.btnImageRotation.setImage(UIImage(named: "Checkbox"), for: .normal)
        }
    }
    @IBAction func actionScale(_ sender:Any){
        if(self.scaleBox){
            self.scaleBox = false
            self.btnGrayScale.setImage(UIImage(named: "checkBoxChecked"), for: .normal)
        }else{
            self.scaleBox = true
            self.btnGrayScale.setImage(UIImage(named: "Checkbox"), for: .normal)
        }
    }
    @IBAction func actionChangeSimilarityThershold(_ sender: UISlider) {
        var intValue = Int(sender.value)
        if(intValue < 50){
            sender.value = 50
            intValue = 50
        }
        self.lblPercentage.text = "Similarity Thershold: \(intValue)%"

        
    }
    @IBAction func actionRestore(_ sender:Any){
        self.slider.value = 50
        let intValue = Int(self.slider.value)
        self.lblPercentage.text = "Similarity Thershold: \(intValue)%"
    }
    @IBAction func actionCancel(_ sender:Any){
        if let contianer = self.mainContainer{
            contianer.actionhandleBottomMenu(contianer.btnScan)
        }
    }
    @IBAction func actionNext(_ sender:Any){
        Global.shared.similarityThershold = Int(self.slider.value)
        if let contianer = self.mainContainer{
            contianer.actionhandleBottomMenu(contianer.btnScan)
        }
    }
}
