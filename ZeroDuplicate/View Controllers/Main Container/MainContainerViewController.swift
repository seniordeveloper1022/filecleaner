//
//  MainContainerViewController.swift
//  CabIOS
//
//  Created by Ghafar Tanveer on 06/02/2018.
//  Copyright © 2018 Ghafar Tanveer. All rights reserved.
//

import UIKit

protocol TopBarDelegate:NSObjectProtocol {
    func actionCallBackMoveBack()
    func actionCallBackEnableImageSelection()
    func actionCallBackDisableImageSelection()
}

extension TopBarDelegate{
    func actionCallBackEnableImageSelection(){}
    func actionCallBackDisableImageSelection(){}
}

class MainContainerViewController: BaseViewController {
    
   
    @IBOutlet weak var bottomBarHeight : NSLayoutConstraint!
    @IBOutlet weak var topBarHeight : NSLayoutConstraint!
    @IBOutlet weak var viewContainer : UIView!
    @IBOutlet weak var btnAdd : UIButton!
    @IBOutlet weak var btnEdit : UIButton!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var btnScan : UIButton!
    @IBOutlet weak var btnResult : UIButton!
    @IBOutlet weak var btnSetting : UIButton!
    @IBOutlet weak var btnDelete : UIButton!

//
    var delegate:TopBarDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnEdit.isHidden = true
        self.showHomeController()
    }
   
    func setbackgroundColor(color:UIColor)  {
        //self.viewBackground.backgroundColor = color
    }
    func addBackIcon(isAddBack:Bool? = false) {
        if(isAddBack!){
            self.btnAdd.isSelected = true
            self.btnAdd.setTitle("Back", for: .normal)
            self.btnAdd.setTitle("Back", for: .selected)
            self.btnAdd.setImage(UIImage(named: ""), for: .normal)
            self.btnAdd.setImage(UIImage(named: ""), for: .selected)
        }else{
            self.btnAdd.isSelected = false
            self.btnAdd.setTitle("", for: .normal)
            self.btnAdd.setTitle("", for: .selected)
            self.btnAdd.setImage(UIImage(named: "addWhite"), for: .normal)
            self.btnAdd.setImage(UIImage(named: "addWhite"), for: .selected)
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func addHomeIcon(isAddHome:Bool? = false) {
        if(isAddHome!){
            self.btnEdit.isSelected = true
            self.btnEdit.setTitle("Home", for: .normal)
            
        }else{
            self.btnEdit.isSelected = false
            self.btnEdit.setTitle("", for: .normal)
            
        }
    }
    
    //MARK:- FUNCTIONS
    func showResultController()  {
        
        self.bottomBarHeight.constant = 60
        let storyBoard = UIStoryboard(name: StoryboardName.Main, bundle: nil)
        var controller = BaseNavigationController()
        controller = storyBoard.instantiateViewController(withIdentifier: ControllerIdentifier.ResultNavigationController) as! BaseNavigationController
        addChild(controller)
        if let topVC = controller.topViewController as? ResultGroupsViewController{
            ///topVC.allPhotos = Global.shared.allPhotos
            topVC.isFromMenu = true
        }
        controller.view.frame = self.viewContainer.bounds
        self.viewContainer.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    func showHomeController()  {
        
        //        self.topBarHeight.constant = 0
        self.bottomBarHeight.constant = 60
        let storyBoard = UIStoryboard(name: StoryboardName.Main, bundle: nil)
        var controller = BaseNavigationController()
        controller = storyBoard.instantiateViewController(withIdentifier: ControllerIdentifier.HomeNavigationController) as! BaseNavigationController
        addChild(controller)
        controller.view.frame = self.viewContainer.bounds
        self.viewContainer.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    func showSettingController()  {
        
        self.bottomBarHeight.constant = 60
        let storyBoard = UIStoryboard(name: StoryboardName.Main, bundle: nil)
        var controller = BaseNavigationController()
        controller = storyBoard.instantiateViewController(withIdentifier: ControllerIdentifier.SettingNavigationViewController) as! BaseNavigationController
        addChild(controller)
        controller.view.frame = self.viewContainer.bounds
        self.viewContainer.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func changeButtonColor(tag: Int){
        self.btnScan.setImage(UIImage(named: "iconScanColored"), for: .normal)
        self.btnDelete.setImage(UIImage(named: "iconDeleteColored"), for: .normal)
        self.btnSetting.setImage(UIImage(named: "iconSettingColored"), for: .normal)
        self.btnResult.setImage(UIImage(named: "iconResultColored"), for: .normal)
        if(tag == 0){
            self.btnScan.setImage(UIImage(named:"iconScan"), for: .normal)
        }else if(tag == 1){
            self.btnResult.setImage(UIImage(named:"iconResult"), for: .normal)
        }else if(tag == 2){
            self.btnSetting.setImage(UIImage(named:"iconSetting"), for: .normal)
        }else if(tag == 3){
            self.btnDelete.setImage(UIImage(named:"iconDelete"), for: .normal)
        }
    }
    
    //MARK:- ACTION METHODS
    @IBAction func actionhandleBottomMenu(_ sender:UIButton){
        //iconDeleteColored,iconDelete,iconResult,iconResultColored,iconScan,iconScanColored,iconSetting,iconSettingColored
        
        if(sender.tag == 0){
            self.changeButtonColor(tag: sender.tag)
            self.showHomeController()
        }else if(sender.tag == 1){
            self.changeButtonColor(tag: sender.tag)
            self.showResultController()
        }else if(sender.tag == 2){
            self.changeButtonColor(tag: sender.tag)
            self.showSettingController()
        }else if(sender.tag == 3){
            self.changeButtonColor(tag: sender.tag)
        }
    }
    
    @IBAction func actionBack(_ sender:UIButton){
        if(sender.isSelected){
            if let del = self.delegate{
                del.actionCallBackMoveBack()
            }
        }else{
            
        }
    }
    @IBAction func actionEdit(_ sender:UIButton){
        if(sender.isSelected){
            sender.isSelected = false
            if let del = self.delegate{
                del.actionCallBackDisableImageSelection()
            }
        }else{
             sender.isSelected = true
            if let del = self.delegate{
                del.actionCallBackEnableImageSelection()
            }
        }
    }
   
    
    
}
