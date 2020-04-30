//
//  ResultGroupViewController.swift
//  ZeroDuplicate
//
//  Created by Waqas Ahmad on 15/03/2019.
//  Copyright © 2019 trivalent. All rights reserved.
//

import UIKit
import Photos

protocol ResultViewControllerDelegate:NSObjectProtocol {
    func actionCallBackUpdateList(images:[ImageViewModel])
}
class ResultViewController: UIViewController,TopBarDelegate {

    @IBOutlet weak var tblResult : UITableView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var btnDelete : UIButton!
    
    var imageArray = [UIImage]()
    var isFromMenu:Bool? = false
    var results:[ImageViewModel]?
    var isSelectionEnable:Bool? = false
    var searchResults:[Int:[ImageViewModel]]? = Global.shared.searchResults
    var delegate:ResultViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = "Image"
       self.btnDelete.layer.cornerRadius = 35
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let container = self.mainContainer{
            container.lblTitle.text = "Results"
            container.delegate = self
            container.btnEdit.isHidden = false
            container.btnEdit.isSelected = false
            self.isSelectionEnable = false
            self.resetAllListing()
            self.setDeleteButtonState()
            if(self.isFromMenu!){
                container.addBackIcon()
            }else{
                container.addBackIcon(isAddBack: true)
            }
        }
    }
    func actionCallBackMoveBack() {
        if(self.isFromMenu!){
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    func actionCallBackEnableImageSelection() {
        self.isSelectionEnable = true
        self.resetAllListing()
        self.setDeleteButtonState()
    }
    func actionCallBackDisableImageSelection() {
        self.isSelectionEnable = false
        self.resetAllListing()
        self.setDeleteButtonState()
    }
    
    func resetAllListing()  {
        if(self.results != nil){
            for item in self.results!{
                item.isSelected = false
            }
            self.tblResult.reloadData()
        }
    }
    func isAnyItemSelectedForDelete() -> Bool {
        if(self.results != nil){
            for item in self.results!{
                if(item.isSelected){
                    return true
                }
            }
        }
        return false
    }
    func setDeleteButtonState()  {
        if(self.isAnyItemSelectedForDelete()){
            self.btnDelete.isHidden = false
        }else{
            self.btnDelete.isHidden = true
        }
        
    }
    func deleteSelectedImages()  {
        var arrayOfPHAsset : [PHAsset] = []
        if(self.results != nil){
            for item in self.results!{
                if(item.isSelected){
                    arrayOfPHAsset.append(item.asset)
                }
            }
        }
        if(arrayOfPHAsset.count > 0){
            PHPhotoLibrary.shared().performChanges({
                let imageAssetToDelete = arrayOfPHAsset
                PHAssetChangeRequest.deleteAssets(imageAssetToDelete as NSFastEnumeration)
            }, completionHandler: {success, error in
                if(success){
                    var newList = [ImageViewModel]()
                    if(self.results != nil){
                        for obj in self.results!{
                            if(!obj.isSelected){
                                newList.append(obj)
                            }
                        }
                        self.results = newList
                    }
                    GCD.async(.Main, execute: {
                        self.tblResult.reloadData()
                        if let del = self.delegate{
                            del.actionCallBackUpdateList(images:newList)
                        }
                    })
                    
                }
            })
        }
    }
    
    @IBAction func actionDeleteImages(_ sender:UIButton){
        self.deleteSelectedImages()
    }
    

}

//MARK:- TableView Delegates
extension ResultViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.results{
            return list.count
        }
        return  0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ResultTableViewCell, for: indexPath) as? ResultTableViewCell
        
        
        cell?.configure(image: self.results![indexPath.row],isEnable: self.isSelectionEnable!)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if(self.isSelectionEnable!){
            if(self.results![indexPath.row].isSelected){
                self.results![indexPath.row].isSelected = false
            }else{
                self.results![indexPath.row].isSelected = true
            }
            self.tblResult.reloadData()
        }else{
            let storyboard = UIStoryboard(name:StoryboardName.Main, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.ResultPreviewViewController) as? ResultPreviewViewController{
                vc.imagesList = self.results
                vc.index = indexPath.row
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        self.setDeleteButtonState()
    }
        
        
}
