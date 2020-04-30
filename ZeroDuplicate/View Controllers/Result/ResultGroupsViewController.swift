//
//  ResultGroupsViewController.swift
//  ZeroDuplicate
//
//  Created by Rapidzz Macbook on 09/04/2019.
//  Copyright © 2019 trivalent. All rights reserved.
//

import UIKit
import Photos

protocol ResultGroupsControllerDelegate:NSObjectProtocol {
    func actionCallBackUpdateList()
}
class ResultGroupsViewController: BaseViewController,TopBarDelegate {

    @IBOutlet weak var tblResultGroup : UITableView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var btnDelete : UIButton!
    
    var imageArray = [UIImage]()
    var allPhotos : PHFetchResult<PHAsset>? = nil
    
    var isFromMenu:Bool? = false
    var searchResults:[Int:[ImageViewModel]]? = Global.shared.searchResults
    var selectedKey: Int?
    var isSelectionEnable:Bool? = false
    var delegate:ResultGroupsControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = "Groups"
        if let _ = self.searchResults{
            self.tblResultGroup.delegate = self
            self.tblResultGroup.dataSource = self
        }
        
        self.btnDelete.layer.cornerRadius = 35
        self.setDeleteButtonState()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let container = self.mainContainer{
            container.lblTitle.text = "Result Group"
            container.delegate = self
            container.btnEdit.isHidden = false
            container.btnEdit.isSelected = false
            self.isSelectionEnable = false
            self.resetAllListing()
            self.setDeleteButtonState()
            container.changeButtonColor(tag: 1)
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
        if(self.searchResults != nil){
            for key in Array(self.searchResults!.keys){
                let List = self.searchResults![key]!
                for item in List{
                    item.isSelected = false
                }
            }
            self.tblResultGroup.reloadData()
        }
    }
    func isAnyItemSelectedForDelete() -> Bool {
        for key in Array(self.searchResults!.keys){
            let List = self.searchResults![key]!
            for item in List{
                if(item.isSelected && item.isOrignal){
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
        var imagesUrls = [URL]()
        var keysList = [Int]()
        for key in Array(self.searchResults!.keys){
            let List = self.searchResults![key]!
            var isFound = false
            for item in List{
                if(item.isSelected && item.isOrignal){
                    isFound = true
                    keysList.append(key)
                    break
                }
            }
            if(isFound){
                for item in List{
                    arrayOfPHAsset.append(item.asset)
                    imagesUrls.append(URL.init(string: item.path)!)
                }
            }
        }
        if(keysList.count > 0){
            PHPhotoLibrary.shared().performChanges({
                let imageAssetToDelete = arrayOfPHAsset//PHAsset.fetchAssets(withALAssetURLs: imagesUrls , options: nil)
                PHAssetChangeRequest.deleteAssets(imageAssetToDelete as NSFastEnumeration)
            }, completionHandler: {success, error in
                if(success){
                    let keys = Array(self.searchResults!.keys)
                    var newList = [Int:[ImageViewModel]]()
                    for key in keys{
                        let list = self.searchResults![key]!
                        var isDeleted = false
                        for obj in list{
                            if(obj.isSelected && obj.isOrignal){
                                isDeleted = true
                            }
                        }
                        if(!isDeleted){
                            newList[key] = list
                        }
                        
                    }
                    Global.shared.searchResults = newList
                    self.searchResults = newList
                    GCD.async(.Main, execute: {
                        self.tblResultGroup.reloadData()
                        if let del = self.delegate{
                            del.actionCallBackUpdateList()
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
extension ResultGroupsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.searchResults{
            return list.keys.count
        }
        return  0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ResultTableViewCell, for: indexPath) as? ResultTableViewCell
        
        let key = Array(self.searchResults!.keys)[indexPath.row]
        
        
        cell?.configureImage(imagesList: self.searchResults![key]!,isEnable: self.isSelectionEnable!)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         let key = Array(self.searchResults!.keys)[indexPath.row]
        if let _ = self.searchResults![key]{
            return 95
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let key = Array(self.searchResults!.keys)[indexPath.row]
        if(self.isSelectionEnable!){
            let list = self.searchResults![key]!
            for item in list{
                if(item.isOrignal){
                    if(item.isSelected){
                        item.isSelected = false
                    }else{
                        item.isSelected = true
                    }
                }
            }
            self.tblResultGroup.reloadData()
        }else{
            let storyboard = UIStoryboard(name:StoryboardName.Main, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.ResultViewController) as? ResultViewController{
                vc.results = self.searchResults![key]!
                self.selectedKey = key
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        self.setDeleteButtonState()
        
    }
    
}
extension ResultGroupsViewController:ResultViewControllerDelegate{
    func actionCallBackUpdateList(images: [ImageViewModel]) {
        if(images.count == 0){
            self.searchResults![self.selectedKey!] = nil
            Global.shared.searchResults = self.searchResults!
        }else{
            self.searchResults![self.selectedKey!] = images
            Global.shared.searchResults = self.searchResults!
        }
        if let del = self.delegate{
            del.actionCallBackUpdateList()
        }
    }
}
