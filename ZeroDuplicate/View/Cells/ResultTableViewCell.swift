//
//  ResultGroupTableViewCell.swift
//  ZeroDuplicate
//
//  Created by Waqas Ahmad on 15/03/2019.
//  Copyright © 2019 trivalent. All rights reserved.
//

import UIKit
import Photos

class ResultTableViewCell: BaseTableViewCell {

    @IBOutlet weak var imgFile : UIImageView!
    @IBOutlet weak var lblFileName : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var lblSize : UILabel!
    @IBOutlet weak var lblPath : UILabel!
    @IBOutlet weak var lblViews : UILabel?
    @IBOutlet weak var lblPercentage : UILabel?
    @IBOutlet weak var lblResolution : UILabel!
    @IBOutlet weak var btnPreview : UIButton!
    @IBOutlet weak var viewPercentage : UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblViews?.layer.cornerRadius = 10
        self.btnPreview.isEnabled = false
    }

   
    func configureImage(imagesList:[ImageViewModel],isEnable:Bool)  {
        
        let imageVM = self.getOrignalImage(list: imagesList)
        self.lblFileName.text = imageVM.cameraName
        self.lblDate.text = "Created: " + imageVM.creationDate
        self.lblResolution.text = "Size: \(imageVM.width) X \(imageVM.height)"
        self.lblPath.text = "Path: " + imageVM.path
        //self.imgFile.image = imageVM.image
        
        if(imageVM.fetchedImage == nil){
            self.imgFile.fetchImage(asset: imageVM.asset, contentMode: .aspectFill, targetSize: self.imgFile.frame.size,imageVM: imageVM)
            imageVM.fetchedImage = self.imgFile.image ?? UIImage()
        }else{
            self.imgFile.image = imageVM.fetchedImage
        }
        
        self.lblViews?.text = "\(imagesList.count - 1)"
        if(isEnable && imageVM.isSelected){
            self.setBorderColor(view: self.imgFile, color: APPLICATION_THEME_COLOR, width: 3)
        }else{
            self.imgFile.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func configure(image : ImageViewModel,isEnable:Bool){
        if(image.isOrignal){
            self.lblPercentage?.text = "Original"
        }else{
            self.lblPercentage?.text = "\(Int(image.similarity))% match"
        }
        self.lblFileName.text = image.cameraName
        self.lblDate.text = "Created: " + image.creationDate
        self.lblResolution.text = "Size: \(image.width) X \(image.height)"
        self.lblPath.text = "Path: " + image.path
        
        if(image.fetchedImage == nil){
            self.imgFile.fetchImage(asset: image.asset, contentMode: .aspectFill, targetSize: self.imgFile.frame.size,imageVM: image)
            image.fetchedImage = self.imgFile.image ?? UIImage()
        }else{
            self.imgFile.image = image.fetchedImage
        }
        if(isEnable && image.isSelected){
            self.setBorderColor(view: self.imgFile, color: APPLICATION_THEME_COLOR, width: 3)
            self.viewPercentage?.backgroundColor = APPLICATION_THEME_COLOR
        }else{
            self.imgFile.layer.borderColor = UIColor.clear.cgColor
            self.viewPercentage?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    func getOrignalImage(list:[ImageViewModel]) -> ImageViewModel {
        
        for item in list{
            if(item.isOrignal){
                return item
            }
        }
        return ImageViewModel()
    }

}
extension UIImageView{
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize, imageVM:ImageViewModel) {
        let options = PHImageRequestOptions()
        options.version = .original
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, info in
            guard let image = image else { return }
            
            print(info)
            switch contentMode {
            case .aspectFill:
                self.contentMode = .scaleAspectFill
            case .aspectFit:
                self.contentMode = .scaleAspectFit
            }
            imageVM.fetchedImage = image
            self.image = image
        }
    }
    
}
